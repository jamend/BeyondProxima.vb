<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_Profile" Codebehind="Profile.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Profile</title>
	<link href="../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="True" />
        <asp:Panel ID="pnlProfile" runat="server">
            <p>Profile of
            <asp:Label ID="lblUsername" runat="server" />
            (User ID
            <asp:Label ID="lblUserID" runat="server" />)
            </p>
            <table border="1">
                <tr>
                    <td>Planets</td>
                    <td><asp:Label ID="lblPlanets" runat="server" /></td>
                </tr>
                <tr>
                    <td>Ships</td>
                    <td><asp:Label ID="lblShips" runat="server" /></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><asp:Label ID="lblEmail" runat="server" /></td>
                </tr>
                <tr>
                    <td>MSN</td>
                    <td><asp:Label ID="lblMSN" runat="server" /></td>
                </tr>
                <tr>
                    <td>AIM</td>
                    <td><asp:Label ID="lblAIM" runat="server" /></td>
                </tr>
                <tr>
                    <td>Yahoo</td>
                    <td><asp:Label ID="lblYahoo" runat="server" /></td>
                </tr>
                <tr>
                    <td>ICQ</td>
                    <td><asp:Label ID="lblICQ" runat="server" /></td>
                </tr>
                <tr>
                    <td>Location</td>
                    <td><asp:Label ID="lblLocation" runat="server" /></td>
                </tr>
                <tr>
                    <td>Interests</td>
                    <td><asp:Label ID="lblInterests" runat="server" /></td>
                </tr>
                <tr>
                    <td>Home Page</td>
                    <td><asp:HyperLink ID="aHomePage" runat="server" /></td>
                </tr>
            </table>
            <p><asp:HyperLink ID="aSendMessage" runat="server" /></p>
            <asp:Panel ID="pnlAvatar" runat="server">
                <p>Avatar:</p>
                <p><asp:Image ID="imgAvatar" runat="server" /></p>
            </asp:Panel>
        </asp:Panel>
        </center>
        </div>
    </form>
</body>
</html>
