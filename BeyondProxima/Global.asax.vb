
Public Class Global_asax
    Inherits HttpApplication
    Dim SqlConnectionStr As String = "server='localhost'; integrated security=True; initial catalog=proxima"

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Dim PlanetsPath As String = Server.MapPath("/images/planets/")
        Application.Item("Barren16") = System.Drawing.Image.FromFile(PlanetsPath & "barren16.gif")
        Application.Item("Desert16") = System.Drawing.Image.FromFile(PlanetsPath & "desert16.gif")
        Application.Item("GasGiant16") = System.Drawing.Image.FromFile(PlanetsPath & "gasgiant16.gif")
        Application.Item("Ice16") = System.Drawing.Image.FromFile(PlanetsPath & "ice16.gif")
        Application.Item("Jungle16") = System.Drawing.Image.FromFile(PlanetsPath & "jungle16.gif")
        Application.Item("Rock16") = System.Drawing.Image.FromFile(PlanetsPath & "rock16.gif")
        Application.Item("Terran16") = System.Drawing.Image.FromFile(PlanetsPath & "terran16.gif")
        Application.Item("Volcanic16") = System.Drawing.Image.FromFile(PlanetsPath & "volcanic16.gif")
        Application.Item("SqlConnectionStr") = SqlConnectionStr
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        If Session.Item("LoggedIn") = True Then Common.LoggedIn(Session.Item("UserID"), False, Application.Item("SqlConnectionStr"))
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Session.Item("SqlConnection").Close()
        Catch
        End Try
        Dim SqlCommand1 As New SqlClient.SqlCommand("INSERT INTO ErrorLog(ErrorDate, Message, Stack, UserID, LoggedIn, RawURL, ErrorIP) VALUES (@ErrorDate, @Message, @Stack, @UserID, @LoggedIn, @RawURL, @ErrorIP)", New SqlClient.SqlConnection(SqlConnectionStr))
        SqlCommand1.Parameters.Add("@Message", SqlDbType.NVarChar, 256)
        SqlCommand1.Parameters(0).Value = Server.GetLastError.GetBaseException.Message
        SqlCommand1.Parameters.Add("@Stack", SqlDbType.NVarChar, 1024)
        SqlCommand1.Parameters(1).Value = Common.Filter(Server.GetLastError.GetBaseException.StackTrace)
        SqlCommand1.Parameters.Add("@UserID", SqlDbType.SmallInt)
        SqlCommand1.Parameters.Add("@LoggedIn", SqlDbType.Bit)
        Try
            SqlCommand1.Parameters(2).Value = Val(Session.Item("UserID"))
            SqlCommand1.Parameters(3).Value = Session.Item("LoggedIn")
        Catch
            SqlCommand1.Parameters(2).Value = 0
            SqlCommand1.Parameters(3).Value = 0
        End Try
        SqlCommand1.Parameters.Add("@RawURL", SqlDbType.NVarChar, 256)
        Try
            SqlCommand1.Parameters(4).Value = Request.RawUrl
        Catch
            SqlCommand1.Parameters(4).Value = "No RawURL"
        End Try
        SqlCommand1.Parameters.Add("@ErrorIP", SqlDbType.NVarChar, 16)
        Try
            SqlCommand1.Parameters(5).Value = Request.UserHostAddress
        Catch
            SqlCommand1.Parameters(5).Value = "No IP"
        End Try
        SqlCommand1.Parameters.Add("@ErrorDate", SqlDbType.DateTime, 16)
        SqlCommand1.Parameters(6).Value = System.DateTime.Now
        SqlCommand1.Connection.Open()
        SqlCommand1.ExecuteNonQuery()
        SqlCommand1.Connection.Close()
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Session.Item("SqlConnection") = New SqlClient.SqlConnection(Application.Item("SqlConnectionStr"))
        Session.Item("LoggedIn") = False
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        If Session.Item("LoggedIn") = True Then Common.LoggedIn(Session.Item("UserID"), False, Application.Item("SqlConnectionStr"))
    End Sub
End Class