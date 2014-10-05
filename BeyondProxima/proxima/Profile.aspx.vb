
Partial Class proxima_Profile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("LogOut.aspx", True)
        End If

        Dim UserID As Integer = CInt(Request.Item("id"))
        If UserID = 0 Then
            lblError.Text = "Error: The user could not be found"
            pnlProfile.Visible = False
        Else
            Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT Users.Username, COUNT(Planets.PlanetID) AS TotalPlanets, COUNT(Ships.ShipID) AS TotalShips, Users.Email, Users.MSN, Users.AIM, Users.ICQ, Users.Yahoo, Users.Avatar, Users.HomePage, Users.HideContactInfo, Users.Location, Users.Interests FROM Users LEFT OUTER JOIN Fleets ON Users.UserID = Fleets.UserID LEFT OUTER JOIN Ships ON Ships.FleetID = Fleets.FleetID LEFT OUTER JOIN Systems ON Users.UserID = Systems.UserID LEFT OUTER JOIN Planets ON Planets.SystemID = Systems.SystemID GROUP BY Users.Username, Users.HideContactInfo, Users.Email, Users.MSN, Users.AIM, Users.ICQ, Users.Yahoo, Users.UserID, Users.Avatar, Users.HomePage, Users.Location, Users.Interests HAVING Users.UserID = " & UserID.ToString, Session.Item("SqlConnection"))
            Session.Item("SqlConnection").Open()
            Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader(CommandBehavior.SingleRow)
            If SqlData1.HasRows = False Then
                aSendMessage.Text = ""
                aSendMessage.NavigateUrl = ""
                lblError.Text = "Error: The user could not be found"
                pnlProfile.Visible = False
            Else
                SqlData1.Read()
                lblUsername.Text = SqlData1.GetString(0)
                lblUserID.Text = UserID.ToString
                lblPlanets.Text = SqlData1.GetInt32(1).ToString(Common.NumberFormatString)
                lblShips.Text = SqlData1.GetInt32(2).ToString(Common.NumberFormatString)
                If SqlData1.GetBoolean(10) = True Then
                    lblEmail.Text = "Prefers not to disclose"
                    lblMSN.Text = "Prefers not to disclose"
                    lblAIM.Text = "Prefers not to disclose"
                    lblICQ.Text = "Prefers not to disclose"
                    lblYahoo.Text = "Prefers not to disclose"
                Else
                    lblEmail.Text = "<a href=""mailto:" & SqlData1.GetString(3) & """>" & SqlData1.GetString(3) & "</a>"
                    If SqlData1.IsDBNull(4) = False Then
                        lblMSN.Text = SqlData1.GetString(4)
                    Else
                        lblMSN.Text = "Not Given"
                    End If
                    If SqlData1.IsDBNull(5) = False Then
                        lblAIM.Text = "<a href=""aim:goim?screenname=" & SqlData1.GetString(5) & """>" & SqlData1.GetString(5) & "</a>"
                    Else
                        lblAIM.Text = "Not given"
                    End If
                    If SqlData1.IsDBNull(6) = False Then
                        lblICQ.Text = "<a href=""http://wwp.icq.com/scripts/search.dll?to=" & SqlData1.GetString(6) & """>" & SqlData1.GetString(6) & "</a>"
                    Else
                        lblICQ.Text = "Not given"
                    End If
                    If SqlData1.IsDBNull(7) = False Then
                        lblYahoo.Text = SqlData1.GetString(7)
                    Else
                        lblYahoo.Text = "Not given"
                    End If
                End If
                If SqlData1.IsDBNull(11) = False Then
                    lblLocation.Text = SqlData1.GetString(11)
                Else
                    lblLocation.Text = "Not given"
                End If
                If SqlData1.IsDBNull(12) = False Then
                    lblInterests.Text = SqlData1.GetString(12)
                Else
                    lblInterests.Text = "None given"
                End If
                If UserID = Session.Item("UserID") Then
                    aSendMessage.Text = "Edit your profile"
                    aSendMessage.NavigateUrl = "UserSettings.aspx"
                Else
                    aSendMessage.Text = "Send a message to this user"
                    aSendMessage.NavigateUrl = "Messages.aspx?id=" & UserID.ToString
                End If
                lblError.Text = ""
                pnlProfile.Visible = True
                If SqlData1.IsDBNull(8) = False Then
                    imgAvatar.ImageUrl = SqlData1.GetString(8)
                    pnlAvatar.Visible = True
                Else
                    pnlAvatar.Visible = False
                End If
                If SqlData1.IsDBNull(9) = False Then
                    aHomePage.NavigateUrl = SqlData1.GetString(9)
                    aHomePage.Text = SqlData1.GetString(9)
                Else
                    aHomePage.Text = "Not given"
                End If
            End If
            Session.Item("SqlConnection").Close()
        End If
    End Sub
End Class
