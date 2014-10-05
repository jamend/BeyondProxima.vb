CREATE TABLE [dbo].[Messages] (
    [MessageID]        INT             IDENTITY (1, 1) NOT NULL,
    [Message]          NVARCHAR (4000) NOT NULL,
    [Recipient]        INT             NOT NULL,
    [Sender]           INT             NOT NULL,
    [DateSent]         DATETIME        CONSTRAINT [DF_Messages_DateSent] DEFAULT (getdate()) NOT NULL,
    [MessageRead]      BIT             CONSTRAINT [DF_Messages_MessageRead] DEFAULT ((0)) NOT NULL,
    [RecipientDeleted] BIT             CONSTRAINT [DF_Messages_RecipientDeleted] DEFAULT ((0)) NOT NULL,
    [SenderDeleted]    BIT             CONSTRAINT [DF_Messages_SenderDeleted] DEFAULT ((0)) NOT NULL
);

