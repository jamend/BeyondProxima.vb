CREATE TABLE [dbo].[Planets] (
    [PlanetID]      INT IDENTITY (1, 1) NOT NULL,
    [SystemID]      INT NOT NULL,
    [EnvironmentID] INT NOT NULL,
    [Size]          INT NOT NULL,
    [Occupied]      BIT CONSTRAINT [DF_Planets_Occupied] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Planets] PRIMARY KEY CLUSTERED ([PlanetID] ASC)
);

