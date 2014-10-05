CREATE TABLE [dbo].[FailedLogins] (
    [FailedID]   INT           IDENTITY (1, 1) NOT NULL,
    [FailedDate] DATETIME      CONSTRAINT [DF_FailedLogins_FailedDate] DEFAULT (getdate()) NOT NULL,
    [FailedIP]   NVARCHAR (16) NOT NULL,
    [UserID]     INT           NOT NULL,
    [Password]   NVARCHAR (16) NOT NULL,
    [Expired]    BIT           CONSTRAINT [DF_FailedLogins_Expired] DEFAULT ((0)) NOT NULL
);

