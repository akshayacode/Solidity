//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;


contract Accounts{
    
    mapping (address => uint) public balances;
    
    function viewBalance(address addr) public view returns (uint256){
        return balances[addr];
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
    function withdraw(address addr,uint amount) public payable {
        require(amount <= balances[addr]);
        balances[addr] -= amount;
        // return amount;
    }
    function transfer(address giver,address taker, uint amount) public payable{
        require(balances[giver] >= amount);
        balances[giver] -= amount;
        balances[taker] += amount;
    }
}
