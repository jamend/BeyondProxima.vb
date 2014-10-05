CREATE PROCEDURE dbo.CreateSector (
	@UserID smallint
)
AS
BEGIN
SET NOCOUNT ON

DECLARE @SectorWidth int
SET @SectorWidth = 1

DECLARE @LastSector int
DECLARE @LastSectorX int
DECLARE @LastSectorY int
DECLARE @Ring int
DECLARE @RingProgress int
DECLARE @SideLength int

SET @Ring = SQRT(@LastSector) / 2 + 1
SET @RingProgress = @LastSector - (@Ring - 1) ^ 2
SET @SideLength = @Ring * 2 - 1
SELECT @LastSector = LastSector, @LastSectorX = LastSectorX, @LastSectorY = LastSectorY FROM Game
IF @LastSector > 0
BEGIN
	IF @LastSector % 8 = 0 OR @LastSector = 1 /* new ring */
	BEGIN
		SET @LastSectorY = @LastSectorY + @SectorWidth
	END
	ELSE
	BEGIN
		IF @RingProgress < @SideLength
		BEGIN
			SET @LastSectorX = @LastSectorX + @SectorWidth
		END
		ELSE
		BEGIN
			IF @RingProgress < @SideLength * 2
			BEGIN
				SET @LastSectorX = @LastSectorY - @SectorWidth
			END
			ELSE
			BEGIN
				IF @RingProgress < @SideLength * 3
				BEGIN
					SET @LastSectorX = @LastSectorX - @SectorWidth
				END
				ELSE
				BEGIN
					SET @LastSectorX = @LastSectorY + @SectorWidth
				END
			END
		END
	END
END
SET @LastSector = @LastSector + 1
UPDATE Game SET LastSector = @LastSector, LastSectorX = @LastSectorX, LastSectorY = @LastSectorY
END
