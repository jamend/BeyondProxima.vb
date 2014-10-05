CREATE TABLE [dbo].[LogIns] (
    [LogInID]   INT           IDENTITY (1, 1) NOT NULL,
    [LogInIP]   NVARCHAR (16) NOT NULL,
    [LogInDate] DATETIME      CONSTRAINT [DF_LogIns_LogInDate] DEFAULT (getdate()) NOT NULL,
    [UserID]    INT           NOT NULL,
    CONSTRAINT [PK_LogIns] PRIMARY KEY CLUSTERED ([LogInID] ASC)
);

