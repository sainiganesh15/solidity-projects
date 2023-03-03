
# CrowdFunding Smart Contract

This is a simple implementation of a crowdfunding smart contract written in Solidity language. The contract allows contributors to send funds to a campaign and create requests for payments that can be approved by the manager of the campaign.

## Contract Details

#### The contract contains the following properties:

- `contributors`: a mapping that keeps track of the contributions made by each contributor.
- `manager`: the address of the manager who can create requests and approve payments.
- `minimumContribution`: the minimum amount of ether required to contribute to the campaign.
- `deadline`: the deadline for the campaign in UNIX timestamp format.
- `target`: the target amount of ether to be raised in the campaign.
- `raisedAmount`: the amount of ether raised in the campaign.
- `noOfContributors`: the number of unique contributors who have contributed to the campaign.
- `requests`: a mapping that keeps track of all payment requests made by the manager.

#### The contract contains the following functions:

- `sendEth()`: a function that allows contributors to send ether to the campaign.
- `getContractBalance()`: a function that returns the balance of the contract in ether.
- `refund()`: a function that allows contributors to request a refund if the campaign fails.
- `createRequests()`: a function that allows the manager to create payment requests.
- `voteRequest()`: a function that allows contributors to vote on payment requests.
- `makePayment()`: a function that allows the manager to approve payment requests and transfer funds.

## License

This smart contract is licensed under the MIT license





# Event Organization Smart Contract

A smart contract built on Ethereum blockchain for managing events and ticket sales.
## Features

- Create an event with a name, date, ticket price and ticket count
- Purchase tickets for an event
- Transfer tickets to another address

## Functions

- `createEvent(string memory name,uint date,uint price,uint ticketCount) external`: Creates a new event with the specified name, date, ticket price and ticket count. The `date` parameter must be greater than the current block timestamp and the `ticketCount` parameter must be greater than zero.
- `buyTicket(uint id,uint quantity) external payable`: Purchases 
- `quantity` tickets for the event with the specified `id`. The function requires the payment of `quantity` times the ticket price in Ether and checks that there are enough tickets remaining for the event.
- `transferTicket(uint id,uint quantity,address to) external`: Transfers `quantity` tickets for the event with the specified `id` to the specified address `to`. The function checks that the caller has enough tickets to transfer.

## Data Structures

- `Event`: A struct representing an event with the following fields:

 organizer: The address of the organizer of the event.
name: The name of the event.
date: The date of the event as a Unix timestamp.
price: The price of a ticket in Ether.
ticketCount: The total number of tickets available for the event.
ticketRemain: The number of tickets remaining for the event.
events: A mapping of event IDs to Event structs.

tickets: A nested mapping of addresses to event IDs to the number of tickets owned by that address for that event.

# Lottery Smart Contract

This is a Lottery Smart Contract written in Solidity language. The contract allows users to participate in a lottery by sending a fixed amount of ether. Once the required number of participants is reached, the contract randomly selects a winner and sends the entire balance of the contract to the winner's address.

## How to Participate

To participate in the lottery, send 0.1 ether to the contract address. You can do this by calling the `receive()` function of the contract.

## How to Check the Contract Balance
Only the contract manager can check the balance of the contract. To check the balance, call the `getBalance()` function of the contract.

## How the Winner is Selected

Only the contract manager can select the winner. To select the winner, call the `selectWinner()` function of the contract. This function checks if the contract has at least 3 participants and selects a winner using the `random()` function. The entire balance of the contract is then sent to the winner's address.


## License
This contract is licensed under the MIT License.
