pragma solidity ^0.6.10;

contract Foo {
    string public name = "Foo";
}


//To import in another contract
pragma solidity ^0.6.10;


import "./Foo.sol";

contract Import {
    
    Foo public foo = new Foo();

   
    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}
