//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;

contract CirclesContract {
    
    struct Circle{
        string name;
        address manager;
        address locker;
        address[] participants;
        uint circleLimit;
    }
    
    struct Borrower{
        address borrower;
        mapping(uint => Circle) circles;
    }
    
    mapping(uint => Borrower) public borrwers;
    
    function createCircle(uint index,uint id) public{
        borrwers[index].borrower = msg.sender;
        borrwers[index].circles[id].name="family";
        borrwers[index].circles[id].manager = msg.sender;
        borrwers[index].circles[id].locker = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
    }
    
    function joincircle(uint index,uint id) public {
        borrwers[index].circles[id].participants.push(msg.sender);
    }
    function getter(uint index,uint id) public view returns(string memory,address,address[] memory) {
        return(borrwers[index].circles[id].name,borrwers[index].circles[id].manager,borrwers[index].circles[id].participants);
    }
}
