// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";
contract ExtraStorage is SimpleStorage        //--> Inheritance(is -> keyword)
{
    function store(uint x) public override
    {
        favor = x + 5;
    }
}