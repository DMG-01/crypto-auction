//SPDX-License-Identifier:MIT
pragma solidity^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {auction} from "src/auctionEngine.sol";
import {deployScript} from "script/auctionDeployScript.s.sol";

contract auctionTest is Test {

auction public Auction;
address public USER = makeAddr("user");


   function setUp() external {
    deployScript deployer = new deployScript(999999999999, 0, "Example Auction"); // Provide actual values
    Auction = deployer.run();
}


    function testAuctionFee() public {
       assertEq(Auction.getAuctionFee(),0.005 ether);
       //console.log(Auction.getAuctionFee());
    } 
    
}