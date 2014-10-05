CREATE TABLE [dbo].[Environments] (
    [EnvironmentID]    INT           IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (16) NOT NULL,
    [PopulationFactor] FLOAT (53)    NOT NULL,
    [ProductionFactor] FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_Environments] PRIMARY KEY CLUSTERED ([EnvironmentID] ASC)
);

