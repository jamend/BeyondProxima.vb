CREATE TABLE [dbo].[Threads] (
    [ThreadID]     INT           IDENTITY (1, 1) NOT NULL,
    [ForumID]      INT           NOT NULL,
    [ThreadName]   NVARCHAR (64) NOT NULL,
    [Views]        INT           CONSTRAINT [DF_Threads_Views] DEFAULT ((0)) NOT NULL,
    [Creator]      INT           NOT NULL,
    [LastPoster]   INT           NOT NULL,
    [LastPostDate] DATETIME      CONSTRAINT [DF_Threads_LastPostDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Threads] PRIMARY KEY CLUSTERED ([ThreadID] ASC)
);

