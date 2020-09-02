pragma solidity ^0.6.0;

contract Enumeration{
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    
    Status public status;//dafault element will be the first element in the definition of eum(Pending)
    
    function ship() public {
        require(status == Status.Pending);
        status = Status.Shipped;
    }
    function acceptDelivery() public{
         require(status == Status.Shipped);
         status = Status.Accepted;
    }
    function rejectDelivery() public{
         require(status == Status.Shipped);
         status = Status.Rejected;
    }
    function cancel() public {
         require(status == Status.Pending);
         status = Status.Canceled;
    }
    function reset() public{
        delete status;
    }
    function set(Status _status) public{
        status = _status;
    }
        
    
}
