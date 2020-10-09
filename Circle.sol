pragma solidity ^0.7.0;

contract Circles{
    
        struct FriendsCircle {
        string name;
        address waddress;
        int balance;
    }
    struct Borrower{
        address borrower_public_key;
        string name;
        bool EXISTS;
    }
  
    /// This declares a state variable that stores a `FriendsCircle` struct for each possible address.
    mapping(address => FriendsCircle) public circle;
    mapping (address => uint) balances;
    
    mapping (address => Borrower) public borrowers;
    
    uint numApplications;
    uint numLoans;

    // mapping (uint => LoanApplication) public applications;
    //mapping (uint => Loan) public loans;

    mapping(address => bool) hasOngoingLoan;
    mapping(address => bool) hasOngoingApplication;
    mapping(address => bool) hasOngoingInvestment;

    function createBorrower(string memory name) public {
        Borrower memory borrower;
        borrower.name = name;
        borrower.borrower_public_key = msg.sender;
        borrower.EXISTS = true;
        //require (investors[msg.sender].EXISTS != true);
        borrowers[msg.sender] = borrower;
        // borrowerArray[borrowerArray.length] = borrower.borrower_public_key;
        hasOngoingLoan[msg.sender] = false;
        hasOngoingApplication[msg.sender] = false;
        balances[msg.sender] = 0; // Init balance
    }
    
    function createFriendsCircle(string memory _name, address _waddress) public {
        require (borrowers[msg.sender].EXISTS == true);
        require(_waddress != circle[_waddress].waddress); //only one address per person
        FriendsCircle memory friendscircle = FriendsCircle({name: _name, waddress: _waddress, balance: 0});
        circle[_waddress] = friendscircle;
    }
 
    function isFriendCircle(address _waddress) public view returns (bool) {
        if (_waddress == circle[_waddress].waddress) {
            return true;
        }else {
            return false;
        }
    }
    function viewBalance() public view returns (uint256){
        return balances[msg.sender];
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
    function withdraw(uint amount) public payable returns(uint) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        return amount;
    }
    function transfer(address taker, uint amount) public payable{
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[taker] += amount;
    }
    
        
        
}
    
   


