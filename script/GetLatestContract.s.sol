// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import "forge-std/StdJson.sol";

contract GetLatestContract is Script{

    function getLatestContractAddress() public view returns(address) {
        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/broadcast/DeployFundMe.s.sol/",vm.toString(block.chainid), "/run-latest.json");
        string memory json = vm.readFile(path);
        bytes memory data = vm.parseJson(json, ".transactions[0].contractAddress");

        address contractAddress = abi.decode(data, (address));

        return contractAddress;
    }
}
