<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_forums_Forum" Codebehind="Forum.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Forum Index</title>
    <link href="../../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <p><asp:Label ID="ForumName" runat="server" CssClass="pagetitle"></asp:Label></p>
        <asp:Table ID="tblThreads" runat="server" Width="98%">
            <asp:TableRow runat="server" Font-Bold="True">
                <asp:TableCell runat="server">Thread</asp:TableCell>
                <asp:TableCell runat="server">Creator</asp:TableCell>
                <asp:TableCell runat="server">Replies/Views</asp:TableCell>
                <asp:TableCell runat="server">Last Poster</asp:TableCell>
                <asp:TableCell runat="server">Date</asp:TableCell>
                <asp:TableCell runat="server">Delete</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <center>
            <p><asp:Literal ID="Feedback" runat="server"></asp:Literal></p>
            <p><asp:button id="cmdDeleteThreads" runat="server" Text="Delete Selected Threads"></asp:button></p>
            <p>Create new thread</p>
            <asp:label id="lblError" runat="server" forecolor="Red" Font-Bold="True"/>
	        <table border="1">
		        <tr>
			        <td><b>Thread Title</b></td>
			        <td style="width: 344px">
				        <asp:textbox id="txtTitle" runat="server" MaxLength="64" Width="337px" /></tr>
		        <tr>
			        <td><b>Message&nbsp;</b></td>
			        <td style="width: 344px"><asp:textbox id="txtMessage" runat="server" TextMode="MultiLine" Height="184"
					        MaxLength="4000" Width="337" /></td>
		        </tr>
	        </table>
	        <p><asp:button id="cmdCreateThread" runat="server" Text="Create Thread" /></p>
        </center>
    </form>
</body>
</html>
