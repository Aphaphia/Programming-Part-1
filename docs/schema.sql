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




-- Profiles for all four users
INSERT INTO UserProfile (UserID, DateOfBirth, Phone, City) VALUES
(1, '1985-03-14', '0821234567', 'Johannesburg'),
(2, '1990-07-22', '0839876543', 'Cape Town'),
(3, '1998-11-05', '0731122334', 'Soweto'),
(4, '2001-02-18', '0844455667', 'Pretoria');



-- Three events
INSERT INTO Events (EventName, Description, EventDate, Location, Distance, EventType, OrganiserID) VALUES
('Soweto 10km Fun Run', 'A community fun run through the streets of Soweto.', '2026-10-10', 'Soweto, Johannesburg', 10.00, 'Run', 1),
('Cape Town Cycle Tour', 'One of the world''s largest timed cycling events.', '2026-11-08', 'Cape Town', 109.00, 'Cycle', 2),
('Joburg City Walk', 'A relaxed charity walk through Johannesburg CBD.', '2026-09-20', 'Johannesburg CBD', 5.00, 'Walk', 1);




-- Categories for each event
INSERT INTO Categories (EventID, CategoryName, Description) VALUES
(1, 'Under 20', 'Runners under the age of 20.'),
(1, 'Senior', 'Runners aged 20 and above.'),
(2, 'Individual', 'Individual cyclist entry.'),
(2, 'Team', 'Team entry of up to 4 riders.'),
(3, 'Open', 'Open category for all ages.');
