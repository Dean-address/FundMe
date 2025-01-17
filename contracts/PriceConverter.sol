// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

        function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
              (,int price,,,) = priceFeed.latestRoundData();
              return uint256(price * 1e10);
        
    }
    function getConvertionRate(uint256 ethAmount) internal view returns (uint256){
        // ETHAMOUNT = 1 ETH
        uint256 ethPrice = getPrice(); // ETH PRICE == 2000_000000000000000000
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;// (2000_000000000000000000 * 1_000000000000000000) / 1e10
        return ethAmountInUsd;// $2000 = 1 ETH

    }
}