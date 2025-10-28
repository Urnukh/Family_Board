
/*
Create users table
*/

CREATE TABLE IF NOT EXISTS users (
    userID VARCHAR(255) PRIMARY KEY,
    userName VARCHAR(255) NOT NULL,
    userEmail VARCHAR(255) NOT NULL UNIQUE,
    userPassword VARCHAR(255) NOT NULL,
    userCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userUpdatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userDeletedAt TIMESTAMP NULL,
    userStatus VARCHAR(255) NOT NULL DEFAULT 'active',
    userRole VARCHAR(255) NOT NULL DEFAULT 'user'
);

/*
Create user_relations table
*/
CREATE TABLE IF NOT EXISTS user_relations (
    relationID SERIAL PRIMARY KEY,
    userID VARCHAR(255) NOT NULL REFERENCES users(userID) ON DELETE CASCADE,
    relatedUserID VARCHAR(255) NOT NULL REFERENCES users(userID) ON DELETE CASCADE,
    relationshipType VARCHAR(50) NOT NULL,      -- e.g. 'mother', 'father', 'wife', 'husband', 'sibling'
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (userID, relatedUserID, relationshipType)
);

/*
Create events table
*/
CREATE TABLE IF NOT EXISTS events (
    eventID SERIAL PRIMARY KEY,
    eventName VARCHAR(255) NOT NULL,
    eventDescription TEXT NOT NULL,
    eventDate DATE NOT NULL,
    eventTime TIME NOT NULL,
    eventLocation VARCHAR(255) NOT NULL,
    eventCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
Create appointments table
*/
CREATE TABLE IF NOT EXISTS appointments (
    appointmentID SERIAL PRIMARY KEY,
    appointmentName VARCHAR(255) NOT NULL,
    appointmentDescription TEXT NOT NULL,
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL,
    appointmentLocation VARCHAR(255) NOT NULL,
    appointmentCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Either linked to a user or manually entered name
    userID VARCHAR(255) REFERENCES users(userID) ON DELETE SET NULL,
    guestName VARCHAR(255),

    -- Optional: add constraint later in app logic or trigger
    CHECK (
        (userID IS NOT NULL AND guestName IS NULL)
        OR (userID IS NULL AND guestName IS NOT NULL)
    )
);

/* 
Create appoinmentspayments
*/
CREATE TABLE IF NOT EXISTS appointmentpayments (
    fileID SERIAL PRIMARY KEY,
    paymentID INT NOT NULL REFERENCES appointment_payments(paymentID) ON DELETE CASCADE,
    fileName VARCHAR(255) NOT NULL,     
    fileSize INT,                      
    fileData BYTEA,                     
    fileUrl TEXT,                       
    uploadedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/*
Create creditbalance
*/
CREATE TABLE IF NOT EXISTS creditbalance (
    creditBalanceID SERIAL PRIMARY KEY,
    userID VARCHAR(255) NOT NULL REFERENCES users(userID) ON DELETE CASCADE,

    creditName VARCHAR(255) NOT NULL,             
    creditType VARCHAR(50) NOT NULL CHECK (
        creditType IN ('card', 'line_of_credit', 'other')
    ),                                             

    creditBalance DECIMAL(10, 2) NOT NULL DEFAULT 0,   
    creditHistory DECIMAL(10, 2)[] DEFAULT '{}',       

    creditBalanceUpdatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    creditBalanceCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    creditBalanceDeletedAt TIMESTAMP NULL,

    creditBalanceStatus VARCHAR(255) NOT NULL DEFAULT 'active',
    creditBalanceRole VARCHAR(255) NOT NULL DEFAULT 'user'
);

