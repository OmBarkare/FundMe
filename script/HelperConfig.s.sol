// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {

    struct NetworkConfig {
        address priceFeed;
    }
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMAL = 8;
    int256 public constant INITIAL_PRICE = 2700e8;

    constructor() {
        if(block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else if(block.chainid == 1) {
            activeNetworkConfig = getMainnetaEthConfig();
        }
        else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() internal pure returns(NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
        return sepoliaConfig;
    }

    function getMainnetaEthConfig() internal pure returns(NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
            });
        return sepoliaConfig;
    }

    function getAnvilEthConfig() internal returns(NetworkConfig memory) {

        if(activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMAL, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });

        return anvilConfig;
    }
}