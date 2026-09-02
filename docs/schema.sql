-- RaceDay Database Schema


-- =========================================
-- TABLE CREATION
-- =========================================

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Organiser', 'Participant'))
);



CREATE TABLE UserProfile (
    ProfileID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE, -- UNIQUE enforces the 1:1 relationship with Users
    DateOfBirth DATE NOT NULL,
    Phone VARCHAR(20) NULL,
    City VARCHAR(100) NULL,
    CONSTRAINT FK_UserProfile_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
