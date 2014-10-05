﻿CREATE TABLE [dbo].[Ships] (
    [ShipID]  INT IDENTITY (1, 1) NOT NULL,
    [FleetID] INT NOT NULL,
    CONSTRAINT [PK_Ships] PRIMARY KEY CLUSTERED ([ShipID] ASC)
);
