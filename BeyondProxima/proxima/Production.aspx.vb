
Partial Class proxima_Production
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        income.Attributes.Item("value") = 30
        construction.Attributes.Item("value") = 50
        research.Attributes.Item("value") = 20
    End Sub

    Protected Sub savesettings_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles savesettings.Click
        lblError.Text = "Production settings have been saved."
    End Sub
End Class
