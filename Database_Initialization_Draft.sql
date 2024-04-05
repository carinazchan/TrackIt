-- Create Users table
CREATE TABLE IF NOT EXISTS Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    PasswordHash TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Expenses table
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
);

-- Create Locations table
CREATE TABLE IF NOT EXISTS Locations (
    LocationID INTEGER PRIMARY KEY AUTOINCREMENT,
    Latitude REAL,
    Longitude REAL,
    Address TEXT
);

-- Create Categories table (optional, if you want to normalize categories)
CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName TEXT UNIQUE NOT NULL
);

-- Example of how to link Expenses to Categories if using Categories table
-- ALTER TABLE Expenses ADD COLUMN CategoryID INTEGER;
-- ALTER TABLE Expenses ADD FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
