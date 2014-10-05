
Partial Class proxima_UserSettings
    Inherits System.Web.UI.Page

    Dim OldPassword As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("LogOut.aspx", True)
        End If
        lblError.Text = ""
        lblErrorB.Text = ""
        lblEmail.Text = ""
        lblMSN.Text = ""
        lblAIM.Text = ""
        lblICQ.Text = ""
        lblYahoo.Text = ""
        lblAvatar.Text = ""
        lblHomePage.Text = ""
        lblLocation.Text = ""
        lblInterests.Text = ""
        lblOldPassword.Text = ""
        lblPassword.Text = ""
        lblConfirm.Text = ""
        lblError.ForeColor = Drawing.Color.Red
        lblErrorB.ForeColor = Drawing.Color.Red
        LoadSettings()
        aProfile.NavigateUrl = "Profile.aspx?id=" & Session.Item("UserID")
    End Sub

    Private Sub LoadSettings()
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT Email, MSN, AIM, ICQ, Yahoo, Avatar, HomePage, HideContactInfo, Password, Location, Interests FROM Users WHERE UserID = " & Session.Item("UserID"), Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader(CommandBehavior.SingleRow)
        SqlData1.Read()
        txtEmail.Text = SqlData1.GetString(0)
        If SqlData1.IsDBNull(1) Then
            txtMSN.Text = ""
        Else
            txtMSN.Text = SqlData1.GetString(1)
        End If
        If SqlData1.IsDBNull(2) Then
            txtAIM.Text = ""
        Else
            txtAIM.Text = SqlData1.GetString(2)
        End If
        If SqlData1.IsDBNull(3) Then
            txtICQ.Text = ""
        Else
            txtICQ.Text = SqlData1.GetString(3)
        End If
        If SqlData1.IsDBNull(4) Then
            txtYahoo.Text = ""
        Else
            txtYahoo.Text = SqlData1.GetString(4)
        End If
        If SqlData1.IsDBNull(5) Then
            txtAvatar.Text = ""
        Else
            txtAvatar.Text = SqlData1.GetString(5)
        End If
        If SqlData1.IsDBNull(6) Then
            txtHomePage.Text = ""
        Else
            txtHomePage.Text = SqlData1.GetString(6)
        End If
        If SqlData1.IsDBNull(9) Then
            txtLocation.Text = ""
        Else
            txtLocation.Text = SqlData1.GetString(9)
        End If
        If SqlData1.IsDBNull(10) Then
            txtInterests.Text = ""
        Else
            txtInterests.Text = SqlData1.GetString(10)
        End If
        If SqlData1.GetBoolean(7) = True Then
            chkHideContactInfo.Attributes.Item("checked") = "checked"
            chkHideContactInfo.Checked = True
        Else
            chkHideContactInfo.Attributes.Item("checked") = ""
            chkHideContactInfo.Checked = False
        End If
        OldPassword = SqlData1.GetString(8)
        Session.Item("SqlConnection").Close()
    End Sub

    Protected Sub cmdSaveSettings_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSaveSettings.Click
        txtEmail.Text = Request.Params.Item("txtEmail")
        txtMSN.Text = Request.Params.Item("txtMSN")
        txtAIM.Text = Request.Params.Item("txtAIM")
        txtICQ.Text = Request.Params.Item("txtICQ")
        txtYahoo.Text = Request.Params.Item("txtYahoo")
        txtAvatar.Text = Request.Params.Item("txtAvatar")
        txtHomePage.Text = Request.Params.Item("txtHomePage")
        txtLocation.Text = Request.Params.Item("txtLocation")
        txtInterests.Text = Request.Params.Item("txtInterests")
        If Request.Params.Item("chkHideContactInfo") = "on" Then
            chkHideContactInfo.Attributes.Item("checked") = "checked"
            chkHideContactInfo.Checked = True
        Else
            chkHideContactInfo.Attributes.Item("checked") = ""
            chkHideContactInfo.Checked = False
        End If
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
                                                                    Dim SqlCommand1 As New SqlClient.SqlCommand("UPDATE Users SET Email = @Email, MSN = @MSN, AIM = @AIM, ICQ = @ICQ, Yahoo = @Yahoo, Avatar = @Avatar, HomePage = @HomePage, HideContactInfo = @HideContactInfo, Location = @Location, Interests = @Interests WHERE UserID = " & Session.Item("UserID"), Session.Item("SqlConnection"))
                                                                    SqlCommand1.Parameters.Add("@Email", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@Email").Value = Common.Filter(txtEmail.Text)
                                                                    SqlCommand1.Parameters.Add("@MSN", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@MSN").Value = IIf(Len(Common.Filter(txtMSN.Text)) > 0, Common.Filter(txtMSN.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@AIM", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@AIM").Value = IIf(Len(Common.Filter(txtAIM.Text)) > 0, Common.Filter(txtAIM.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@ICQ", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@ICQ").Value = IIf(Len(Common.Filter(txtICQ.Text)) > 0, Common.Filter(txtICQ.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@Yahoo", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@Yahoo").Value = IIf(Len(Common.Filter(txtYahoo.Text)) > 0, Common.Filter(txtYahoo.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@Avatar", SqlDbType.NVarChar, 256)
                                                                    SqlCommand1.Parameters("@Avatar").Value = IIf(Len(Common.Filter(txtAvatar.Text)) > 0, Common.Filter(txtAvatar.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@HomePage", SqlDbType.NVarChar, 256)
                                                                    SqlCommand1.Parameters("@HomePage").Value = IIf(Len(Common.Filter(txtHomePage.Text)) > 0, Common.Filter(txtHomePage.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@Location", SqlDbType.NVarChar, 64)
                                                                    SqlCommand1.Parameters("@Location").Value = IIf(Len(Common.Filter(txtLocation.Text)) > 0, Common.Filter(txtLocation.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@Interests", SqlDbType.NVarChar, 128)
                                                                    SqlCommand1.Parameters("@Interests").Value = IIf(Len(Common.Filter(txtInterests.Text)) > 0, Common.Filter(txtInterests.Text), System.DBNull.Value)
                                                                    SqlCommand1.Parameters.Add("@HideContactInfo", SqlDbType.Bit)
                                                                    SqlCommand1.Parameters("@HideContactInfo").Value = chkHideContactInfo.Checked
                                                                    Session.Item("SqlConnection").Open()
                                                                    SqlCommand1.ExecuteNonQuery()
                                                                    Session.Item("SqlConnection").Close()
                                                                    lblError.ForeColor = Drawing.Color.Blue
                                                                    lblError.Text = "Settings have been saved.<br/><br/>"
                                                                    LoadSettings()
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

    Protected Sub cmdSavePassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSavePassword.Click
        If Len(txtPassword.Text) < 6 Then
            lblPassword.Text = "X"
            lblErrorB.Text = "Error: Password is too short (minimum = 6).<br/><br/>"
        Else
            If Len(txtPassword.Text) > 16 Then
                lblPassword.Text = "X"
                lblErrorB.Text = "Error: Password is too long (max = 16).<br/><br/>"
            Else
                If txtPassword.Text <> txtConfirm.Text Then
                    lblConfirm.Text = "X"
                    lblErrorB.Text = "Error: Password and confirmation don't match.<br/><br/>"
                Else
                    If txtPassword.Text = Session.Item("Username") Then
                        lblPassword.Text = "X"
                        lblErrorB.Text = "Error: Username and password can't match.<br/><br/>"
                    Else
                        If txtOldPassword.Text <> OldPassword Then
                            lblOldPassword.Text = "X"
                            lblErrorB.Text = "Error: Old Password is incorrect.<br/><br/>"
                        Else
                            Dim SqlCommand1 As New SqlClient.SqlCommand("UPDATE Users SET Password = @Password WHERE UserID = " & Session.Item("UserID"), Session.Item("SqlConnection"))
                            SqlCommand1.Parameters.Add("@Password", SqlDbType.NVarChar, 16)
                            SqlCommand1.Parameters("@Password").Value = Common.Filter(txtPassword.Text)
                            Session.Item("SqlConnection").Open()
                            SqlCommand1.ExecuteNonQuery()
                            Session.Item("SqlConnection").Close()
                            lblErrorB.Text = "Password has been saved.<br/><br/>"
                            LoadSettings()
                            lblErrorB.ForeColor = Drawing.Color.Blue
                        End If
                    End If
                End If
            End If
        End If
    End Sub
End Class
