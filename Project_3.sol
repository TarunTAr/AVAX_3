// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20_Token is ERC20, Ownable {

    uint public maxMintable;

   constructor() ERC20("TARUN", "TR") Ownable(msg.sender) {
    _mint(msg.sender, 100 * 5 ** decimals());
    maxMintable = 2000 * 5 ** decimals();
}

    function Token_mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Address not found");
        require(amount <= maxMintable, "Increase supply");
        _mint(to, amount);
        maxMintable -= amount;
    }

    function Token_burn(uint256 amount) external {
        _burn(msg.sender, amount);
        maxMintable += amount;
    }

    function Token_transfer(address to, uint256 amount) public  returns (bool) {
        require(to != address(0), "Insufficient Address");
        _transfer(msg.sender, to, amount);
        return true;
    }
}
