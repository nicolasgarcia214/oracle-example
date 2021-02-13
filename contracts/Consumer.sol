// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.3;

import './IOracle.sol'

contract Consumer {
    IOracle public oracle;

    constructor(address _oracle){
        oracle = IOracle(_oracle);
    }

    function foo() external{
        bytes32 key = keccak256(abi.encodePacked("BTC/USD"));

        (bool result, uint timestamp, uint data) = oracle.getData(key);
        require(result == true, "Could not get price");
        require(timestamp >= block.timestamp - 2 minuter, "price to old");
    }
}