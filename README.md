This Ethereum contract (filename : CashWithdrawalFinale.sol) is  the 1st phase of improvement effort to simplify the cash withdrawal process of client cash balance from client’s RDN (RDN is Rekening Dana Nasabah or customer bank account under the customer name which manage and operate by securities company based on the customer POA).
To give perspective in relation to the improvement idea of Cash Withdrawal Simplification, this Ethereum contract will describe end-to-end business process, using simple database and user interactions  to show that the simplification idea is workable, possible to implement and enhance further.
What covers in this ethereum contract is :

1.	Client’s data management
	This ethereum contract provide function for user (custodian Officer) to entry client data when the client onboard to the securities company.

	DATA ENTRY FUNCTION
	This ethereum contract provide function for user (custodian Officer) to entry client data when the client onboard to the securities company.
	registerClient is use by Back Office Admin of the securities company (Custodian Officer) to register new client of the company. Others can not use this function. To avoid 		double entry, this function also helps the officer by giving notification if the client data is already exist in the database.
	
	Due to the time limitation this contracts not covers on client's data update/maintenance and suspend/delete data when the clients closed their account.

2.	Client’s Transaction 
	On Client’s transaction menu, this ethereum contract provides a useful function for users (client) to do deposits, to do transactions (buy or sell), and to do cash
	withdrawals. Also provided the validation of client's transaction on fund availability for buy and cash withdrawals. If funds available is less than the value of the buy 
	transaction or withdrawal amount entry by the client, the transaction will be rejected.
	
	DEPOSIT FUNCTION
	This function is used by clients to do fund deposits to their RDN, which by mechanism will debit the client's wallet and transfer (credit) to the client's RDN.
	Only respective clients can operate this function.

	BUY FUNCTION
	This function is used by clients to do buy transactions, which by mechanism will debit the client's RDN. The deducted amount will be used to settle the client's 
	transaction on settlement date which not covers on this contract. 
	Only respective clients can operate this function, and notification will arise if the value of buy transaction is exceed the available amount in the client's RDN
	
	SELL FUNCTION
	This function is used by clients to do sell transactions, which by mechanism will credit the client's RDN. The credited amount will be credited to the client's RDN.
	Only respective clients can operate this function, 
	
	WITHDRAWAL FUNCTION
	This function is used by clients to do withdrawal cash from RDN, which by mechanism will debit the client's RDN. The debited amount will be credited to the client's 
	wallet.
	Only respective clients can operate this function, and notification will arise if the value of cash withdrawal is exceed the available amount in the client's RDN

3.	Reporting & Monitoring
	For reporting and monitoring purpose, we can use the feature of getclientdata, logtransaction and checkbalance.
	getclientdata use to check the information on client (client data dan RDN Balance), logtransaction use to check the historical client transaction, and checkbalance is use 
	to check the RDN's balance.
