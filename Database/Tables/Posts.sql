CREATE TABLE [dbo].[Posts] (
    [PostID]   INT            IDENTITY (1, 1) NOT NULL,
    [Message]  NVARCHAR (MAX) NOT NULL,
    [ThreadID] INT            NOT NULL,
    [Poster]   INT            NOT NULL,
    [PostDate] DATETIME       CONSTRAINT [DF_Posts_PostDate] DEFAULT (getdate()) NOT NULL
);

