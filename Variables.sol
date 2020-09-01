pragma solidity ^0.6.10;

contract Variables {
    // State varaibles are declared outside a function, stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public {
        // Local variables are declared inside a function not saved to the blockchain.
        uint i = 456;

        //  global variables - provides information about blockchain
        uint  timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller
    }
}
