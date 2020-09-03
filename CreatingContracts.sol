pragma solidity ^0.6.0;

contract Car{
    string public model;
    address public owner;
    
    constructor(string memory _model,address _owner) public payable
    {
        model = _model;
        owner= _owner;
    }
    
}

contract CarFactory{
    Car[] public cars;
    function Create(string memory _model) public{
        Car car = new Car(_model,address(this));
        cars.push(car);
    }
    function CreateAndEther(string memory _model,address _owner) public payable
    {
        Car car=(new Car).value(msg.value)(_model,_owner);
    }
}
