
Partial Class proxima_forums_Forum
    Inherits System.Web.UI.Page

    Dim ForumID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session.Item("LoggedIn") = False Then
            Session.Item("LogInRedirect") = Request.RawUrl
            Response.Redirect("../LogIn.aspx", True)
        End If
        If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
            Response.Redirect("../LogOut.aspx", True)
        End If

        If Session.Item("AccessLevel") > 1 Then
            cmdDeleteThreads.Visible = True
        Else
            cmdDeleteThreads.Visible = False
        End If

        ForumID = CInt(Request.Item("id"))
        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT ForumName FROM Forums WHERE ForumID = " & ForumID, Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim SqlData1 As SqlClient.SqlDataReader = SqlCommand1.ExecuteReader
        If SqlData1.HasRows Then
            SqlData1.Read()
            ForumName.Text = SqlData1.GetString(0)
            Session.Item("SqlConnection").Close()
        Else
            Session.Item("SqlConnection").Close()
            Response.Redirect("Default.aspx", True)
        End If

        SqlCommand1.CommandText = "SELECT * FROM ThreadsView WHERE ForumID = " & ForumID
        Session.Item("SqlConnection").Open()
        SqlData1 = SqlCommand1.ExecuteReader
        Dim x As Int32 = 1
        While SqlData1.Read()
            tblThreads.Rows.Add(New System.Web.UI.WebControls.TableRow)
            tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
            tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
            tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
            tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
            tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
            If Session.Item("AccessLevel") > 0 Then
                tblThreads.Rows(x).Cells.Add(New System.Web.UI.WebControls.TableCell)
                tblThreads.Rows(x).Cells(5).Text = "<input type=""checkbox"" name=""" & SqlData1.GetInt32(0).ToString & """ value=""" & SqlData1.GetInt32(0).ToString & """>"
                tblThreads.Rows(x).Cells(5).HorizontalAlign = HorizontalAlign.Center
                tblThreads.Rows(x).Cells(5).Style.Add("padding-right", "0px")
                tblThreads.Rows(x).Cells(5).Style.Add("padding-left", "0px")
                tblThreads.Rows(x).Cells(5).Style.Add("padding-bottom", "0px")
                tblThreads.Rows(x).Cells(5).Style.Add("padding-top", "0px")
            Else
                tblThreads.Rows(0).Cells(5).Visible = False
            End If
            tblThreads.Rows(x).Cells(0).Text = "<a href=Thread.aspx?id=" & SqlData1.GetInt32(0).ToString & ">» " & SqlData1.GetString(1) & "</a>"
            tblThreads.Rows(x).Cells(1).Text = SqlData1.GetString(3)
            tblThreads.Rows(x).Cells(2).Text = SqlData1.GetInt32(6).ToString(Common.NumberFormatString) & "/" & SqlData1.GetInt32(2).ToString(Common.NumberFormatString)
            tblThreads.Rows(x).Cells(3).Text = SqlData1.GetString(4)
            tblThreads.Rows(x).Cells(4).Text = SqlData1.GetDateTime(5).ToString(Common.DateTimeFormatString)
            x += 1
        End While
        Session.Item("SqlConnection").Close()

        Feedback.Text = ""
        lblError.Text = ""
    End Sub

    Protected Sub cmdCreateThread_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdCreateThread.Click
        Dim Message As String = Common.Filter(txtMessage.Text)
        Dim ThreadName As String = Common.Filter(txtTitle.Text)
        Dim NewThreadID As Integer
        If Len(Message) = 0 Then
            lblError.Text = "Your message cannot be blank."
        Else
            If Len(Message) > 4000 Then
                lblError.Text = "Your message is too long (max = 4000)."
            Else
                If Len(ThreadName) = 0 Then
                    lblError.Text = "Your thread name cannot be blank."
                Else
                    If Len(ThreadName) > 64 Then
                        lblError.Text = "Your thread name is too long (max = 64)."
                    Else
                        If Session.Item("Threads") > 5 Then
                            lblError.Text = "Error: You cannot make more than 5 threads per turn"
                        Else
                            If Session.Item("Posts") > 15 Then
                                lblError.Text = "Error: You cannot make more than 15 posts per turn"
                            Else
                                Dim SqlCommand1 As New SqlClient.SqlCommand("INSERT INTO Threads(ThreadName, Creator, LastPoster, ForumID) VALUES (@ThreadName, " & Session.Item("UserID") & ", " & Session.Item("UserID") & ", " & ForumID & "); INSERT INTO Posts(Message, ThreadID, Poster) VALUES (@Message, @@IDENTITY, " & Session.Item("UserID") & "); UPDATE Users SET Posts = Posts + 1, Threads = Threads + 1 WHERE UserID = " & Session.Item("UserID") & "; SELECT @@IDENTITY", Session.Item("SqlConnection"))
                                SqlCommand1.Parameters.AddWithValue("@ThreadName", ThreadName)
                                SqlCommand1.Parameters.AddWithValue("@Message", Message)
                                Session.Item("SqlConnection").Open()
                                NewThreadID = SqlCommand1.ExecuteScalar()
                                Session.Item("SqlConnection").Close()
                                Response.Redirect("Thread.aspx?id=" & NewThreadID, True)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub cmdDeleteThreads_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdDeleteThreads.Click
        If Session.Item("AccessLevel") > 1 Then
            Dim ThreadID As String
            Dim x As Int32
            For x = 0 To Request.Params.Count - 1
                ThreadID = Val(Request.Params.Item(x)).ToString
                Dim SqlCommand1 As New SqlClient.SqlCommand("DELETE FROM Threads WHERE ThreadID = " & ThreadID, Session.Item("SqlConnection"))
                Session.Item("SqlConnection").Open()
                SqlCommand1.ExecuteNonQuery()
                Session.Item("SqlConnection").Close()
            Next
            Feedback.Text = "Selected threads have been deleted"
        End If
    End Sub
End Class
