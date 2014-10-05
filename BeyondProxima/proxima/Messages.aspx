<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_Messages" Codebehind="Messages.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Messages</title>
    <link href="../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server"><center>
        <p>Messages</p>
	    <asp:label id="lblError" runat="server" forecolor="Red" Font-Bold="True"/>
	    <table border="1">
		    <tr>
			    <td><b>To</b></td>
			    <td style="width: 344px">
                    Username
				    <asp:textbox id="txtUsername" runat="server" MaxLength="32" Width="138px" />&nbsp;or
                    User ID
				    <asp:textbox id="txtUserID" runat="server" MaxLength="8" Width="56px" /></td>
		    </tr>
		    <tr>
			    <td><b>Message&nbsp;</b></td>
			    <td style="width: 344px"><asp:textbox id="txtMessage" runat="server" TextMode="MultiLine" Height="184"
					    MaxLength="4000" Width="337" /></td>
		    </tr>
	    </table>
	    <p><asp:button id="cmdSendMessage" runat="server" Text="Send Message" /></p>
	    <p><a href="SentMessages.aspx">Sent Messages</a></p>
	    <asp:label id="lblHaveMessages" runat="server" Font-Bold="True"/>
	    <asp:panel id="pnlMessages" runat="server" horizontalalign="Center" visible="False" Width="90%">
		    <asp:table id="tblMessages" runat="server" width="100%" GridLines="both">
			    <asp:tablerow visible="False" />
		    </asp:table>
		    <p><asp:button id="cmdDeleteSelected" runat="server" Text="Delete Selected Messages" /></p>
	    </asp:panel>
    </center></form>
</body>
</html>
