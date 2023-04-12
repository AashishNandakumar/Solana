// SPDX-License-Identifier: MIT   //--> least restrictive license
pragma solidity ^0.8.7; // any version of solidity 0.8.7 and above would work

// EVM , Ethereum virtual machine

contract SimpleStorage {  // --> like class in oop languages
    // boolean, uint, int, address, bytes -->datatypes

    uint256 favor; // gets initialized to zero and not any garbage value
    // default is internal
    // People public person = People({favorno: 2, name: "ash"});

    mapping(string=>uint256) public nameTOfavorno; // name will be mapped to a single uint

    struct People {
        uint256 FavorNum;
        string name;
    }
    // uint256[] public favorno
    People[] public people; // arrays or lists

    // a place to store parameters --> calldata, memory, storage(others are there)
    function addPerson(string memory n, uint256 num) public 
    {
        //n = "cat"; --> can overwrite only for memory and not calldata
        People memory Person = People({FavorNum: num, name: n});
        people.push(Person); // means u are adding Person to struct People
        nameTOfavorno[n] = num;
    }

    function store(uint256 x) public virtual {
        favor = x;
        
    }

    // view and pure functions donot spend any gas
    function retrieve() public view returns (uint256) {
        return favor;
    }

    // function add() public pure returns (uint256) {
    //     return (1 + 1);
    // }
}
