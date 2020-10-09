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

    struct LoanApplication {
        bool openApp;
        uint applicationId;
        
        string title;
        uint duration;// In months
        uint interest_rate;
        uint amount;// Loan amount
        address borrower; 
        address[] payees; 
        // mapping(address => bool) agreements; 
    }
     //Loan[] public loans;
  
    /// This declares a state variable that stores a `FriendsCircle` struct for each possible address.
    mapping(address => FriendsCircle) public circle;
    mapping (address => uint) balances;
    
    mapping (address => Borrower) public borrowers;
    
    uint numApplications;
    uint numLoans;
    
    mapping(address => bool) agreements;
    mapping (uint => LoanApplication) public applications;
    // mapping (uint => Loan) public loans;

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
    

    
    function initiateLoan(string memory _title, uint duration,uint interest_rate,uint _amount, address[] memory _payees) public {
        require(_amount > 0);
        require(_payees.length > 0 && _payees.length <= 20);
        require(msg.sender == borrowers[msg.sender].borrower_public_key);
        require(isloancircle(_payees));
        
        applications[numApplications]= LoanApplication(true,numApplications,_title,duration,interest_rate ,_amount, msg.sender, _payees);
        // loans.push(loan);
        numApplications += 1;
        hasOngoingApplication[msg.sender] = true;
    }
    
    function isloancircle(address[] memory list) public view returns (bool) {
        for (uint i = 0; i < list.length; i++) {
            if (!isFriendCircle(list[i])) {
                return false;
            }
        }
        return true;
    }
    function setAgreement(address _waddress) public returns (bool) {
  
        agreements[ _waddress] =  true ;
        return true;
      
    }
    
    
    function getNumApplications() public view returns  (uint) { return numApplications;}
    function getNumLoans() public view returns (uint) { return numLoans;}
    function isBorrower(address account) public view returns (bool) {return borrowers[account].EXISTS;}
    function getTime() public  view returns (uint){return block.timestamp;}
    
        
        
}
    
   


