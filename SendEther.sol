pragma solidity ^0.6.0;

contract ReceiveEther{
     receive() external payable{
    }
    function getbalance() public view returns(uint)
    {
        return address(this).balance;
    }
}

contract SendEther{
    function sendViaTransfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable{
        bool sent = _to.send(msg.value);
        require(sent,"Failed to send Ether");
    }
    function sendviaCall(address payable _to) public payable{
        (bool sent,bytes memory data) = _to.call.value(msg.value)("");
        require(sent,"Failed to send Ether");
        
    }
}
