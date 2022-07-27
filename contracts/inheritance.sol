// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract inheritance {
    // a state vaiables declaration
    address public chairman; //address of the chairman who wants to put down his inheritance
    uint public amount; // amount to deposit in the address
    bool public deceased; //bool call that shows if he's dead, resulting to true/false

    constructor () payable {
        chairman = msg.sender; //The initiator of the contract address
        amount = msg.value; //amount to store in the contract 
        deceased = false; //At the moment of contract, the chairman is still alive
    }
    modifier onlychairman() {
        require(chairman == msg.sender); //only the initiator/chairman can call the function
        _;
    }
    modifier isdesecesed () {
        require(deceased == true);  //when the chairman is deceased
        _;
    }
    address payable[] familyaccount; //payable address of family to be paid 
    mapping(address => uint) inherit; //map the address of the family to inherit 
    //func of inre
    function sendInheritance(address payable Wallet, uint Amount) public onlychairman {
        familyaccount.push(Wallet);
        inherit[Wallet] = Amount;

    }
    function alreadydeceased() public onlychairman {
        deceased = true;
        payout();
    }
    function payout() private {
        for (uint i = 0; i < familyaccount.length; i++)
        { familyaccount[i].transfer(inherit[familyaccount[i]]);
        }
    }



}