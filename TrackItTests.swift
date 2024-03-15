//
//  TrackItTests.swift
//  TrackItTests
//
//  Created by Dylan Calderon on 3/13/24.
//

import XCTest
import SQLite
@testable import Database
import SwiftUI

// Sample Transaction struct
struct Transaction {
    let id: Int
    let amount: Double
    let address: String
}

class TrackItTests: XCTestCase {
    var dbConnection: Connection!
    
    override func setUpWithError() throws {
        super.setUp()
        do {
            // Open a connection to the SQLite database
            dbConnection = try Connection("/Users/Dylan/DataGripProjects/test/exportToHTML")
        } catch {
            // Handle error if connection fails
            XCTFail("Failed to open database connection: \(error)")
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test the connectToDatabase method
    public func testConnectToDatabase() {
        // Provide the path to your SQLite database file
        let databasePath = "/Users/Dylan/Downloads"

        // Attempt to connect to the database
        if let dbConnection = connectToDatabase(databasePath: databasePath) {
            // Connection successful, you can now use dbConnection to interact with the database
            print("Connected to database successfully!")

            // Print the path to the connected database (for verification)
            print("Database Path: \(dbConnection.path)")
        } else {
            // Print error message if connection fails
            print("Failed to connect to database.")
        }
        testConnectToDatabase(databasePath: databasePath)
    }
    
    
    // Test getting a transaction by transaction ID
    func testGetTransactionById() {
        // Sample transaction ID to retrieve
        let transactionId = 123
        
        do {
            // Prepare the SELECT query
            let query = "SELECT * FROM transactions WHERE id = ?"
            let statement = try dbConnection.prepare(query)
            
            // Bind the transaction ID to the prepared statement
            statement.bind(transactionId)
            
            // Execute the query and retrieve the transaction row
            let transactionRow = try statement.run()
            
            // Execute the query and retrieve the transaction row
            guard let transactionRow = transactionRow.next() else {
                // If the transaction does not exist, fail the test
                XCTFail("Transaction with ID \(transactionId) not found")
                return
            }
            
            // If the transaction exists, extract data and create a Transaction object
            let id = transactionRow[0] as! Int
            let amount = transactionRow[1] as! Double
            let address = transactionRow[2] as! String
            // Extract other properties if needed
            
            let transaction = Transaction(id: id, amount: amount, address: address)
            // Perform assertions on the retrieved transaction if needed
        } catch {
            // Handle error if query execution fails
            XCTFail("Failed to retrieve transaction: \(error)")
        }
    }
    
    // Sample User struct
    struct User {
        let id: Int
        let username: String
        let email: String
        let friends: [User]
    }
    
    class DatabaseTests: XCTestCase {
        var dbConnection: Connection!
        
        // This function will be called before each test case is run.
        override func setUp() {
            super.setUp()
            do {
                // Open a connection to the SQLite database
                dbConnection = try Connection("path/to/your/database.db")
            } catch {
                // Handle error if connection fails
                XCTFail("Failed to open database connection: \(error)")
            }
        }
        
        // This function will be called after each test case is run.
        override func tearDown() {
            // Close the database connection
            dbConnection = nil
            super.tearDown()
        }
        
        // Your test class that inherits from XCTestCase
        class YourTestCaseClassName: XCTestCase {
            
            // Function to test getting a user by username
            func testGetUserByUsername() {
                // Sample username to retrieve user information
                let username = "sample_username"
                
                do {
                    // Provide a valid SQLite database connection
                    let dbConnection = try Connection("path_to_your_database.db")
                    
                    // Prepare the SELECT query to retrieve user information
                    let query = "SELECT * FROM users WHERE username = ?"
                    let statement = try dbConnection.prepare(query)
                    
                    // Bind the username to the prepared statement
                    try statement.bind(username)
                    
                    // Execute the query and retrieve the user row
                    guard let userRow = try statement.run().next() else {
                        // If the user does not exist, fail the test
                        XCTFail("User with username \(username) not found")
                        return
                    }
                    
                    // Extract data and create a User object
                    let id = userRow[0] as! Int
                    let email = userRow[1] as! String
                    // Extract other properties if needed
                    
                    // Sample: Retrieving user's friends
                    let friends: [User] = [] // You need to implement logic to retrieve friends from the database
                    
                    let user = User(id: id, username: username, email: email, friends: friends)
                    
                    // Sample assertions - you should add your own assertions here
                    XCTAssertNotNil(user)
                    XCTAssertEqual(user.username, username)
                    
                } catch {
                    // Handle error if query execution fails
                    XCTFail("Failed to retrieve user: \(error)")
                }
            }
        }
    }
}
