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



CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(150) NOT NULL,
    Description VARCHAR(500) NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Distance DECIMAL(5,2) NOT NULL,
    EventType VARCHAR(20) NOT NULL CHECK (EventType IN ('Run', 'Walk', 'Cycle')),
    OrganiserID INT NOT NULL,
    CONSTRAINT FK_Events_Users FOREIGN KEY (OrganiserID) REFERENCES Users(UserID)
);




CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NULL,
    CONSTRAINT FK_Categories_Events FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT UQ_Category_PerEvent UNIQUE (EventID, CategoryName)
);



CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    EnrollmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed' CHECK (Status IN ('Confirmed', 'Cancelled')),
    CONSTRAINT FK_Enrollments_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Enrollments_Events FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_Enrollments_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT UQ_Enrollment_PerUserEvent UNIQUE (UserID, EventID)
);



CREATE TABLE Results (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrollmentID INT NOT NULL UNIQUE, -- UNIQUE enforces the 0..1 relationship with Enrollments
    FinishTime TIME NOT NULL,
    Position INT NOT NULL,
    CONSTRAINT FK_Results_Enrollments FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);




-- =========================================
-- SEED DATA
-- =========================================

-- Organisers
INSERT INTO Users (FirstName, LastName, Email, Password, Role) VALUES
('Thabo', 'Nkosi', 'thabo.nkosi@raceday.co.za', 'HashedPassword123', 'Organiser'),
('Lindiwe', 'Dube', 'lindiwe.dube@raceday.co.za', 'HashedPassword123', 'Organiser');

-- Participants
INSERT INTO Users (FirstName, LastName, Email, Password, Role) VALUES
('Sipho', 'Mokoena', 'sipho.mokoena@gmail.com', 'HashedPassword123', 'Participant'),
('Anele', 'Botha', 'anele.botha@gmail.com', 'HashedPassword123', 'Participant');
