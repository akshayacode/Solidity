pragma solidity ^0.6.10;


contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

contract D is B,C {
    // D.foo() return c bcoz it is the right Most
    function foo() public pure virtual override(B,C) returns (string memory) {
        return super.foo();
    }
}
