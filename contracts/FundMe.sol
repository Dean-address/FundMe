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

    address public owner;
    constructor() {
        owner = msg.sender;
    }

    function fund() public payable  {
        // Allow users to send $
        // Have a minimum $ sent  $5
        // 1. How do we send ETH to this contract 
    require(msg.value.getConvertionRate() >= minimumUsd, "didn't send enough eth"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 8
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;

    }

    function withdraw() public onlyOwner{
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        //  actually withdraw the funds (transfer, send, call)
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, 'Send Failed');
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}('');
        require(callSuccess, 'Call Failed');

    }
    modifier  onlyOwner(){
        require(msg.sender == owner, 'Sender is not e owner');
        _;

    }
}