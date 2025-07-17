// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Vault} from "src/Vault.sol";
import {console} from "forge-std/console.sol";

contract VaultSolution is Script {
    address target = 0x84483b7415119b1F79860b547e715295166b9dfC;
    Vault vaultInstance = Vault(target);
    uint256 slot = 1;

    function run() external {
        bytes32 value = vm.load(target, bytes32(slot));
        console.logBytes32(value);

        string memory decoded = string(abi.encodePacked(value));
        console.log(decoded);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vaultInstance.unlock(value);
        console.log(vaultInstance.locked());
        vm.stopBroadcast();
    }
}
