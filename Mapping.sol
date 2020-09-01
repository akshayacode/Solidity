pragma solidity >=0.4.22 <0.7.0;

contract Mapping{
     //mapping
     mapping(uint => string) public names;
     mapping(uint => Book) public books;
     //Nested mapping
     mapping(address =>mapping(uint => Book)) public nestedmap;
     
     struct Book{
         string title;
         string author;
     }
     
     constructor() public
     {
         names[1] = "ADAM";
         names[2] = "Bruce";
         names[3] = "Carl";
      }
      
      //Mapping function
      function addBook(uint _id,string memory _title,string  memory _author) public {
          books[_id] = Book(_title,_author);
      }
      
      //Function to add Nested Mapping 
      function addMyBook(uint _id,string memory _title,string memory _author) public{
          nestedmap[msg.sender][_id] = Book(_title,_author);
      }
}
