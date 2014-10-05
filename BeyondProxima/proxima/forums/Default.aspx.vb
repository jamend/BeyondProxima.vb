
Partial Class proxima_forums_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("../LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("../LogOut.aspx", True)
        End If
        Dim Forum As Panel
        Dim Title As HyperLink
        Dim Description As LiteralControl
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT ForumID, ForumName, ForumDescription FROM Forums", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
        If SqlData1.HasRows = True Then
            While SqlData1.Read()
                Forum = New Panel
                Forum.CssClass = "forum"
                Title = New HyperLink
                Title.CssClass = "forumtitle"
                Title.Text = SqlData1.GetString(1)
                Title.NavigateUrl = "Forum.aspx?id=" & SqlData1.GetInt32(0)
                Description = New LiteralControl("<br />" & SqlData1.GetString(2))
                Forum.Controls.Add(Title)
                Forum.Controls.Add(Description)
                pnlForums.Controls.Add(Forum)
            End While
        End If
        Session.Item("SqlConnection").Close()
    End Sub
End Class
