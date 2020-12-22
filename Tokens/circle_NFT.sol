// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Collectable {
    
    string public collectableCircleName;
    uint256 public circle_length;
    uint256 public members;
    address public Circleadmin;
    address payable lockerAddress;
    address[] public members_address;
    mapping(address => uint256) circles;
    
    function createCircle(string memory name,uint256 members_length) public 
    {
       collectableCircleName = name;
       circle_length = members_length;
       Circleadmin= msg.sender;
       members_address.push(msg.sender);
       lockerAddress = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
    }
    
    function JoinCircle() public {
        members += 1;
        members_address.push(msg.sender);
    }
    
    function getLocker() public view returns (address payable) {
        return lockerAddress;
    }
}
