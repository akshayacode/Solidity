pragma solidity ^0.7.0;

contract Random{
    
   function uinqueaddress() public view returns(address){
       
       //address addr = address(keccak256(abi.encodePacked(now))); (for sol 0.4.25)
       
       address addr = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));

        return address(addr);
   } 

    
}
