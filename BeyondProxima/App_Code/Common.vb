Imports System.Data
Public Class Common

    Public Const DateTimeFormatString As String = "MMMM d, h:mm tt"
    Public Const NumberFormatString As String = "###,###,###,###,##0"

    Public Shared Function Filter(ByVal str As String) As String
        Dim Buffer As String = str
        Buffer = Trim(Buffer)
        Buffer = Replace(Buffer, "  ", "&nbsp;&nbsp;")
        Buffer = Replace(Buffer, vbTab, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Buffer = Replace(Buffer, "<", "&lt;")
        Buffer = Replace(Buffer, ">", "&gt;")
        Buffer = Replace(Buffer, vbCrLf, "<br>")
        Filter = Buffer
    End Function

    Public Shared Function RevFilter(ByVal str As String) As String
        Dim Buffer As String = str
        Buffer = Trim(Buffer)
        Buffer = Replace(Buffer, "&nbsp;&nbsp;", "  ")
        Buffer = Replace(Buffer, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", vbTab)
        Buffer = Replace(Buffer, "&lt;", "<")
        Buffer = Replace(Buffer, "&gt;", ">")
        Buffer = Replace(Buffer, "<br>", vbCrLf)
        RevFilter = Buffer
    End Function

    Public Shared Sub LoggedIn(ByVal UserID As Int16, ByVal Value As Boolean, ByVal sqlConnectionStr As String)
        Dim SqlConnection1 As New SqlClient.SqlConnection(sqlConnectionStr)
        Dim SqlCommand1 As New SqlClient.SqlCommand("", SqlConnection1)
        Select Case Value
            Case True
                SqlCommand1.CommandText = "UPDATE Users SET LoggedIn = 1 WHERE UserID = " & UserID
            Case False
                SqlCommand1.CommandText = "UPDATE Users SET LoggedIn = 0 WHERE UserID = " & UserID
        End Select
        SqlConnection1.Open()
        SqlCommand1.ExecuteNonQuery()
        SqlConnection1.Close()
    End Sub

    Public Shared Function SessionID(ByVal UserID As Int16, ByVal sqlConnectionStr As String) As Int64
        Dim SqlConnection1 As New SqlClient.SqlConnection(sqlConnectionStr)
        Dim SqlCommand1 As New SqlClient.SqlCommand("", SqlConnection1)
        SqlCommand1.CommandText = "SELECT SessionID FROM Users WHERE UserID = " & UserID
        SqlConnection1.Open()
        SessionID = SqlCommand1.ExecuteScalar
        SqlConnection1.Close()
    End Function

End Class
