// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Token} from "src/Token.sol";
import {console} from "forge-std/console.sol";

contract TokenSolution is Script {
    Token token = Token(0x238a1e16EA1B924D128033483C7731665628268D);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        token.transfer(address(1), 21);
        console.log("My balance: ", token.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}
