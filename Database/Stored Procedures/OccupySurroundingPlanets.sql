CREATE PROCEDURE dbo.OccupySurroundingPlanets
	(
		@PlanetID int
	)
AS
	DECLARE @X int
	DECLARE @Y int
	--TODO
	--SELECT @X = X, @Y = Y FROM Planets WHERE PlanetID = @PlanetID
	--UPDATE Planets SET Occupied = 1 WHERE X > @X - 17 AND X < @X + 17 AND Y > @Y - 17 AND Y < @Y + 17