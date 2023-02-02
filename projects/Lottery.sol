//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Lottery{

    address payable[] public players; //this is made address type because it will store the address
    address public manager;

    constructor(){
        manager = msg.sender; // msg.sender is the global variable through which we r transferring address of this contract to manager
                              // msg.sender is the address that has called or initiated a function or created a transaction
    }

    receive () payable external{
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager,"You are not the managerr");
        return address(this).balance;
    }

    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length))); //here uint is used to convert into integer
    }


    function selectWinner() public{
        
        require(msg.sender == manager);
        require (players.length >= 3);
        uint r = random();
        address payable winner;
        uint index = r % players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);  // this line is written b/c once the winner is selected dynamic array become blank and lottery system start again 
    }

}


