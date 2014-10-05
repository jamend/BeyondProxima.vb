Imports System.Data.SqlClient

Public Class ServiceMain

    Dim SqlConnectionStr1 As String = "server='localhost'; integrated security=True; initial catalog=proxima"
    Dim SqlConnection1 As SqlConnection

    Protected Overrides Sub OnStart(ByVal args() As String)
        SqlConnection1 = New SqlConnection(SqlConnectionStr1)

        timTicker.Interval = 3600000
        timTicker.Enabled = True
    End Sub

    Protected Overrides Sub OnStop()
        timTicker.Enabled = False
    End Sub

    Private Sub timTicker_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles timTicker.Tick
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
    End Sub
End Class
