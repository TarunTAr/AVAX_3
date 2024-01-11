// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TR_Token {

    string public token_name;
    string public token_symbol;
    uint256 public totalsupply;
    mapping(address => uint256) public balance;
    address public owner;
    uint public max_mintable;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    constructor() {
        token_name = "TARUN";
        token_symbol = "TR";
        totalsupply = 100;
        max_mintable = 2000;
        owner = msg.sender;
    }

    function mint_Token(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Error");
        require(amount < max_mintable, "Exceed the maximum supply");
        totalsupply += amount;
        balance[to] += amount;
        max_mintable -= amount;
    }

    function burn_Token(uint256 amount) public {
        require(balance[msg.sender] >= amount, "Insufficient Balance");
        totalsupply -= amount;
        balance[msg.sender] -= amount;
        max_mintable += amount;
    }

    function transfer_Token(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Error");
        require(balance[msg.sender] >= amount, "Insufficient balance");
        balance[msg.sender] -= amount;
        balance[to] += amount;
        return true;
    }
}
