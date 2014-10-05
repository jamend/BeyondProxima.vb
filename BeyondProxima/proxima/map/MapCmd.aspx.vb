'Get the systems and fleets in the player's range from the db and output them as XML
Imports System.Xml

Partial Class MapCmd
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()
        Response.ContentType = "application/xml"

        'If Session.Item("LoggedIn") = False Then
        'Response.End()
        'End If
        'If Common.SessionID(Session.Item("UserID"), Application.Item("SqlConnectionStr")) <> Session.Item("SessionID") Then
        'Session.Abandon()
        'Response.End()
        'End If

        Session.Item("ShipSpeed") = 1

        Dim Command As String = Request.Item("c")

        Response.Write("<result>")

        Select Case Command
            Case "init" 'the map is being loaded
                Response.Write("<ship speed=""" & Session.Item("ShipSpeed") & """ /><map>")
                Dim XmlWriter As New XmlTextWriter(Response.OutputStream, System.Text.Encoding.UTF8)
                Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT SystemID AS ID, X, Y, SystemName AS N, StarType AS T FROM Systems AS S FOR XML AUTO", Session.Item("SqlConnection"))
                Session.Item("SqlConnection").Open()
                Dim XmlReader1 As XmlReader = SqlCommand1.ExecuteXmlReader
                XmlReader1.Read()
                Do While XmlReader1.ReadState <> ReadState.EndOfFile
                    XmlWriter.WriteNode(XmlReader1, False)
                Loop
                XmlWriter.Flush()
                Session.Item("SqlConnection").Close()

                SqlCommand1.CommandText = "SELECT FleetID AS ID, System1 AS S1, System2 AS S2, X, Y, Steps AS S, Step AS T FROM Fleets AS F FOR XML AUTO"
                Session.Item("SqlConnection").Open()
                XmlReader1 = SqlCommand1.ExecuteXmlReader
                XmlReader1.Read()
                Do While XmlReader1.ReadState <> ReadState.EndOfFile
                    XmlWriter.WriteNode(XmlReader1, False)
                Loop
                XmlWriter.Flush()
                Session.Item("SqlConnection").Close()

                Response.Write("</map>")
            Case "sysplanets"
                Dim SystemID As Integer
                If Integer.TryParse(Request.Item("s"), SystemID) Then

                    Dim XmlWriter As New XmlTextWriter(Response.OutputStream, system.Text.Encoding.UTF8)
                    Dim SqlCommand1 As New SqlClient.SqlCommand("SELECT PlanetID AS ID, EnvironmentID AS E, Size AS S, Occupied AS O FROM Planets AS P WHERE SystemID = @SystemID FOR XML AUTO", Session.Item("SqlConnection"))
                    SqlCommand1.Parameters.AddWithValue("@SystemID", SystemID)
                    Session.Item("SqlConnection").Open()
                    Dim XmlReader1 As XmlReader = SqlCommand1.ExecuteXmlReader
                    XmlReader1.Read()
                    Do While XmlReader1.ReadState <> ReadState.EndOfFile
                        XmlWriter.WriteNode(XmlReader1, False)
                    Loop
                    XmlWriter.Flush()
                    Response.Write(XmlReader1.ReadOuterXml)
                    Session.Item("SqlConnection").Close()
                End If
            Case "setcourse"
                Dim FleetID As Integer
                Dim Destination As Integer
                If Integer.TryParse(Request.Item("f"), FleetID) And Integer.TryParse(Request.Item("d"), Destination) Then
                    Dim x1, x2, y1, y2, dist, steps, nx, ny As Double

                    Session.Item("SqlConnection").Open()

                    Dim sqlFleet As New SqlClient.SqlCommand("SELECT X, Y FROM Fleets WHERE FleetID = @FleetID", Session.Item("SqlConnection"))
                    sqlFleet.Parameters.AddWithValue("@FleetID", FleetID)
                    Dim fleet As SqlClient.SqlDataReader = sqlFleet.ExecuteReader()
                    If fleet.Read() Then
                        x1 = fleet.GetDouble(0)
                        y1 = fleet.GetDouble(1)
                    Else
                        Response.Write(-1)
                        Session.Item("SqlConnection").Close()
                        Exit Select
                    End If
                    fleet.Close()

                    Dim sqlSystem As New SqlClient.SqlCommand("SELECT X, Y FROM Systems WHERE SystemID = @Destination", Session.Item("SqlConnection"))
                    sqlSystem.Parameters.AddWithValue("@Destination", Destination)
                    Dim system As SqlClient.SqlDataReader = sqlSystem.ExecuteReader()
                    If system.Read() Then
                        x2 = system.GetDouble(0)
                        y2 = system.GetDouble(1)
                    Else
                        Response.Write(-1)
                        Session.Item("SqlConnection").Close()
                        Exit Select
                    End If
                    system.Close()

                    nx = x1 - x2
                    ny = y1 - y2
                    dist = Math.Sqrt(nx ^ 2 + ny ^ 2)
                    steps = dist / Session.Item("ShipSpeed")
                    nx = (1 / steps) * nx
                    ny = (1 / steps) * ny

                    'put the new info into the database
                    Dim SqlCommand1 As New SqlClient.SqlCommand("UPDATE Fleets SET X2 = @NX, Y2 = @NY, System2 = @Destination, Steps = @Steps, Step = 0 WHERE FleetID = @FleetID", Session.Item("SqlConnection"))
                    SqlCommand1.Parameters.AddWithValue("@FleetID", FleetID)
                    SqlCommand1.Parameters.AddWithValue("@Destination", Destination)
                    SqlCommand1.Parameters.AddWithValue("@NX", nx)
                    SqlCommand1.Parameters.AddWithValue("@NY", ny)
                    SqlCommand1.Parameters.AddWithValue("@Steps", steps)
                    Response.Write(SqlCommand1.ExecuteNonQuery())
                    Session.Item("SqlConnection").Close()
                End If
            Case "abortcourse"
                Dim FleetID As Integer
                If Integer.TryParse(Request.Item("f"), FleetID) Then
                    Session.Item("SqlConnection").Open()
                    Dim SqlCommand1 As New SqlClient.SqlCommand("UPDATE Fleets SET System2 = null, Steps = 0, Step = 0 WHERE FleetID = @FleetID", Session.Item("SqlConnection"))
                    SqlCommand1.Parameters.AddWithValue("@FleetID", FleetID)
                    Response.Write(SqlCommand1.ExecuteNonQuery())
                    Session.Item("SqlConnection").Close()
                End If
        End Select

        Response.Write("</result>")
        Response.End()
    End Sub
End Class