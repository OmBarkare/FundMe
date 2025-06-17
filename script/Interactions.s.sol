// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {GetLatestContract} from "./GetLatestContract.s.sol";

contract FundFundMeInteractor is Script {

    uint256 constant SEND_VALUE = 0.01 ether;

    function sendFundsToFundMe(address _mostRecentlyDeployed) public {
        FundMe(payable(_mostRecentlyDeployed)).fund{value: SEND_VALUE}();
    }

    function run() external {
        // address mostRecentlyDeployed = 0x781B417E28B43a004143Cbbb3845eaf72FA41108;
        GetLatestContract getLatestContract = new GetLatestContract();
        address mostRecentlyDeployed = getLatestContract.getLatestContractAddress();
        console.log(mostRecentlyDeployed);
        vm.startBroadcast();
        sendFundsToFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMeInteractor is Script {
    

    function withdrawFundsFromFundMe(address _mostRecentlyDeployed) public {
        FundMe(payable(_mostRecentlyDeployed)).withdraw();
    }

    function run() external {
        address mostRecentlyDeployed = 0x781B417E28B43a004143Cbbb3845eaf72FA41108;
        vm.startBroadcast();
        withdrawFundsFromFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}