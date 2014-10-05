Imports System.Data.SqlClient

Partial Class proxima_Tick
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim SqlConnection1 As SqlConnection = Session.Item("SqlConnection")

        SqlConnection1.Open()

        'set game offline
        Dim SqlCommand1 As New SqlCommand("UPDATE Game SET State = 0", SqlConnection1)
        SqlCommand1.ExecuteNonQuery()

        'update moving fleets
        Dim sqlFleetsMovementUpdate As New SqlCommand("UPDATE Fleets SET X = X - X2, Y = Y - Y2, Step = Step + 1 WHERE Steps > 0", SqlConnection1)
        sqlFleetsMovementUpdate.ExecuteNonQuery()

        'arrive fleets
        Dim sqlFleetsArriveUpdate As New SqlCommand("UPDATE Fleets SET Fleets.X = Systems.X, Fleets.Y = Systems.Y, Steps = 0, Step = 0, System1 = System2, System2 = null FROM Systems WHERE Fleets.System2 = Systems.SystemID AND Steps > 0 AND Step >= Steps", SqlConnection1)
        sqlFleetsArriveUpdate.ExecuteNonQuery()

        'set game online
        SqlCommand1 = New SqlCommand("UPDATE Game SET State = 1", SqlConnection1)
        SqlCommand1.ExecuteNonQuery()

        SqlConnection1.Close()

        Response.Redirect("map/")
    End Sub
End Class
