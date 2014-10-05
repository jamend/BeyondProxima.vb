<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_UserSettings" Codebehind="UserSettings.aspx.vb" %>

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
        <p>Account Settings</p>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="True" />
        <table border="1">
            <tr>
                <td>Email</td>
                <td><asp:TextBox ID="txtEmail" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblEmail" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>MSN</td>
                <td><asp:TextBox ID="txtMSN" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblMSN" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>AIM</td>
                <td><asp:TextBox ID="txtAIM" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblAIM" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Yahoo</td>
                <td><asp:TextBox ID="txtYahoo" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblYahoo" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>ICQ</td>
                <td><asp:TextBox ID="txtICQ" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblICQ" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Location</td>
                <td><asp:TextBox ID="txtLocation" runat="server" MaxLength="64" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblLocation" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Interests</td>
                <td><asp:TextBox ID="txtInterests" runat="server" MaxLength="128" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblInterests" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Home Page</td>
                <td><asp:TextBox ID="txtHomePage" runat="server" MaxLength="256" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblHomePage" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Avatar</td>
                <td><asp:TextBox ID="txtAvatar" runat="server" MaxLength="256" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblAvatar" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
        </table>
        <p><asp:CheckBox ID="chkHideContactInfo" runat="server" Text="Hide my contact info from other users" /></p>
        <p><asp:Button id="cmdSaveSettings" runat="server" Text="Save Settings"/></p>
        <p><asp:HyperLink ID="aProfile" runat="server" Text="View your profile" /></p>
        <p>Change your password</p>
        <asp:Label ID="lblErrorB" runat="server" ForeColor="Red" Font-Bold="True" />
        <table border="1">
            <tr>
                <td>Old Password</td>
                <td><asp:TextBox ID="txtOldPassword" runat="server" MaxLength="256" TextMode="Password" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblOldPassword" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>New Password</td>
                <td><asp:TextBox ID="txtPassword" runat="server" MaxLength="256" TextMode="Password" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblPassword" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
            <tr>
                <td>Confirm New Password</td>
                <td><asp:TextBox ID="txtConfirm" runat="server" MaxLength="256" TextMode="Password" /></td>
                <td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label ID="lblConfirm" runat="server" ForeColor="Red" Font-Bold="True" /></td>
            </tr>
        </table>
        <p><asp:Button id="cmdSavePassword" runat="server" Text="Save Password"/></p>
    </center>
    </div>
    </form>
</body>
</html>
