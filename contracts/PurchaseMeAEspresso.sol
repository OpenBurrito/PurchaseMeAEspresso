// SPDX=License-Identifier: MIT
pragma solidity ^0.8.17

import "hardhat/console.sol";

contract PurchaseMeAExpresso {

    struct Coffee {
        address: supporter;
        string message;
        string name;
        unit256 amount;
        unit256 timestamp;
    }

    Coffee[] coffee;

    address payable public owner;

    constructor() payable {
        console.log("initialize smart contract");

        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _message, string memory _name) public payable {
        require(msg.value >= msg.value, "You don't have enough ETH");

        coffee.push(Coffee(msg.sender, _message, _name, msg.value, block.timestamp));
    }

    function getAllCoffee() public view returns (Coffee[] memory) {
        return coffee;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public {
        // throw an error if the caller is not the owner
        require(msg.sender == owner, "You are not the owner");

        uint256 balance = address(this).balance;
        require (balance > 0, "There is no balance to withdraw");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Failed to withdraw balance");

        //payable(msg.sender).transfer(balance);
    }
}
