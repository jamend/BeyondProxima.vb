/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET IDENTITY_INSERT [dbo].[Environments] ON
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (1, N'Gas Giant', 0, 0)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (2, N'Volcanic', 0.25, 0.5)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (3, N'Ice', 0.5, 0.75)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (4, N'Barren', 0.75, 0.75)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (5, N'Desert', 0.75, 1)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (6, N'Terran', 1, 1)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (7, N'Rock', 0.75, 1.25)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (8, N'Jungle', 1.25, 1)
INSERT INTO [dbo].[Environments] ([EnvironmentID], [Name], [PopulationFactor], [ProductionFactor]) VALUES (9, N'Terraformed', 1.25, 1.25)
SET IDENTITY_INSERT [dbo].[Environments] OFF

SET IDENTITY_INSERT [dbo].[Users] ON
INSERT INTO [dbo].[Users] ([UserID], [Username], [Password], [Email], [HomePage], [Avatar], [MSN], [AIM], [Yahoo], [ICQ], [LoggedIn], [SessionID], [Location], [Interests], [HideContactInfo], [AccessLevel], [ActivationCode], [Activated], [ActivationAttempts], [Suspended], [Dead], [DieDate], [SignUpDate], [MessagesSent], [Threads], [Posts], [ShipSpeed]) VALUES (0, N'System', N'System', N'system@antares', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, N'2006-04-17 21:29:17', N'2006-04-17 21:29:17', 0, 0, 0, 1)
INSERT INTO [dbo].[Users] ([UserID], [Username], [Password], [Email], [HomePage], [Avatar], [MSN], [AIM], [Yahoo], [ICQ], [LoggedIn], [SessionID], [Location], [Interests], [HideContactInfo], [AccessLevel], [ActivationCode], [Activated], [ActivationAttempts], [Suspended], [Dead], [DieDate], [SignUpDate], [MessagesSent], [Threads], [Posts], [ShipSpeed]) VALUES (1, N'test', N'test', N'test@example.com', NULL, NULL, NULL, NULL, NULL, NULL, 1, 8774385913896632320, NULL, NULL, 0, 0, 2056000432278339584, 1, 0, 0, 0, N'2007-01-02 21:59:10', N'2007-01-02 21:59:10', 0, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF

SET IDENTITY_INSERT [dbo].[Systems] ON
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (4, 6, 0, 0, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (5, 6, 4, 6, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (6, 6, 2, 7, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (7, 6, 5, 2, N'Zergland', 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (8, 6, 9, 1, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (9, 6, 14, 9, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (10, 6, 12, 4, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (11, 6, 8, 6, N'Sol', 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (12, 6, 6, 10, NULL, 1)
INSERT INTO [dbo].[Systems] ([SystemID], [UserID], [X], [Y], [SystemName], [StarType]) VALUES (13, 6, 15, 2, NULL, 1)
SET IDENTITY_INSERT [dbo].[Systems] OFF

SET IDENTITY_INSERT [dbo].[Planets] ON
INSERT INTO [dbo].[Planets] ([PlanetID], [SystemID], [EnvironmentID], [Size], [Occupied]) VALUES (21585, 4, 1, 1, 0)
INSERT INTO [dbo].[Planets] ([PlanetID], [SystemID], [EnvironmentID], [Size], [Occupied]) VALUES (21588, 4, 2, 1, 0)
INSERT INTO [dbo].[Planets] ([PlanetID], [SystemID], [EnvironmentID], [Size], [Occupied]) VALUES (21589, 4, 3, 1, 0)
SET IDENTITY_INSERT [dbo].[Planets] OFF

SET IDENTITY_INSERT [dbo].[Fleets] ON
INSERT INTO [dbo].[Fleets] ([FleetID], [UserID], [System1], [System2], [X], [Y], [X2], [Y2], [Steps], [Step]) VALUES (1, 0, 12, NULL, 6, 10, -0.8, -0.60000000000000009, 0, 0)
INSERT INTO [dbo].[Fleets] ([FleetID], [UserID], [System1], [System2], [X], [Y], [X2], [Y2], [Steps], [Step]) VALUES (5, 0, 8, 7, 8.0298574998546677, 1.2425356250363331, 0.97014250014533188, -0.24253562503633297, 4.1231056256176606, 1)
INSERT INTO [dbo].[Fleets] ([FleetID], [UserID], [System1], [System2], [X], [Y], [X2], [Y2], [Steps], [Step]) VALUES (6, 0, 5, 11, 5, 6, -1, 0, 4, 1)
SET IDENTITY_INSERT [dbo].[Fleets] OFF
