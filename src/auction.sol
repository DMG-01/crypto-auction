//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {auction} from "src/auctionEngine.sol";


contract placeAuction{
 uint256 _auction_range;
uint256 _auction_starting_price;
string  _auction_name;

    auction newAuction = new auction(_auction_range, _auction_starting_price, _auction_name) ;

}