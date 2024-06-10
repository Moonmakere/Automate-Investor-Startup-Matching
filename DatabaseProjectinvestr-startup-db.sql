CREATE TABLE [dbo].[Investor] (
    [InvestorID]   INT          IDENTITY (1, 1) NOT NULL,
    [Name]         VARCHAR (50) NOT NULL,
    [Company]      VARCHAR (50) NOT NULL,
    [Regions]      VARCHAR (50) NOT NULL,
    [StartupStage] VARCHAR (50) NOT NULL,
    [Industry]     VARCHAR (50) NOT NULL,
    [WomenIssues]  BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([InvestorID] ASC)
);


GO

CREATE TABLE [dbo].[Registrations] (
    [id]                INT            IDENTITY (1, 1) NOT NULL,
    [name]              NVARCHAR (100) NOT NULL,
    [startupname]       NVARCHAR (100) NOT NULL,
    [email]             NVARCHAR (100) NOT NULL,
    [regions_countries] NVARCHAR (100) NOT NULL,
    [startupstage]      NVARCHAR (100) NOT NULL,
    [industry]          NVARCHAR (100) NOT NULL,
    [registration_date] DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO

CREATE TABLE [dbo].[Startups] (
    [SrNo]             INT            NOT NULL,
    [Name]             NVARCHAR (50)  NULL,
    [StartupName]      NVARCHAR (100) NULL,
    [RegionsCountries] NVARCHAR (100) NULL,
    [StartupStage]     NVARCHAR (20)  NULL,
    [Industry]         NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([SrNo] ASC)
);


GO

