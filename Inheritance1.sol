pragma solidity ^0.6.0;


contract A{
    string public name;
    constructor(string memory _name) public{
        name = _name;
    }
}

contract B is A {
    constructor(string memory _name) A(_name) public{
        
    }
    
}
    
