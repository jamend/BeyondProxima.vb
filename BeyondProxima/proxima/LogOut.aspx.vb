Partial Class proxima_LogOut
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = True Then
            lblLoggedOut.Text = "You have been logged out."
            Dim ProximaRememberMeCookie As New System.Web.HttpCookie("ProximaRememberMe")
            ProximaRememberMeCookie.Expires = DateTime.Now.AddYears(-30)
            ProximaRememberMeCookie.Values.Add("Username", "")
            ProximaRememberMeCookie.Values.Add("Password", "")
            Response.Cookies.Add(ProximaRememberMeCookie)
            Session.Abandon()
        Else
            lblLoggedOut.Text = "You are already logged out."
        End If
    End Sub
End Class
