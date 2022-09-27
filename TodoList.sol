// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Insert, update, read from array of structs
contract TodoList {
    struct Todo {
        address owner;
        string text;
        bool completed;
    }

    Todo[] public todos;

    modifier checkOwner(uint _index) {
        require(msg.sender == todos[_index].owner, "Only owner can change");
        _;
    }

    //"Todo" struct creates
    function create(string calldata _text) external {
        todos.push(Todo({owner: msg.sender, text: _text, completed: false}));
    }

    //The "text" of "Todo" in the entered index updated. 
    //The owner of the struct can do the update
    function updateText(uint _index, string calldata _text) external checkOwner(_index) {
        //If we are going to do a single update, we can use
        todos[_index].text = _text;

        //If we are going to do multiple updates
        //Todo storage todo = todos[_index];
        //todo.text = _text;
    }

    //The "complete" of "Todo" in the entered index updated.
    //The owner of the struct can do the update
    function updateComlete(uint _index, bool _status) external checkOwner(_index) {
        todos[_index].completed = _status;
    }

    //The "Todo" in the entered index reads.
    //Everybody can read
    function get(uint _index) external view returns(string memory, bool) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }
}
