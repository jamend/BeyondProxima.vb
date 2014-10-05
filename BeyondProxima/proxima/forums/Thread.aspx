<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_forums_Thread" Codebehind="Thread.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Thread</title>
    <link href="../../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <p><asp:Label ID="ThreadName" runat="server" CssClass="pagetitle"></asp:Label></p>
        <asp:Table ID="tblPosts" runat="server" Width="98%">
        </asp:Table>
        <center>
            <p><asp:Literal ID="Feedback" runat="server"></asp:Literal></p>
            <p><asp:button id="cmdDeletePosts" runat="server" Text="Delete Selected Posts"></asp:button></p>
            <p>Post a reply</p>
            <asp:label id="lblError" runat="server" forecolor="Red" Font-Bold="True"/>
	        <table border="1">
		        <tr>
			        <td><b>Message&nbsp;</b></td>
			        <td style="width: 344px"><asp:textbox id="txtMessage" runat="server" TextMode="MultiLine" Height="184"
					        MaxLength="4000" Width="337" /></td>
		        </tr>
	        </table>
	        <p><asp:button id="cmdPost" runat="server" Text="Submit Post" /></p>
        </center>
    </form>
</body>
</html>