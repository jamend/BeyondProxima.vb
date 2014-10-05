
Partial Class proxima_Overview
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("LogOut.aspx", True)
        End If
    End Sub
End Class
