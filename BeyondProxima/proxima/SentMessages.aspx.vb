
Partial Class proxima_SentMessages
    Inherits System.Web.UI.Page

    Dim LoadedReply As Boolean = False
    Dim LoadedRecipient As Boolean = False

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("LogOut.aspx", True)
        End If

        UpdateMessages()
    End Sub

    Private Sub UpdateMessages()
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT MessageID, Message, dbo.UserLink(Recipient), dbo.UserLink(Sender), DateSent FROM Messages WHERE Sender = " & Session.Item("UserID") & " ORDER BY DateSent DESC", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
        If SqlData1.HasRows = True Then
            lblError.Text = ""
            pnlMessages.Visible = True
            tblMessages.Rows.Clear()
            Dim x As Int32 = 0
            While SqlData1.Read()
                tblMessages.Rows.Add(New System.Web.UI.WebControls.TableRow)
                tblMessages.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblMessages.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblMessages.Rows(x).Cells(1).HorizontalAlign = HorizontalAlign.Center
                tblMessages.Rows(x).Cells(1).Width = Unit.Percentage(0.01)
                tblMessages.Rows(x).Cells(0).Text = "<b>From: " & SqlData1.GetString(3) & "<br>To: " & SqlData1.GetString(2) & "<br>Date: " & SqlData1.GetDateTime(4).ToString(Common.DateTimeFormatString) & "</b><br><br>" & SqlData1.GetString(1)
                tblMessages.Rows(x).Cells(1).Text = "<a href=Messages.aspx?Reply=" & SqlData1.GetInt32(0).ToString & ">Send Follow-up</a>"
                x += 1
            End While
            tblMessages.Visible = True
        Else
            lblError.Text = "You have no sent messages."
            pnlMessages.Visible = False
        End If
        Session.Item("SqlConnection").Close()
    End Sub
End Class
