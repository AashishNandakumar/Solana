// get funds from the users
// withdraw these funds
// set a min. funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    constructor()
    {
        i_owner = msg.sender; // it makes the the person who created the contract the owner, so only he can access the withdraw function

    }

    function fund()
        public
        payable
        // makes red colour, here smart contract can hold funds
    {
        // set a min. fund amount in USD
        // 1. How do we send ETH in the contract

        require(
            (msg.value.getConversionrate()) >= MINIMUM_USD,
            "Not enough man, cmmon"
        ); // in WEI
        //getConversionrate(msg.value);
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    function withdraw() public onlyOwner
    {
        
        for(uint256 i=0;i<funders.length;i++)
        {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
        // actually withdraw funds
    
        //msg.sender = address
        //payable(msg.sender) = payable address

        // transfer --> throws an error/reverrt back if not successful
            //payable(msg.sender).transfer(address(this).balance);
        // send --> returns a bool value if any problem occurs
            //bool sendSuccess = payable(msg.sender).send(address(this).balance);
            //require(sendSuccess, "FAILED MAN, CMMON");  // this state is mandatory 
        // call --> low level commands/ functions
        (bool callSuccess,/*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "CALL-FAILED");
    }
    modifier onlyOwner
    {
        //require(msg.sender == i_owner, "u are not the admin");
        if(msg.sender!=i_owner)
        {
            revert NotOwner();
        }
        _; // execute the rest of the program after checking the condition above
    }

    receive() external payable
    {
        fund();
    }
    fallback() external payable
    {
        fund();
    }

    // what happens if someone sends eth without calling the fund function


}
