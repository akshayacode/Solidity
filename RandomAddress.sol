pragma solidity ^0.4.25;

contract Random{
    
   function uinqueaddress() public view returns(address){
       
       address addr = address(keccak256(abi.encodePacked(now)));
        return address(addr);
   } 

    
}
