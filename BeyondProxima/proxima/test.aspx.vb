
Imports System.Xml

Partial Class proxima_test
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()
        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")

        Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT SystemID AS ID, X, Y, SystemName AS N, StarType AS C FROM Systems AS S", Session.Item("SqlConnection"))
        Session.Item("SqlConnection").Open()
        Dim DataSet1 As New DataSet
        Dim SqlData1 As New SqlClient.SqlDataAdapter(SqlCommand1)
        SqlData1.Fill(DataSet1)

        Dim XmlDataDoc1 As New XmlDataDocument(DataSet1)
        Dim XmlWriter As New XmlTextWriter(Response.OutputStream, System.Text.Encoding.UTF8)
        XmlDataDoc1.WriteTo(XmlWriter)

        XmlWriter.Flush()
        Session.Item("SqlConnection").Close()
        Response.End()
    End Sub
End Class
