# Solidity
Introduction to solidity with examples
Basic solidity programs
## Logic for Lending.sol

# Common Functions for both Borrower and Investor

ViewBalance -> returns current balance

Deposit(amount) -> credits amounts

Withdraw(amount) -> debit amount from that address

Transfer( to_address,amount) -> Transfer amount from current address to a particular address

gettime -> returns block.timestamp

isinvestor -> return true for investor address

isBorrower -> returns true for borrower address

getNumApplications -> returns no.of applications (act as counters)

getNumLoanns -> return no.of loans processing in that particular deployed contract



# Borrower
1. Create Borrower by giving a name of the borrower

2.Create Loan Application (duration,interest_rate,credit_amount,other_data)

Once created app id will be incremented,ongoing applications will be set true

it should satisfy three conditions

        require(hasOngoingLoan[msg.sender] == false);
        
        require(hasOngoingApplication[msg.sender] == false);
        
        require(isBorrower(msg.sender));

getApplicationdata -> returns data of create loan application 


# Investor

1.create Investor by giving name

2.grant loan by giving app id

This will transfer the amount requested by the borrower

if grant loan in success then hasOngoingInvestment will become true for investor
 
getLoandata -> returns the loan data


