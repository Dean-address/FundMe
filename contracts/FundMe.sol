// Get Funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded)  public addressToAmountFunded;

    function fund() public payable  {
        // Allow users to send $
        // Have a minimum $ sent  $5
        // 1. How do we send ETH to this contract 
    require(getConvertionRate(msg.value) >= minimumUsd, "didn't send enough eth"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 8
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
              (,int price,,,) = priceFeed.latestRoundData();
              return uint256(price * 1e10);
        
    }
    function getConvertionRate(uint256 ethAmount) public view returns (uint256){
        // ETHAMOUNT = 1 ETH
        uint256 ethPrice = getPrice(); // ETH PRICE == 2000_000000000000000000
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;// (2000_000000000000000000 * 1_000000000000000000) / 1e10
        return ethAmountInUsd;// $2000 = 1 ETH

    }
    function withdraw() public {}
}