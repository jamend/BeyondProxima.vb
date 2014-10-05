Partial Class LogIn
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = True Then
            Response.Redirect("proxima/")
            Session.Item("LogInRedirect") = ""
            Response.End()
        End If
        If (Request.Cookies.Item("ProximaRememberMe") Is Nothing) = False Then
            txtUsername.Text = Request.Cookies.Item("ProximaRememberMe").Values.Item("Username")
            txtPassword.Text = Request.Cookies.Item("ProximaRememberMe").Values.Item("Password")
            Call cmdLogIn_Click(Nothing, Nothing)
        End If
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT COUNT(*), (SELECT COUNT(*) FROM Users) FROM Users WHERE LoggedIn = 1", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader(CommandBehavior.SingleRow)
        SqlData1.Read()
        lblStatus.Text = SqlData1.GetInt32(0) & "/" & SqlData1.GetInt32(1) - 1 & " users logged in as of " & System.DateTime.Now.ToString(Common.DateTimeFormatString)
        Session.Item("SqlConnection").Close()
    End Sub

    Protected Sub cmdLogIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdLogIn.Click
        If txtUsername.Text = "" Then
            lblError.Text = "Error: Username is blank.<br/><br/>"
        Else
            If txtPassword.Text = "" Then
                lblError.Text = "Error: Password is blank.<br/><br/>"
            Else
                Randomize()
                Dim SessionID As Int64 = Math.Round(Rnd() * 9223372036854775807, 0)
                Dim SqlCommand1 As New SqlClient.SqlCommand("dbo.LogIn", Session.Item("SqlConnection"))
                SqlCommand1.CommandType = CommandType.StoredProcedure
                SqlCommand1.Parameters.Add("@Username", SqlDbType.NVarChar, 16)
                SqlCommand1.Parameters("@Username").Value = Left(txtUsername.Text, 16)
                SqlCommand1.Parameters.Add("@Password", SqlDbType.NVarChar, 16)
                SqlCommand1.Parameters("@Password").Value = Left(txtPassword.Text, 16)
                SqlCommand1.Parameters.Add("@IP", SqlDbType.NVarChar, 16)
                SqlCommand1.Parameters("@IP").Value = Request.UserHostAddress
                SqlCommand1.Parameters.Add("@SessionID", SqlDbType.BigInt)
                SqlCommand1.Parameters("@SessionID").Value = SessionID
                SqlCommand1.Parameters.Add("@UserID", SqlDbType.Int)
                SqlCommand1.Parameters("@UserID").Direction = ParameterDirection.Output
                SqlCommand1.Parameters.Add("@AccessLevel", SqlDbType.TinyInt)
                SqlCommand1.Parameters("@AccessLevel").Direction = ParameterDirection.Output
                SqlCommand1.Parameters.Add("@Result", SqlDbType.Int)
                SqlCommand1.Parameters("@Result").Direction = ParameterDirection.Output
                Session.Item("SqlConnection").Open()
                SqlCommand1.ExecuteNonQuery()
                Select Case SqlCommand1.Parameters("@Result").Value
                    Case 0 'failed
                        lblError.Text = "Account not found or invalid password.<BR>The failed attempt has been logged.<br/><br/>"
                    Case 1 'too many attempts on this account
                        lblError.Text = "You have made too many failed attempts to log into this account.<br/>Please try again in one hour.<br/><br/>"
                    Case 2 'too many attempts on any account
                        lblError.Text = "You have made too many failed attempts to log in to Beyond Proxima.<br/>Please try again in one hour.<br/><br/>"
                    Case 3 'suspended
                        lblError.Text = "Your account has been suspended."
                    Case 4 'dead
                        lblError.Text = "Your account has died."
                    Case 5
                        lblError.Text = "Please wait for the server to process the turn"
                    Case 6 'logged in
                        If chkRemember.Checked = True Then
                            Dim ProximaRememberMeCookie As New System.Web.HttpCookie("ProximaRememberMe")
                            ProximaRememberMeCookie.Expires = System.DateTime.Now.AddYears(30)
                            ProximaRememberMeCookie.Values.Add("Username", txtUsername.Text)
                            ProximaRememberMeCookie.Values.Add("Password", txtPassword.Text)
                            Response.Cookies.Add(ProximaRememberMeCookie)
                        End If
                        Session.Item("LoggedIn") = True
                        Session.Item("UserID") = SqlCommand1.Parameters("@UserID").Value
                        Session.Item("AccessLevel") = SqlCommand1.Parameters("@AccessLevel").Value
                        Session.Item("Username") = SqlCommand1.Parameters("@Username").Value
                        Session.Item("SessionID") = SessionID
                        Session.Item("ShipSpeed") = 1
                        Session.Item("SqlConnection").Close()
                        Response.Redirect("proxima/")
                        Session.Item("LogInRedirect") = ""
                        Response.End()
                End Select
                Session.Item("SqlConnection").Close()
            End If
        End If
        lblError.Text = "<p>" & lblError.Text & "<p/>"
    End Sub
End Class
