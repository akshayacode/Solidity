//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Structure {
    struct Members{
        address adr;
        uint num;
        One one ;
        Status status;
        mapping(address => bool) agree;
        
    }
    mapping(uint => Members) public contact;
    struct One{
        string name;
        uint id;
    }
    
    enum Status{
        Completed,
        Pending
    }
    
    function agree(uint index) public {
        contact[index].agree[msg.sender] = true;
    }
    
    function set(uint index) public {
        contact[index].adr = msg.sender;
        contact[index].num = 3;
    }
    
    function setOne(uint index) public {
        contact[index].one.name = "achu";
    }
}
