import random
import sqlite3
import csv

print("")

# connect to database
conn = sqlite3.connect('./App_Database.sqlite')

# cursor allows python to execute SQL statements
mycursor = conn.cursor()


# Create Users table
mycursor.execute("""
    CREATE TABLE IF NOT EXISTS Users (
        UserID INTEGER PRIMARY KEY AUTOINCREMENT,
        Username TEXT NOT NULL,
        Email TEXT UNIQUE NOT NULL,
        PasswordHash TEXT NOT NULL,
        CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
    )
""")
conn.commit()

# Creates Expenses table
mycursor.execute("""
    CREATE TABLE IF NOT EXISTS Expenses (
        ExpenseID INTEGER PRIMARY KEY AUTOINCREMENT,
        UserID INTEGER,
        Category TEXT NOT NULL,
        Amount REAL NOT NULL,
        Description TEXT,
        Date DATETIME DEFAULT CURRENT_TIMESTAMP,
        LocationID INTEGER,
        FOREIGN KEY (UserID) REFERENCES Users(UserID),
        FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
    )
""")
conn.commit()

# Create Locations Table
mycursor.execute("""
    CREATE TABLE IF NOT EXISTS Locations (
        LocationID INTEGER PRIMARY KEY AUTOINCREMENT,
        Latitude REAL,
        Longitude REAL,
        Address TEXT
    )
""")
conn.commit()

# Create Categories table
mycursor.execute("""
    CREATE TABLE IF NOT EXISTS Categories (
        CategoryID INTEGER PRIMARY KEY AUTOINCREMENT,
        CategoryName TEXT UNIQUE NOT NULL
    )
""")
conn.commit()

# ------------ Functions to interface with DB ------------

def addUser(Username, Email, PasswordHash):
    mycursor.execute(
        "INSERT INTO Users('Username', 'Email', 'PasswordHash') VALUES (?, ?, ?)",(Username, Email, PasswordHash,))
    conn.commit()
    print("Added user with Username: " + Username + ", Email: " + Email + ", and PasswordHash: " + PasswordHash)


def addExpense(UserID, Category, Amount, Description, LocationID):
    mycursor.execute(
        "INSERT INTO Expenses('UserID', 'Category', 'Amount', 'Description', 'LocationID') VALUES (?, ?, ?, ?, ?)",(UserID, Category, Amount, Description, LocationID,))
    conn.commit()
    print("Added expense with UserID: " + str(UserID) + ", Category: " + Category + ", Amount: " + str(Amount) + ", Description: " + Description + " , Location: " + str(LocationID))


def addLocation(Latitude, Longitude, Address):
    mycursor.execute(
        "INSERT INTO Locations('Latitude', 'Longitude', 'Address') VALUES (?, ?, ?)",
        (Latitude, Longitude, Address,))
    conn.commit()
    print("Added location with Latitude: " + str(Latitude) + ", Longitude: " + str(Longitude) + ", Address: " + Address)

def addCategory(CategoryName):
    mycursor.execute(
        "INSERT INTO Categories('CategoryName') VALUES (?)",
        (CategoryName,))
    conn.commit()
    print("Added category with CategoryName: " + CategoryName)


# ------------ Example calls to functions ------------
addUser("JohnDoe", "john@example.com", "password123")

addExpense(1, "Groceries", 50.25, "Weekly grocery shopping", 1)

addLocation(40.7128, -74.0060, "New York City")

addCategory("Food")
