// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract Ownable{
   address owner;
    //@dev modifer allowing only owner of contract
    modifier onlyOwner(){
        require(msg.sender == owner,   "not working");
        _;
    }

    constructor() public {
    owner = msg.sender;
  }
}