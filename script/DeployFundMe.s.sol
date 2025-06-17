// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig();
        address priceFeedAddress = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundMe = new FundMe(priceFeedAddress);
        vm.stopBroadcast();
        return fundMe;
    }
}