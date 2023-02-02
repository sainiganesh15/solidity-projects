//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFunding{
    mapping(address=>uint) public contributors; //by this we came to know which address has contributed and how much
    address public manager; 
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;
    
    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;  // this mapping will address the addressess of voters 
    }


    mapping(uint=>Request) public requests;  // different request will be indexed at different index
    uint public numRequests;
    constructor(uint _target,uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline; //10sec(block has initiated at this time) + 3600sec(60*60)(time period that this block should run)
        minimumContribution=100 wei;
        manager=msg.sender;
    }
    
    function sendEth() public payable{
        require(block.timestamp < deadline,"Deadline has passed");
        require(msg.value >=minimumContribution,"Minimum Contribution is not met");
        
        if(contributors[msg.sender]==0){  // this is written if contributer give contribution 2 time then it will counted as 1
            noOfContributors++;           // to add the number of contributer
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }


    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
        require(contributors[msg.sender]>0);
        address payable user=payable(msg.sender); // we r making this payable so that we can transfer the amount 
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;               // once the refund is claimed and he can't claim it again
        
    }


    modifier onlyManger(){
        require(msg.sender==manager,"Only manager can call this function");
        _;                                                                  // this is written after require means that first run the require than run the code 
    }


    function createRequests(string memory _description,address payable _recipient,uint _value) public onlyManger{
        Request storage newRequest = requests[numRequests];  // if u make mappingin struct then to use that variable u  have to use
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noOfVoters=0;
    }


    function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"YOu must be contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }


    function makePayment(uint _requestNo) public onlyManger{
        require(raisedAmount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.completed==false,"The request has been completed");  //this request is pointing towards struct
        require(thisRequest.noOfVoters > noOfContributors/2,"Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;                        // this tell that if manager wants funds to transfer same request again yhan this will not entertain
    }
}
