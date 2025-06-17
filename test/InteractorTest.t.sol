// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMeInteractor is Script {

    uint256 constant SEND_VALUE = 5e18;

    function sendFundsToFundMe(address _mostRecentlyDeployed) public {
        vm.prank(msg.sender);
        FundMe(payable(_mostRecentlyDeployed)).fund{value: SEND_VALUE}();
    }
}

contract WithdrawFundMeInteractor is Script {
    function withdrawFundsFromFundMe(address _mostRecentlyDeployed) external {
        vm.prank(msg.sender);
        FundMe(payable(_mostRecentlyDeployed)).withdraw();
    }
}