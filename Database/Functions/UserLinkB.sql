CREATE FUNCTION [dbo].[UserLinkB]
(
	@UserID int
)
RETURNS nvarchar(64)
BEGIN
	RETURN('<a href="../Profile.aspx?id=' + CAST(@UserID AS nvarchar(8)) + '">» ' + (SELECT Username FROM Users WHERE UserID = @UserID) + '</a>')
END