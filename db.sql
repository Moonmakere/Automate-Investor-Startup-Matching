-- Create a table to store the startup data
CREATE TABLE Startups (
    SrNo INT PRIMARY KEY,
    Name NVARCHAR(50),
    StartupName NVARCHAR(100),
    RegionsCountries NVARCHAR(100),
    StartupStage NVARCHAR(20),
    Industry NVARCHAR(100)
);

-- Insert the data into the table
INSERT INTO Startups (SrNo, Name, StartupName, RegionsCountries, StartupStage, Industry)
VALUES
    (1, 'Aliah', 'Startup 1', 'Singapore', 'Seed', 'Material Technology'),
    (2, 'Bailey', 'Startup 2', 'Ireland', 'Seed', 'Material Technology'),
    (3, 'Clara', 'Startup 3', 'South Korea', 'Pre-seed-A', 'Women issues, Femtech'),
    (4, 'Diane', 'Startup 4', 'Africa', 'Seed', 'Logistic technology'),
    (5, 'Eve', 'Startup 5', 'Turkey', 'Pre-seed-A', 'Sustainable technology'),
    (6, 'Farida', 'Startup 6', 'Egypt', 'Seed', 'Healthcare Technology'),
    (7, 'Greta', 'Startup 7', 'United Kingdom', 'Pre-seed-A', 'Material Technology, Deeptech'),
    (8, 'Hailey', 'Startup 8', 'Thailand', 'Seed', 'Human Resource Technology'),
    (9, 'Irina', 'Startup 9', 'Australia', 'Seed', 'Education Technology'),
    (10, 'Jina', 'Startup 10', 'India', 'Seed', 'Medical Technology');


    -- Create a table to store the investor data
CREATE TABLE Investors (
    SrNo INT PRIMARY KEY,
    Name NVARCHAR(50),
    Company NVARCHAR(100),
    Regionscounries NVARCHAR(100),
    StartupStage NVARCHAR(50),
    Industry NVARCHAR(200)
);

-- Insert the data into the table
INSERT INTO Investors (SrNo, Name, Company, Regions, StartupStage, Industry)
VALUES
    (1, 'John Doe', 'Company 1', 'Asia Pacific', 'Seed-Series A', 'Impact, Sustainability / Climate, Deeptech'),
    (2, 'Helen', 'Company 2', 'SEA', 'Pre-Seed-Series A', 'Consumer, Food, Web3, Content Economy'),
    (3, 'Pete', 'Company 3', 'Global', 'Seed-Series B', 'Deeptech, Medtech'),
    (4, 'Rachel', 'Company 3', 'Asia', 'Seed-Pre-A', 'Agnostic'),
    (5, 'Huang', 'Company 4', 'SEA', 'Seed-Series B', 'Agnostic'),
    (6, 'Lisa', 'Company 5', 'South Asia', 'Seed-Series B', 'Agnostic'),
    (7, 'Mario', 'Company 6', 'Western', 'Seed-Series B', 'Agnostic'),
    (8, 'Jayden', 'Company 7', 'Global', 'Seed-Series B+', 'High Tech: AI, Crypto, etc'),
    (9, 'Lila', 'Company 8', 'South Asia, Western', 'Seed-Series B+', 'Agnostic'),
    (10, 'Hayley', 'Company 9', 'Africa, Europe, America', 'Seed-Series B+', 'Agnostic'),
    (11, 'Tania', 'Company 10', 'East Asia', 'Agnostic', 'Women Issues');



    -- Create a table to store the investor-startup matches
CREATE TABLE InvestorStartupMatches (
    InvestorSrNo INT,
    StartupSrNo INT,
    PRIMARY KEY (InvestorSrNo, StartupSrNo),
    FOREIGN KEY (InvestorSrNo) REFERENCES Investors(SrNo),
    FOREIGN KEY (StartupSrNo) REFERENCES Startups(SrNo)
);

-- Insert the matches into the table
INSERT INTO InvestorStartupMatches (InvestorSrNo, StartupSrNo)
SELECT i.SrNo, s.SrNo
FROM Investors i
JOIN Startups s ON i.Regions LIKE '%' + s.RegionsCountries + '%'
AND i.StartupStage LIKE '%' + s.StartupStage + '%'
AND i.Industry LIKE '%' + s.Industry + '%';

