//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract EventContract {
 struct Event{
   address organizer;
   string name;
   uint date; 
   uint price;
   uint ticketCount;  
   uint ticketRemain;
 }


 mapping(uint=>Event) public events;
 mapping(address=>mapping(uint=>uint)) public tickets;
 uint public nextId;
 


 function createEvent(string memory name,uint date,uint price,uint ticketCount) external{
   require(date>block.timestamp,"You can organize event for future date");
   require(ticketCount>0,"You can organize event only if you create more than 0 tickets");
   
   events[nextId] = Event(msg.sender,name,date,price,ticketCount,ticketCount); // here msg.sender is the address organiser
   nextId++;
 }


 function buyTicket(uint id,uint quantity) external payable{
   require(events[id].date!=0,"Event does not exist");
   require(events[id].date>block.timestamp,"Event has already occured");
   Event storage _event = events[id];
   require(msg.value==(_event.price*quantity),"Ethere is not enough");
   require(_event.ticketRemain>=quantity,"Not enough tickets");
   _event.ticketRemain-=quantity;    // ticket r deducted from total tickets
   tickets[msg.sender][id]+=quantity; // ticket is added who bought the ticket


 }


 function transferTicket(uint id,uint quantity,address to) external{
   require(events[id].date!=0,"Event does not exist");
   require(events[id].date>block.timestamp,"Event has already occured");
   require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
   tickets[msg.sender][id]-=quantity;  // ticket r deducted from total tickets
   tickets[to][id]+=quantity;          // ticket is added to whom ticket has to transfer
 }
}


