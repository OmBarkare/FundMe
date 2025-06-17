//SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("champu");
    uint256 constant USER_MONEY = 10e18; 
    uint256 constant SEND_VALUE = 5e18;
    uint256 constant GAS_PRICE = 1;

    DeployFundMe deploy;
    function setUp() external {
        deploy = new DeployFundMe();
        fundMe = deploy.run();
    }

    function test_minimumUsdIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function test_ownerOfFundme() external view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function test_aggregatorVerison() external view {
        assertEq(fundMe.getVersion(), 4);
    }

    function test_fundFailsWithNotEnoughEth() external {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded {
        vm.deal(USER, USER_MONEY);
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function test_fundWithValueUpdatesFunderAmount() external funded {
        assertEq(fundMe.getAmountFromAddress(USER), SEND_VALUE);
    }

    function test_addFunderToArray() external funded {
        address addressAtZero = fundMe.getFunderAddressFromIndex(0);
        assertEq(addressAtZero, USER);
    }

    function test_withdrawSuccessfulWithOwner() external funded {
        //Arrange
        uint256 balanceBeforWithdraw = address(fundMe).balance;
        uint256 startOwnerBalance = fundMe.getOwner().balance;
        vm.txGasPrice(GAS_PRICE);

        //Act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        uint256 balanceAfterWithdraw = address(fundMe).balance;
        uint256 endOwnerBalance = fundMe.getOwner().balance;

        //Assert
        assertEq(balanceAfterWithdraw, 0);
        assertEq(endOwnerBalance, startOwnerBalance + balanceBeforWithdraw);
    }

    function test_withdrawRevertsIfNotOwner() external funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function test_withdrawFromMultipleFunders() external {
        uint160 lastFunderNumber = 10;
        uint160 firstFunderNumber = 1;
        uint256 recievedFunding = 0;
        for(uint256 i = firstFunderNumber; i < lastFunderNumber; i++) {
            hoax(address(uint160(i)), USER_MONEY);
            fundMe.fund{value: SEND_VALUE}();
            recievedFunding += SEND_VALUE;
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        uint256 endingOwnerBalance = fundMe.getOwner().balance;

        uint withdrawnFunding = endingOwnerBalance - startingOwnerBalance;
        assertEq(withdrawnFunding, recievedFunding);
        assertEq(address(fundMe).balance, 0);
    }
}