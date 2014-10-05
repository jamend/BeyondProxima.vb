CREATE TABLE [dbo].[Fleets] (
    [FleetID] INT        IDENTITY (1, 1) NOT NULL,
    [UserID]  INT        NOT NULL,
    [System1] INT        CONSTRAINT [DF_Fleets_System1] DEFAULT ((0)) NULL,
    [System2] INT        NULL,
    [X]       FLOAT (53) NOT NULL,
    [Y]       FLOAT (53) NOT NULL,
    [X2]      FLOAT (53) NULL,
    [Y2]      FLOAT (53) NULL,
    [Steps]   FLOAT (53) NULL,
    [Step]    FLOAT (53) CONSTRAINT [DF_Fleets_step] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Fleets] PRIMARY KEY CLUSTERED ([FleetID] ASC)
);

