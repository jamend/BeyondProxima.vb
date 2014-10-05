CREATE PROCEDURE [dbo].[SendMessage]
	(
		@Message nvarchar(4000),
		@RecipientUsername nvarchar(16),
		@RecipientUserID smallint,
		@Sender smallint,
		@Result int out,
		@Recipient smallint out,
		@RecipientName nvarchar(16) out
	)
AS
	SET @Recipient = (SELECT UserID FROM Users WHERE UserID = @RecipientUserID)
	IF (@Recipient IS NULL OR @Recipient = 0) AND Len(@RecipientUsername) > 0
	BEGIN
		SET @Recipient = (SELECT TOP 1 UserID FROM Users WHERE Username LIKE '%' + @RecipientUsername +  '%')
	END
	ELSE
	BEGIN
		SET @Result = 0 /* user not found */
	END
	IF @Recipient IS NULL
	BEGIN
		SET @Result = 0 /* user not found */
	END
	ELSE
	BEGIN
		IF (SELECT MessagesSent FROM Users WHERE UserID = @Sender) > 15
		BEGIN
			SET @Result = 1 /* too many messages for this turn */
		END
		ELSE
		BEGIN
			UPDATE Users SET MessagesSent = MessagesSent + 1 WHERE UserID = @Sender
			INSERT INTO Messages(Message, Recipient, Sender) VALUES (@Message, @Recipient, @Sender)
			SET @Result = 2 /* message sent */
			SET @RecipientName = (SELECT Username FROM Users WHERE UserID = @Recipient)
		END
	END
