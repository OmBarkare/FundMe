// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundFundMeInteractor, WithdrawFundMeInteractor} from "./InteractorTest.t.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract InteractionsTest is Test{
    FundMe fundMe;
    FundFundMeInteractor fundInteractor;
    WithdrawFundMeInteractor withdrawInteractor;

    address USER = makeAddr("champu");
    uint256 constant USER_MONEY = 10e18;
    uint256 constant SEND_VALUE = 5e18;

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        fundMe = deployer.run();
    }

    function test_userCanFundWithInteractions() external {
        //Preparations
        fundInteractor = new FundFundMeInteractor();
        vm.deal(USER, USER_MONEY);


        //simulation
        vm.prank(USER);
        fundInteractor.sendFundsToFundMe(address(fundMe));

        //Assertion
        assertEq(fundMe.getFunderAddressFromIndex(0), USER);
        // assertEq(address(fundMe), DevOpsTools.get_most_recent_deployment("FundMe", block.chainid));
    }

    function test_withdrawFundMe() external {
        //Preparations
        withdrawInteractor = new WithdrawFundMeInteractor();
        vm.deal(USER, USER_MONEY);
        uint256 ownerBalanceBeforeWithdraw = fundMe.getOwner().balance;
        uint256 fundMeBalanceBeforeWithdraw = address(fundMe).balance;
        //simulation
        vm.prank(USER);
        vm.expectRevert();
        withdrawInteractor.withdrawFundsFromFundMe(address(fundMe));

        uint256 ownerBalanceAfterWithdraw = fundMe.getOwner().balance;
        assertEq(address(fundMe).balance, 0);
        assertEq(ownerBalanceBeforeWithdraw + fundMeBalanceBeforeWithdraw, ownerBalanceAfterWithdraw);
    }

}