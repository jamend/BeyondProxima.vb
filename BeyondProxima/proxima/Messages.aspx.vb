
Partial Class proxima_Messages
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

        Dim Reply As Integer = CInt(Request.Params.Item("Reply"))
        If Reply = 0 Then
            If LoadedRecipient = False Then
                Dim UserID As Integer = CInt(Request.Params.Item("id"))
                If UserID > 0 Then
                    Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT UserID, Username FROM Users WHERE UserID = " & UserID, Session.Item("SqlConnection"))
                    Session.Item("SqlConnection").Open()
                    Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
                    If SqlData1.HasRows = True Then
                        SqlData1.Read()
                        txtUserID.Text = SqlData1.GetInt16(0)
                        txtUsername.Text = SqlData1.GetString(1)
                    End If
                    Session.Item("SqlConnection").Close()
                End If
                LoadedRecipient = True
            End If
        Else
            If LoadedReply = False Then
                Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT Messages.Message, Users.Username, Messages.DateSent, Messages.Sender FROM Messages, Users WHERE Messages.Sender = Users.UserID AND Messages.Recipient = " & Session.Item("UserID") & " AND Messages.MessageID = " & Reply, Session.Item("SqlConnection"))
                Session.Item("SqlConnection").Open()
                Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
                If SqlData1.HasRows = True Then
                    SqlData1.Read()
                    txtMessage.Text = vbCrLf & vbCrLf & vbCrLf & ">In Reply to the following message:" & vbCrLf & ">" & vbCrLf & ">From: " & SqlData1.GetString(1) & vbCrLf & ">To: " & Session.Item("Username") & vbCrLf & ">Date: " & SqlData1.GetDateTime(2).ToString(Common.DateTimeFormatString) & vbCrLf & ">" & vbCrLf & ">" & Replace(Common.RevFilter(SqlData1.GetString(0)), vbCrLf, vbCrLf & ">")
                    txtUsername.Text = SqlData1.GetString(1)
                    txtUserID.Text = SqlData1.GetInt16(3)
                End If
                Session.Item("SqlConnection").Close()
                LoadedReply = True
            End If
        End If

        UpdateMessages()
        lblError.ForeColor = Drawing.Color.Red
        txtMessage.Style.Add("height", "184px")
        txtMessage.Style.Add("width", "337px")
        txtUsername.Style.Add("width", "138px")
        txtUserID.Style.Add("width", "56px")
    End Sub

    Private Sub UpdateMessages()
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT Messages.MessageID, Messages.Message, dbo.UserLink(Messages.Recipient), dbo.UserLink(Messages.Sender), Messages.DateSent, Messages.MessageRead, CASE WHEN Len(Users.Avatar) > 0 THEN '<br><br><a href=""Profile.aspx?id=' + CAST(Messages.Sender AS nvarchar(8)) + '""><img width=96 height=96 border=0 src=""' + Users.Avatar + '""></a>' ELSE '' END FROM Messages, Users WHERE Users.UserID = Messages.Sender AND Messages.RecipientDeleted = 0 AND Messages.Recipient = " & Session.Item("UserID") & " ORDER BY Messages.DateSent DESC", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
        If SqlData1.HasRows = True Then
            lblHaveMessages.Text = ""
            pnlMessages.Visible = True
            tblMessages.Rows.Clear()
            Dim x As Int32 = 0
            While SqlData1.Read()
                tblMessages.Rows.Add(New System.Web.UI.WebControls.TableRow)
                tblMessages.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblMessages.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblMessages.Rows(x).Cells(0).VerticalAlign = VerticalAlign.Top
                tblMessages.Rows(x).Cells(1).HorizontalAlign = HorizontalAlign.Center
                tblMessages.Rows(x).Cells(1).Width = Unit.Percentage(0.01)
                tblMessages.Rows(x).Cells(0).Text = "<b>From: " & SqlData1.GetString(3) & "<br>To: " & SqlData1.GetString(2) & "<br>Date: " & SqlData1.GetDateTime(4).ToString(Common.DateTimeFormatString) & "</b><br><br>" & SqlData1.GetString(1)
                tblMessages.Rows(x).Cells(1).Text = "<input type=checkbox name=" & SqlData1.GetInt32(0).ToString & " value=" & SqlData1.GetInt32(0).ToString & ">Delete<br><br><a href=Messages.aspx?Reply=" & SqlData1.GetInt32(0).ToString & ">Reply</a>" + SqlData1.GetString(6)
                If SqlData1.GetBoolean(5) = False Then tblMessages.Rows(x).BackColor = System.Drawing.Color.FromArgb(&H0, 223, 239, 255)
                x += 1
            End While
            Session.Item("SqlConnection").Close()

            SqlCommand1.CommandText = "UPDATE Messages SET MessageRead = 1 WHERE MessageRead = 0 AND Recipient = " & Session.Item("UserID")
            Session.Item("SqlConnection").Open()
            SqlCommand1.ExecuteScalar()

            tblMessages.Visible = True
        Else
            lblHaveMessages.Text = "You have no messages."
            pnlMessages.Visible = False
        End If
        Session.Item("SqlConnection").Close()
    End Sub

    Private Sub cmdDeleteSelected_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDeleteSelected.Click
        Dim x As Int32
        Dim SqlCommand1 As New SqlClient.SqlCommand("", Session.Item("SqlConnection"))
        For x = 0 To Request.Params.Count - 1
            SqlCommand1.CommandText = "UPDATE Messages SET RecipientDeleted = 1 WHERE MessageID = " & Val(Request.Params.Item(x)).ToString & " AND Recipient = " & Session.Item("UserID")
            Session.Item("SqlConnection").Open()
            SqlCommand1.ExecuteNonQuery()
            Session.Item("SqlConnection").Close()
        Next
        lblError.Text = "The selected messages have been deleted.<br/><br/>"
        lblError.ForeColor = Drawing.Color.Blue
        UpdateMessages()
    End Sub

    Private Sub cmdSendMessage_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSendMessage.Click
        Dim Message As String = Common.Filter(Request.Params("txtMessage"))
        Dim SqlCommand1 As New SqlClient.SqlCommand("dbo.SendMessage", Session.Item("SqlConnection"))
        SqlCommand1.CommandType = CommandType.StoredProcedure
        If Len(txtMessage.Text) = 0 Then
            lblError.Text = "Error: Your message cannot be blank<br/><br/>"
        Else
            If Len(Message) > 4000 Then
                lblError.Text = "Error: Your message is too long (max = 4000)<br/><br/>"
            Else
                If Len(txtUsername.Text) + Len(txtUserID.Text) = 0 Then
                    lblError.Text = "Error: You must specify a user to send the message to<br/><br/>"
                Else
                    SqlCommand1.Parameters.Add(New SqlClient.SqlParameter("@Message", Message))
                    SqlCommand1.Parameters.Add(New SqlClient.SqlParameter("@RecipientUsername", Left(txtUsername.Text, 16)))
                    SqlCommand1.Parameters.Add(New SqlClient.SqlParameter("@RecipientUserID", Val(txtUserID.Text)))
                    SqlCommand1.Parameters.Add(New SqlClient.SqlParameter("@Sender", Session.Item("UserID")))
                    SqlCommand1.Parameters.Add("@Result", SqlDbType.Int)
                    SqlCommand1.Parameters("@Result").Direction = ParameterDirection.Output
                    SqlCommand1.Parameters.Add("@Recipient", SqlDbType.Int)
                    SqlCommand1.Parameters("@Recipient").Direction = ParameterDirection.Output
                    SqlCommand1.Parameters.Add("@RecipientName", SqlDbType.NVarChar, 16)
                    SqlCommand1.Parameters("@RecipientName").Direction = ParameterDirection.Output
                    Session.Item("SqlConnection").Open()
                    SqlCommand1.ExecuteNonQuery()
                    Select Case SqlCommand1.Parameters("@Result").Value
                        Case 0 'user not found
                            lblError.Text = "Error: The username or user ID was not found<br/><br/>"
                        Case 1 'too many messages for this turn
                            lblError.Text = "Error: You cannot send more than 15 messages per turn<br/><br/>"
                        Case 2 'message sent
                            lblError.Text = "The message has been sent to " & SqlCommand1.Parameters("@RecipientName").Value & " (User ID " & Str(SqlCommand1.Parameters("@Recipient").Value) & ").<br/><br/>"
                            lblError.ForeColor = Drawing.Color.Blue
                    End Select
                    Session.Item("SqlConnection").Close()
                    UpdateMessages()
                End If
            End If
        End If
    End Sub
End Class
