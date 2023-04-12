// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory
{
    SimpleStorage[] public simpleStorageArray;  // creating a variable of type SimpleStorage

    function createSimpleStorageContract() public
    {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 index, uint256 num) public
    {
        simpleStorageArray[index].store(num);
    }

    function sfGet(uint256 index) public view returns(uint256)
    {
        return simpleStorageArray[index].retrieve();
    }
}