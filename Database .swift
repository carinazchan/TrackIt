//
//  Database .swift
//  TrackIt
//
//  Created by Dylan Calderon on 3/14/24.
//

import Foundation
import SQLite

// Sample Transaction struct
struct Transaction {
    let id: Int
    let amount: Double
    let address: String
}

// Function to retrieve transactions for a user from the database
func getUserTransactions(username: String, dbConnection: Connection) -> [Transaction]? {
    do {
        // Prepare the SELECT query
        let query = "SELECT id, amount FROM transactions WHERE username = ?"
        let statement = try dbConnection.prepare(query)
        
        // Bind the username to the prepared statement
        try statement.bind(username)
        
        // Execute the query and retrieve the transaction rows
        let transactionRows = try statement.run()

        // Iterate through the result rows and construct Transaction objects
        var transactions: [Transaction] = []
        for row in transactionRows {
            let id = row[0] as! Int
            let amount = row[1] as! Double
            let address = row[2] as! String

            let transaction = Transaction(id: id, amount: amount, address: address)
            transactions.append(transaction)
        }
        
        // Return the list of transactions
        return transactions
    } catch {
        // Handle error if query execution fails
        print("Failed to retrieve transactions for user \(username): \(error)")
        return nil
    }
    
    struct User {
        let username: String
        let email: String
        let phoneNumber: String
        let friendsList: [String]
    }

    // Function to retrieve user information from the database
    func getUserInformation(username: String, dbConnection: Connection) -> User? {
        do {
            // Prepare the SELECT query
            let query = "SELECT * FROM users WHERE username = ?"
            let statement = try dbConnection.prepare(query)
            
            // Bind the username to the prepared statement
            try statement.bind(username)
            
            // Execute the query
            let userRows = try statement.run()
            
            // Check if the user exists
            guard let userRow = userRows.next() else {
                // User not found
                print("User with username \(username) not found")
                return nil
            }

            // Extract user information from the row
            let email = userRow[1] as! String
            let phoneNumber = userRow[2] as! String
            let friendsListString = userRow[3] as! String
            let friendsList = friendsListString.components(separatedBy: ",")
            
            // Construct a User object
            let user = User(username: username, email: email, phoneNumber: phoneNumber, friendsList: friendsList)
            
            // Return the user object
            return user
        } catch {
            // Handle error if query execution fails
            print("Failed to retrieve user information for username \(username): \(error)")
            return nil
        }
    }
    
    // Function to retrieve a transaction based on its ID from the database
    func getTransactionByID(transactionID: Int, dbConnection: Connection) -> Transaction? {
        do {
            // Prepare the SELECT query
            let query = "SELECT id, amount, address FROM transactions WHERE id = ?"
            let statement = try dbConnection.prepare(query)
            
            // Bind the transactionID to the prepared statement
            try statement.bind(transactionID)
            
            // Execute the query
            let transactionRows = try statement.run()
            
            // Check if the transaction exists
            guard let transactionRow = transactionRows.next() else {
                // Transaction not found
                print("Transaction with ID \(transactionID) not found")
                return nil
            }
            
            // Extract transaction information from the row
            let id = transactionRow[0] as! Int
            let amount = transactionRow[1] as! Double
            let address = transactionRow[2] as! String
            
            // Construct a Transaction object
            let transaction = Transaction(id: id, amount: amount, address: address)
            
            // Return the transaction object
            return transaction
        } catch {
            // Handle error if query execution fails
            print("Failed to retrieve transaction with ID \(transactionID): \(error)")
            return nil
        }
    }
    
    //method to connect to database
    func connectToDatabase(databasePath: String) -> Connection? {
        do {
            let db = try Connection("/Users/Dylan/Downloads")
            return db
        } catch {
            print("Error connecting to database: \(error)")
            return nil
        }
    }
}

