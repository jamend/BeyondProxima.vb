<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_SentMessages" Codebehind="SentMessages.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Messages</title>
    <link href="../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <p>Sent Messages</p>
	    <p><a href="Messages.aspx">Received Messages</a></p>
	    <asp:label id="lblError" runat="server" Font-Bold="True" />
	    <asp:panel id="pnlMessages" runat="server" horizontalalign="Center" visible="False" Width="90%">
		    <asp:table id="tblMessages" runat="server" width="100%" GridLines="both">
			    <asp:tablerow visible="False" />
		    </asp:table>
	    </asp:panel>
    </div>
    </form>
</body>
</html>
