// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { auction } from "src/auctionEngine.sol";

contract deployScript is Script {
    uint256 public auctionRange;
    uint256 public auctionStartingPrice;
    string public auctionName;

    constructor(uint256 _auctionRange, uint256 _auctionStartingPrice, string memory _auctionName) {
        auctionRange = _auctionRange;
        auctionStartingPrice = _auctionStartingPrice;
        auctionName = _auctionName;
    }

    function run() external returns (auction) {
        vm.startBroadcast();
        auction Auction = new auction(auctionRange, auctionStartingPrice, auctionName);
        vm.stopBroadcast();
        return Auction;
    }
}
