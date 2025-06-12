// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Solution is Script {
    Level0 public level0 = Level0(0x9004A8F6EB8a7883747FBbccf5b92d7AEA437783);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        string memory password = level0.password();
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}
