// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract CashManagement {


    address public admin;
    
    constructor () {
        admin = payable(msg.sender);

    }

    //Log record of # transaction
   struct LogTransaction {
       uint logDeposit;
       uint logBuy;
       uint logSell;
       uint logWith;
   }  


    mapping(address => LogTransaction) public logtransaction;

    
    //client data structure
    struct ClientData {
        bool alreadyclient;
        address client;
        string clientName;
        string clientCode;
        string bankRDN ;
        uint balRDN;
    }
   
    mapping(address => ClientData ) public clientdata;


    //DATA ENTRY FUNCTION
    //function for client data entry
    //Only Administration Officer or Custodian Staff (user) who can entry the client master database.
    //Data entry function will notify user when the client already registered in database.
    function a_registerClient(address _clientAddress, string memory _clientName, string memory _clientCode,string  memory _bankRDN, uint _balRDN) public {
        require(admin == msg.sender, "Only Admin Can Register New Client");
        require(clientdata[_clientAddress].alreadyclient == false , "Client already exist.");
        clientdata[_clientAddress].client = _clientAddress;
        clientdata[_clientAddress].clientName = _clientName;
        clientdata[_clientAddress].clientCode = _clientCode;
        clientdata[_clientAddress].bankRDN = _bankRDN;
        clientdata[_clientAddress].balRDN = _balRDN;
        clientdata[_clientAddress].alreadyclient= true;
    }


    //DEPOSIT FUNCTION
    //function to facilitate client to entry deposit as initial balance & top up balance
    //Only client who can entry/transfer fund deposit to RDN Account
    function deposit(address _clientAddress) public payable {
        require(msg.sender == clientdata[_clientAddress].client, "Only Client Can Deposit");
        clientdata[msg.sender].balRDN += msg.value;
        logtransaction[_clientAddress].logDeposit++;
    }


    //CHECK BALANCE FUNCTION
    //function for checking client cash position or efective cash balance
    function getBalance(address _clientAddress) public view returns (uint _balRDN) {
        require(msg.sender == clientdata[_clientAddress].client, "Only Client Can Check Balance");
        return clientdata[msg.sender].balRDN;
    }

    //BUY FUNCTION
    //function to manage client cash position after order buy (assumption all order is spot order)
    //Only client who can entry BUY transaction, which will debit fund from RDN accaount.
    //System will reject BUY transaction if the transaction value of BUY is bigger than available fund at RDN account

    function Buyposition(address _clientAddress, uint amount) public payable {
        require(msg.sender == clientdata[_clientAddress].client, "Only Client Can Entry Buy Transaction");
        require(clientdata[msg.sender].balRDN >= amount, "RDN Balance not enough to Buy");
        clientdata[msg.sender].balRDN -= amount;
        payable(admin).transfer(amount);
        logtransaction[_clientAddress].logBuy++;
    }
 
    
    //SELL FUNCTION
    //function to manage client cash position after order sell (assumption all order is spot order)
    //Only client who can entry SELL transaction, which will credit fund to RDN account.

    function Sellposition(address _clientAddress, uint amount) public {
        require(msg.sender == clientdata[_clientAddress].client, "Only Client Can Entry Sell Transaction");
        clientdata[msg.sender].balRDN += amount;
//        payable(admin).transfer(amount); this command line not execute
        logtransaction[_clientAddress].logSell++; 
    } 
  
    
    //CASH WITHDRAWAL FUNCTION
    //function to manage client cash position after cashwithdrawal
    //Only client who can entry withdrawal fund from RDN Account
    function withdraw(address _clientAddress, uint amount) public {
        require(msg.sender == clientdata[_clientAddress].client, "Only Client Can Entry Fund Withdrawal");
        require(clientdata[msg.sender].balRDN >= amount, "RDN Balance not enough to withdraw");
        clientdata[msg.sender].balRDN -= amount;
        payable(msg.sender).transfer(amount);
        logtransaction[_clientAddress].logWith++;
    }
}
