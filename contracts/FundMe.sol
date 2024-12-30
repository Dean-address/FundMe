// Get Funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from './PriceConverter.sol';

contract FundMe{
    using  PriceConverter for uint256;
    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded)  public addressToAmountFunded;

    function fund() public payable  {
        // Allow users to send $
        // Have a minimum $ sent  $5
        // 1. How do we send ETH to this contract 
    require(msg.value.getConvertionRate() >= minimumUsd, "didn't send enough eth"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 8
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }

    function withdraw() public {}
}