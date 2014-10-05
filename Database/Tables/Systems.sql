CREATE TABLE [dbo].[Systems] (
    [SystemID]   INT           IDENTITY (1, 1) NOT NULL,
    [UserID]     INT           NOT NULL,
    [X]          FLOAT (53)    NOT NULL,
    [Y]          FLOAT (53)    NOT NULL,
    [SystemName] NVARCHAR (16) NULL,
    [StarType]   INT           NOT NULL,
    CONSTRAINT [PK_Systems] PRIMARY KEY CLUSTERED ([SystemID] ASC)
);

