CREATE TABLE [dbo].[Game] (
    [State]       INT NOT NULL,
    [LastSector]  INT CONSTRAINT [DF_Game_LastSector] DEFAULT ((1)) NOT NULL,
    [LastSectorX] INT CONSTRAINT [DF_Game_LastSectorX] DEFAULT ((0)) NOT NULL,
    [LastSectorY] INT CONSTRAINT [DF_Game_LastSectorY] DEFAULT ((0)) NOT NULL
);

