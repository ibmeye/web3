pragma solidity >=0.4.25 <0.9.0;

contract HelloBlockchain {

    string public message;

    constructor(string memory _message) {
        message = _message;
    }

    // call this function to send a request
    function setMessage(string memory _message) public {
        message = _message;
    }

    // call this function to send a response
    function getMessage() public view returns (string memory) {
        return message;
    }
}