
Partial Class proxima_forums_Thread
    Inherits System.Web.UI.Page

    Dim ThreadID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("../LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("../LogOut.aspx", True)
        End If

        ThreadID = CInt(Request.Item("id"))

        If Session.Item("AccessLevel") > 2 Then
            cmdDeletePosts.Visible = True
        Else
            cmdDeletePosts.Visible = False
        End If

        Session.Item("SqlConnection").Open()
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT Forums.ForumName + ': ' + Threads.ThreadName FROM Forums INNER JOIN Threads ON Forums.ForumID = Threads.ForumID WHERE Threads.ThreadID = " & ThreadID, Session.Item("SqlConnection"))
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
        If SqlData1.HasRows Then
            SqlData1.Read()
            ThreadName.Text = SqlData1.GetString(0)
            Session.Item("SqlConnection").Close()
        Else
            Session.Item("SqlConnection").Close()
            Response.Redirect("Default.aspx", True)
        End If

        SqlCommand1.CommandText = "SELECT * FROM PostsView WHERE ThreadID = " & ThreadID
        Session.Item("SqlConnection").Open()
        SqlData1 = SqlCommand1.ExecuteReader
        If SqlData1.HasRows = False Then
            Session.Item("SqlConnection").Close()
            Response.Redirect("Default.aspx", True)
        Else
            Dim x As Int32 = 0
            While SqlData1.Read()
                tblPosts.Rows.Add(New System.Web.UI.WebControls.TableRow)
                tblPosts.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblPosts.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                If Session.Item("AccessLevel") > 2 Then
                    tblPosts.Rows(x).Cells(0).Text = SqlData1.GetString(2) & "<br><br><input type=""checkbox"" name=""" & SqlData1.GetInt32(0) & """ value=""" & SqlData1.GetInt32(0) & """>Delete"
                Else
                    tblPosts.Rows(x).Cells(0).Text = SqlData1.GetString(2)
                End If
                tblPosts.Rows(x).Cells(0).VerticalAlign = VerticalAlign.Top
                tblPosts.Rows(x).Cells(1).VerticalAlign = VerticalAlign.Top
                tblPosts.Rows(x).Cells(0).Width = New System.Web.UI.WebControls.Unit("10%")
                tblPosts.Rows(x).Cells(1).Text = "<u>Posted " & SqlData1.GetDateTime(3).ToString(Common.DateTimeFormatString) & "</u><br><br>" & SqlData1.GetString(1)
                tblPosts.Rows(x).Cells(1).Width = New System.Web.UI.WebControls.Unit("90%")
                x += 1
            End While
            Session.Item("SqlConnection").Close()
            Session.Item("SqlConnection").Open()
            SqlCommand1.CommandText = "UPDATE Threads SET Views = Views + 1 WHERE ThreadID = " & ThreadID
            SqlCommand1.ExecuteNonQuery()
            Session.Item("SqlConnection").Close()
        End If

        Feedback.Text = ""
        lblError.Text = ""
    End Sub

    Protected Sub cmdPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdPost.Click
        Dim Message As String = Common.Filter(txtMessage.Text)
        Dim PostID As Integer
        If Len(Message) = 0 Then
            lblError.Text = "Error: Your message cannot be blank"
        Else
            If Len(Message) > 4000 Then
                lblError.Text = "Error: Your message is too long (max = 4000)"
            Else
                Dim SqlCommand1 As New SqlClient.SqlCommand("INSERT INTO Posts(Message, ThreadID, Poster) VALUES (@Message, " & ThreadID & ", " & Session.Item("UserID") & "); UPDATE Users SET Posts = Posts + 1 WHERE UserID = " & Session.Item("UserID") & "; UPDATE Threads SET LastPoster = " & Session.Item("UserID") & ", LastPostDate = GETDATE() WHERE ThreadID = " & ThreadID & "; SELECT @@IDENTITY", Session.Item("SqlConnection"))
                SqlCommand1.Parameters.AddWithValue("@Message", Message)
                Session.Item("SqlConnection").Open()
                PostID = SqlCommand1.ExecuteScalar()
                Session.Item("SqlConnection").Close()
                Response.Redirect("Thread.aspx?id=" & ThreadID & "#" & PostID, True)
            End If
        End If
    End Sub

    Protected Sub cmdDeletePosts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdDeletePosts.Click
        If Session.Item("AccessLevel") > 2 Then
            Dim x As Int32
            For x = 0 To Request.Params.Count - 1
                Dim SqlCommand1 As New SqlClient.SqlCommand("DELETE FROM Posts WHERE PostID = " & ThreadID & " AND PostID = " & CInt(Request.Params.Item(x)) & "; DELETE FROM Threads WHERE ThreadID IN (SELECT Threads.ThreadID FROM Threads LEFT OUTER JOIN Posts ON Posts.ThreadID = Threads.ThreadID GROUP BY Threads.ThreadID HAVING COUNT(Posts.PostID) = 0)", Session.Item("SqlConnection"))
                Session.Item("SqlConnection").Open()
                SqlCommand1.ExecuteNonQuery()
                Session.Item("SqlConnection").Close()
            Next
            Feedback.Text = "Selected posts have been deleted"
        End If
    End Sub
End Class
