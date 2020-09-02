pragma solidity ^0.6.0;

contract Structs{
    
    struct Todo{
        string text;
        bool Completed;
    }
    
    Todo[] public todos;
    
    function create(string memory _text) public{
        todos.push(Todo(_text,false));
        
        //by key value mapping
          // Todo({
           //    text: _text;
           //    Completed:false;
           //})
    } 
    //we don't need this because solidity automatically creates getter
    function get(uint _index) public view returns (string memory text,bool Completed)
    {
        Todo storage todo=todos[_index];
        return(todo.text,todo.Completed);
    }
    //update the text of todo
    function update(uint _index,string memory _text) public
    {
        Todo storage todo=todos[_index];
        todo.text=_text;
    }
    //update status of Completed
    function togglecomplete(uint _index) public
    {
        Todo storage todo=todos[_index];
        todo.Completed=!todo.Completed;
    } 
    
}
