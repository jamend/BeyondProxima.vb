CREATE PROCEDURE [dbo].[SignUp]
	(
		@IP nvarchar(16),
		@ActivationCode bigint,
		@Username nvarchar(16),
		@Password nvarchar(16),
		@Email nvarchar(64),
		@MSN nvarchar(64) = NULL,
		@AIM nvarchar(64) = NULL,
		@ICQ nvarchar(64) = NULL,
		@Yahoo nvarchar(64) = NULL,
		@Avatar nvarchar(256) = NULL,
		@HomePage nvarchar(256) = NULL,
		@Location nvarchar(64) = NULL,
		@Interests nvarchar(128) = NULL,
		@HideContactInfo bit
	)
AS
	DECLARE @Result int
	IF (SELECT COUNT(*) FROM SignupIPs WHERE SignupIP = @IP) > 0 AND @IP != '127.0.0.1'
	BEGIN
		SET @Result = 0 /* already signed up */
	END
	ELSE
	BEGIN
		IF (SELECT COUNT(*) FROM Users WHERE Username = @Username) > 0
		BEGIN
			SET @Result = 1 /* account name in use */
		END
		ELSE
		BEGIN
			IF (SELECT COUNT(*) FROM Users WHERE Email = @Email OR MSN = CASE WHEN @MSN IS NULL THEN '' ELSE @MSN END OR AIM = CASE WHEN @AIM IS NULL THEN '' ELSE @AIM END OR ICQ = CASE WHEN @ICQ IS NULL THEN '' ELSE @ICQ END OR Yahoo = CASE WHEN @Yahoo IS NULL THEN '' ELSE @Yahoo END ) > 0
			BEGIN
				SET @Result = 2 /* email in use */
			END
			ELSE
			BEGIN
				IF (SELECT COUNT(*) FROM Bans WHERE Email = @Email OR IP = @IP OR Username = @Username OR MSN = @MSN OR AIM = @AIM OR ICQ = @ICQ OR Yahoo = @Yahoo) > 0
				BEGIN
					SET @Result = 3 /* banned */
				END
				ELSE
				BEGIN
					DECLARE @UserID smallint
					INSERT INTO Users(Username, [Password], Email, MSN, AIM, ICQ, Yahoo, Location, Interests, Avatar, HomePage, ActivationCode, HideContactInfo) VALUES (@Username, @Password, @Email, @MSN, @AIM, @ICQ, @Yahoo, @Location, @Interests, @Avatar, @HomePage, @ActivationCode, @HideContactInfo)
					SET @UserID = @@IDENTITY

					DECLARE @HomePlanetID int
					--TODO
					--UPDATE Planets SET UserID = UserID WHERE PlanetID = (SELECT TOP 1 PlanetID FROM Planets WHERE Occupied = 0)
					SET @HomePlanetID = @@IDENTITY
					EXEC dbo.OccupySurroundingPlanets @HomePlanetID

					INSERT INTO LogIns(LogInIP, LogInDate, UserID) VALUES (@IP, GETDATE(), @UserID)
					EXEC dbo.SendMessage 'Welcome to Beyond Proxima!!', '', @UserID, 0, NULL, NULL, NULL

					SET @Result = 4 /* account created */
				END
			END
		END
	END
	RETURN(@Result)
