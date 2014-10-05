CREATE TABLE [dbo].[Bans] (
    [BanID]    INT           IDENTITY (1, 1) NOT NULL,
    [IP]       NVARCHAR (16) NULL,
    [Username] NVARCHAR (16) NULL,
    [Email]    NVARCHAR (64) NULL,
    [MSN]      NVARCHAR (64) NULL,
    [ICQ]      NVARCHAR (64) NULL,
    [Yahoo]    NVARCHAR (64) NULL,
    [AIM]      NVARCHAR (64) NULL
);

