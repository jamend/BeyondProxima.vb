CREATE TABLE [dbo].[Forums] (
    [ForumID]          INT            IDENTITY (1, 1) NOT NULL,
    [ForumName]        NVARCHAR (64)  NOT NULL,
    [ForumDescription] NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_Forums] PRIMARY KEY CLUSTERED ([ForumID] ASC)
);

