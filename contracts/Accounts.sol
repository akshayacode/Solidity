//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;


contract Accounts{
    
    mapping (address => uint) public balances;
    
    function viewBalance() public view returns (uint256){
        return balances[msg.sender];
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
    function withdraw(address addr,uint amount) public payable {
        require(amount <= balances[addr]);
        balances[addr] -= amount;
        // return amount;
    }
    function transfer(address taker, uint amount) public payable{
        // require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[taker] += amount;
    }
}
