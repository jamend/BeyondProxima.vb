CREATE TABLE [dbo].[ErrorLog] (
    [ErrorID]   INT             IDENTITY (1, 1) NOT NULL,
    [ErrorDate] DATETIME        NULL,
    [Message]   NVARCHAR (256)  NULL,
    [Stack]     NVARCHAR (1024) NULL,
    [UserID]    INT             NOT NULL,
    [LoggedIn]  BIT             NULL,
    [RawURL]    NVARCHAR (256)  NULL,
    [ErrorIP]   NVARCHAR (16)   NULL
);

