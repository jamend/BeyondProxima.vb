
Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT COUNT(*), (SELECT COUNT(*) FROM Users) FROM Users WHERE LoggedIn = 1", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader(CommandBehavior.SingleRow)
        SqlData1.Read()
        lblStatus.Text = SqlData1.GetInt32(0) & "/" & SqlData1.GetInt32(1) - 1 & " users logged in as of " & System.DateTime.Now.ToString()
        Session.Item("SqlConnection").Close()
    End Sub
End Class
