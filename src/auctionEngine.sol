//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;


contract auction {
          /****ERRORS */
error notEnoughFeeToPlaceAuction();
error youDontMeetTheCriteriaToPlaceBid();
error youCannotCallThisFunction();
          /****EVENTS */
event auctionPlaced(uint256 range, uint256 startingPrice, string name); 
event currentBidLeader(address highestBidder, uint256 Amount); 
        
          /****VARIABLES */
uint256 constant public AUCTION_FEE = 0.005 ether;
uint256 highestBid;
address highestBidder;
uint256 auctionStartingPrice;
uint256 auctionRange;
address currentHighestBidder;
string name;
mapping(address => uint256) otherBidders;
address public contractOwner;


/*********MODIFIER   */
modifier onlyOwner{
  if(msg.sender != contractOwner){
    revert youCannotCallThisFunction();
  }
  _;
}
/*****FUNCTIONS */  


 constructor(uint256 auction_range, uint256 auction_starting_price, string memory auction_name ) payable{
if(msg.value < AUCTION_FEE){
    revert notEnoughFeeToPlaceAuction();
}
else {
payable(address(this)).transfer(msg.value);
highestBid = auction_starting_price;
highestBidder = msg.sender;
auctionStartingPrice = auction_starting_price;
auctionRange = auction_range;
name = auction_name;  
contractOwner = msg.sender;
}
}
// would take a new bid parameter
function bid() public payable {
   if( (msg.value < highestBid) && ((block.timestamp > auctionRange)||(block.timestamp < auctionRange) )){
     revert youDontMeetTheCriteriaToPlaceBid();
   }
   else {
    otherBidders[highestBidder] += highestBid;

    highestBid = msg.value;
    highestBidder = msg.sender;

    emit currentBidLeader(msg.sender,msg.value);
   }  
    
   }

function pickWinner() public onlyOwner{
    if(auctionRange > block.timestamp){
      payable(address(contractOwner)).transfer(highestBid);
    }
}

function returnFund() private{
uint totalFailedBid = otherBidders[msg.sender];
    otherBidders[msg.sender] = 0;
    payable(msg.sender).transfer(totalFailedBid);
}

 /*********GETTER FUNCTION */
 function getAuctionFee() public pure returns(uint256){
  return AUCTION_FEE;
 }

}