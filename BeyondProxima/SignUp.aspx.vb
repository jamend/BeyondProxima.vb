
Partial Class SignUp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblError.Text = ""
        lblUsername.Text = ""
        lblPassword.Text = ""
        lblConfirm.Text = ""
        lblEmail.Text = ""
        lblMSN.Text = ""
        lblAIM.Text = ""
        lblICQ.Text = ""
        lblYahoo.Text = ""
        lblLocation.Text = ""
        lblInterests.Text = ""
        lblAvatar.Text = ""
        lblHomePage.Text = ""
        lblError.ForeColor = Drawing.Color.Red
        If Session.Item("LoggedIn") = True Then
            Response.Redirect("proxima/", True)
        End If
    End Sub

    Protected Sub cmdSignUp_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSignUp.Click
        If Len(Common.Filter(txtUsername.Text)) = 0 Then
            lblUsername.Text = "X"
            lblError.Text = "Error: Username cannot be blank.<br/><br/>"
        Else
            If Len(Common.Filter(txtUsername.Text)) > 32 Then
                lblUsername.Text = "X"
                lblError.Text = "Error: Username is too long (max = 16).<br/><br/>"
            Else
                If Len(txtPassword.Text) < 6 Then
                    lblPassword.Text = "X"
                    lblError.Text = "Error: Password is too short (minimum = 6).<br/><br/>"
                Else
                    If Len(txtPassword.Text) > 16 Then
                        lblPassword.Text = "X"
                        lblError.Text = "Error: Password is too long (max = 16).<br/><br/>"
                    Else
                        If txtPassword.Text <> txtConfirm.Text Then
                            lblConfirm.Text = "X"
                            lblError.Text = "Error: Password and confirmation don't match.<br/><br/>"
                        Else
                            If txtPassword.Text = Common.Filter(txtUsername.Text) Then
                                lblPassword.Text = "X"
                                lblUsername.Text = "X"
                                lblError.Text = "Error: Username and password can't match.<br/><br/>"
                            Else
                                If Len(Common.Filter(txtEmail.Text)) = 0 Then
                                    lblEmail.Text = "X"
                                    lblError.Text = "Error: Email cannot be blank.<br/><br/>"
                                Else
                                    If Len(Common.Filter(txtEmail.Text.Length)) > 64 Then
                                        lblEmail.Text = "X"
                                        lblError.Text = "Error: Email is too long (max = 64).<br/><br/>"
                                    Else
                                        Dim RegExpVerifier As New System.Text.RegularExpressions.Regex("^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$")
                                        If RegExpVerifier.IsMatch(txtEmail.Text) = False Then
                                            lblEmail.Text = "X"
                                            lblError.Text = "Error: Email is invalid.<br/><br/>"
                                        Else
                                            If Len(Common.Filter(txtMSN.Text)) > 64 Then
                                                lblMSN.Text = "X"
                                                lblError.Text = "Error: MSN is too long (max = 64).<br/><br/>"
                                            Else
                                                If Len(Common.Filter(txtMSN.Text)) > 0 And RegExpVerifier.IsMatch(txtMSN.Text) = False Then
                                                    lblMSN.Text = "X"
                                                    lblError.Text = "Error: MSN is invalid.<br/><br/>"
                                                Else
                                                    If Len(Common.Filter(txtAIM.Text)) > 64 Then
                                                        lblAIM.Text = "X"
                                                        lblError.Text = "Error: AIM is too long (max = 64).<br/><br/>"
                                                    Else
                                                        If Len(Common.Filter(txtICQ.Text)) > 32 Then
                                                            lblICQ.Text = "X"
                                                            lblError.Text = "Error: ICQ is too long (max = 64).<br/><br/>"
                                                        Else
                                                            If Len(Common.Filter(txtYahoo.Text)) > 64 Then
                                                                lblYahoo.Text = "X"
                                                                lblError.Text = "Error: Yahoo is too long (max = 64).<br/><br/>"
                                                            Else
                                                                If Len(Common.Filter(txtYahoo.Text)) > 0 And RegExpVerifier.IsMatch(txtYahoo.Text) = False Then
                                                                    lblYahoo.Text = "X"
                                                                    lblError.Text = "Error: Yahoo is invalid.<br/><br/>"
                                                                Else
                                                                    If Len(Common.Filter(txtAvatar.Text)) > 256 Then
                                                                        lblAvatar.Text = "X"
                                                                        lblError.Text = "Error: Avatar URL is too long (max = 256).<br/><br/>"
                                                                    Else
                                                                        If Len(Common.Filter(txtHomePage.Text)) > 256 Then
                                                                            lblHomePage.Text = "X"
                                                                            lblError.Text = "Error: Home page is too long (max = 256).<br/><br/>"
                                                                        Else
                                                                            If Len(Common.Filter(txtAvatar.Text)) > 0 And InStr(UCase(txtAvatar.Text), "HTTP://") = 0 And InStr(UCase(txtAvatar.Text), "FTP://") = 0 Then
                                                                                lblAvatar.Text = "X"
                                                                                lblError.Text = "Error: Avatar URL is invalid (must contain http:// or ftp://).<br/><br/>"
                                                                            Else
                                                                                If Len(Common.Filter(txtHomePage.Text)) > 0 And InStr(UCase(txtHomePage.Text), "HTTP://") = 0 And InStr(UCase(txtHomePage.Text), "FTP://") = 0 Then
                                                                                    lblHomePage.Text = "X"
                                                                                    lblError.Text = "Error: Home page is invalid (must contain http:// or ftp://).<br/><br/>"
                                                                                Else
                                                                                    If Len(Common.Filter(txtLocation.Text)) > 64 Then
                                                                                        lblLocation.Text = "X"
                                                                                        lblError.Text = "Error: Location is too long (max = 64).<br/><br/>"
                                                                                    Else
                                                                                        If Len(Common.Filter(txtInterests.Text)) > 128 Then
                                                                                            lblInterests.Text = "X"
                                                                                            lblError.Text = "Error: Interests are too long (max = 128).<br/><br/>"
                                                                                        Else
                                                                                            Randomize()
                                                                                            Dim ActivationCode As Int64 = Math.Round(Rnd() * 9223372036854775807, 0)
                                                                                            Dim SqlCommand1 As New SqlClient.SqlCommand("dbo.SignUp", Session.Item("SqlConnection"))
                                                                                            SqlCommand1.CommandType = CommandType.StoredProcedure
                                                                                            SqlCommand1.Parameters.Add("@IP", SqlDbType.NVarChar, 16)
                                                                                            SqlCommand1.Parameters("@IP").Value = Request.UserHostAddress
                                                                                            SqlCommand1.Parameters.Add("@ActivationCode", SqlDbType.BigInt)
                                                                                            SqlCommand1.Parameters("@ActivationCode").Value = ActivationCode
                                                                                            SqlCommand1.Parameters.Add("@Username", SqlDbType.NVarChar, 16)
                                                                                            SqlCommand1.Parameters("@Username").Value = Common.Filter(txtUsername.Text)
                                                                                            SqlCommand1.Parameters.Add("@Password", SqlDbType.NVarChar, 16)
                                                                                            SqlCommand1.Parameters("@Password").Value = txtPassword.Text
                                                                                            SqlCommand1.Parameters.Add("@Email", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@Email").Value = Common.Filter(txtEmail.Text)
                                                                                            SqlCommand1.Parameters.Add("@MSN", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@MSN").Value = Common.Filter(txtMSN.Text)
                                                                                            SqlCommand1.Parameters.Add("@AIM", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@AIM").Value = Common.Filter(txtAIM.Text)
                                                                                            SqlCommand1.Parameters.Add("@ICQ", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@ICQ").Value = Common.Filter(txtICQ.Text)
                                                                                            SqlCommand1.Parameters.Add("@Yahoo", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@Yahoo").Value = Common.Filter(txtYahoo.Text)
                                                                                            SqlCommand1.Parameters.Add("@Avatar", SqlDbType.NVarChar, 256)
                                                                                            SqlCommand1.Parameters("@Avatar").Value = Common.Filter(txtAvatar.Text)
                                                                                            SqlCommand1.Parameters.Add("@HomePage", SqlDbType.NVarChar, 256)
                                                                                            SqlCommand1.Parameters("@HomePage").Value = Common.Filter(txtHomePage.Text)
                                                                                            SqlCommand1.Parameters.Add("@Location", SqlDbType.NVarChar, 64)
                                                                                            SqlCommand1.Parameters("@Location").Value = Common.Filter(txtLocation.Text)
                                                                                            SqlCommand1.Parameters.Add("@Interests", SqlDbType.NVarChar, 128)
                                                                                            SqlCommand1.Parameters("@Interests").Value = Common.Filter(txtInterests.Text)
                                                                                            SqlCommand1.Parameters.Add("@HideContactInfo", SqlDbType.Bit)
                                                                                            SqlCommand1.Parameters("@HideContactInfo").Value = chkHideContactInfo.Checked
                                                                                            SqlCommand1.Parameters.Add("@Result", SqlDbType.Int)
                                                                                            SqlCommand1.Parameters("@Result").Direction = ParameterDirection.ReturnValue
                                                                                            Session.Item("SqlConnection").Open()
                                                                                            SqlCommand1.ExecuteNonQuery()
                                                                                            Select Case SqlCommand1.Parameters("@Result").Value
                                                                                                Case 0
                                                                                                    lblError.Text = "Error: You've already signed up.<br/><br/>"
                                                                                                Case 1
                                                                                                    lblError.Text = "Error: Username in use.<br/><br/>"
                                                                                                Case 2
                                                                                                    lblError.Text = "Error: Contact info in use.<br/><br/>"
                                                                                                Case 3
                                                                                                    lblError.Text = "Error: You are banned.<br/><br/>"
                                                                                                    Session.Item("SqlConnection").Close()
                                                                                                    SqlCommand1.CommandType = CommandType.Text
                                                                                                    SqlCommand1.CommandText = "INSERT INTO Bans(Email, IP, Username, MSN, AIM, Yahoo, ICQ) VALUES (@Email, @IP, @Username, @MSN, @AIM, @Yahoo, @ICQ)"
                                                                                                    SqlCommand1.Parameters.Add("@IP", SqlDbType.NVarChar, 16)
                                                                                                    SqlCommand1.Parameters(0).Value = Request.UserHostAddress
                                                                                                    SqlCommand1.Parameters.Add("@Username", SqlDbType.NVarChar, 16)
                                                                                                    SqlCommand1.Parameters(1).Value = txtUsername.Text
                                                                                                    SqlCommand1.Parameters.Add("@Email", SqlDbType.NVarChar, 64)
                                                                                                    SqlCommand1.Parameters(2).Value = Common.Filter(txtEmail.Text)
                                                                                                    SqlCommand1.Parameters.Add("@MSN", SqlDbType.NVarChar, 64)
                                                                                                    SqlCommand1.Parameters(2).Value = Common.Filter(txtMSN.Text)
                                                                                                    SqlCommand1.Parameters.Add("@AIM", SqlDbType.NVarChar, 64)
                                                                                                    SqlCommand1.Parameters(2).Value = Common.Filter(txtAIM.Text)
                                                                                                    SqlCommand1.Parameters.Add("@Yahoo", SqlDbType.NVarChar, 64)
                                                                                                    SqlCommand1.Parameters(2).Value = Common.Filter(txtYahoo.Text)
                                                                                                    SqlCommand1.Parameters.Add("@ICQ", SqlDbType.NVarChar, 64)
                                                                                                    SqlCommand1.Parameters(2).Value = Common.Filter(txtICQ.Text)
                                                                                                    Session.Item("SqlConnection").Open()
                                                                                                    SqlCommand1.ExecuteNonQuery()
                                                                                                Case 4
                                                                                                    'Dim ActivateEmail As New Mail.MailMessage
                                                                                                    'ActivateEmail.To = Common.FilterString(txtEmail.Text)
                                                                                                    'ActivateEmail.From = "administrator@sklone.homeip.net"
                                                                                                    'ActivateEmail.Subject = "Your SKlone Activation Code"
                                                                                                    'ActivateEmail.BodyFormat = Mail.MailFormat.Text
                                                                                                    'ActivateEmail.Body = ActivationCode
                                                                                                    'Mail.SmtpMail.SmtpServer = "127.0.0.1"
                                                                                                    'Mail.SmtpMail.Send(ActivateEmail)
                                                                                                    lblError.Text = "Account created.<br/><br/>"
                                                                                                    lblError.ForeColor = Drawing.Color.Blue
                                                                                            End Select
                                                                                        End If
                                                                                        Session.Item("SqlConnection").Close()
                                                                                    End If
                                                                                End If
                                                                            End If
                                                                        End If
                                                                    End If
                                                                End If
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub
End Class
