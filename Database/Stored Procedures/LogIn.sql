CREATE PROCEDURE [dbo].[LogIn]
	(
		@Username nvarchar(16),
		@Password nvarchar(16),
		@IP nvarchar(16),
		@SessionID bigint,
		@UserID smallint output,
		@AccessLevel tinyint output,
		@Result int output
	)
AS
	SET @UserID = (SELECT UserID FROM Users WHERE Username = @Username)
	IF @UserID = NULL
	BEGIN
		SET @Result = 0 /* account not found or incorrect password */
	END
	ELSE
	BEGIN
		IF (SELECT COUNT(*) FROM FailedLogins WHERE UserID = @UserID AND FailedIP = @IP AND Expired = 0) > 3
		BEGIN
			SET @Result = 1 /* too many failed attempts for this account */
		END
		ELSE
		BEGIN
			IF (SELECT COUNT(*) FROM FailedLogins WHERE FailedIP = @IP AND Expired = 0) > 5
			BEGIN
				SET @Result = 2 /* too many failed attempts from IP */
			END
			ELSE
			BEGIN
				IF (SELECT [Password] FROM Users WHERE UserID = @UserID) <> @Password
				BEGIN
					SET @Result = 0 /* account not found or incorrect password */
					INSERT INTO FailedLogins (FailedIP, UserID , [Password]) VALUES (@IP, @UserID , @Password)
				END
				ELSE
				BEGIN
					IF (SELECT Suspended FROM Users WHERE UserID = @UserID) = 1
					BEGIN
						SET @Result = 3 /* suspended */
					END
					ELSE
					BEGIN
						IF (SELECT Dead FROM Users WHERE UserID = @UserID) = 1
						BEGIN
							SET @Result = 4 /* dead */
						END
						ELSE
						BEGIN
							If (SELECT State FROM Game) = 0
							BEGIN
								SET @Result = 5 /* tick */
							END
							ELSE
							BEGIN
								SET @Result = 6 /* logged in */
								UPDATE Users SET @AccessLevel = AccessLevel, LoggedIn = 1, SessionID = @SessionID WHERE UserID = @UserID
								INSERT INTO LogIns (LogInIP, UserID) VALUES (@IP, @UserID)
							END
						END
					END
				END
			END
		END
	END
