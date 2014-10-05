<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.SignUp" Codebehind="SignUp.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sign Up for Beyond Proxima</title>
    <link href="Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Sign Up for Beyond Proxima</p>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="True" />
            <table border="1">
				<tr>
					<td colspan="3"><b>Account Information</b></td>
				</tr>
				<tr>
					<td>*Username</td>
					<td><asp:textbox id="txtUsername" runat="server" MaxLength="16" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblUsername" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>*Password</td>
					<td><asp:textbox id="txtPassword" runat="server" MaxLength="16" TextMode="Password" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblPassword" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>*Confirm Password</td>
					<td><asp:textbox id="txtConfirm" runat="server" MaxLength="16" TextMode="Password" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblConfirm" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td colspan="3"><b>Contact Information</b></td>
				</tr>
				<tr>
					<td>*Email</td>
					<td><asp:textbox id="txtEmail" runat="server" MaxLength="64" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblEmail" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>MSN</td>
					<td><asp:textbox id="txtMSN" runat="server" MaxLength="64" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblMSN" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>AIM</td>
					<td><asp:textbox id="txtAIM" runat="server" MaxLength="32" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblAIM" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>ICQ</td>
					<td><asp:textbox id="txtICQ" runat="server" MaxLength="32" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblICQ" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>Yahoo</td>
					<td><asp:textbox id="txtYahoo" runat="server" MaxLength="64" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblYahoo" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td colspan="3"><b>Profile Information</b></td>
				</tr>
				<tr>
					<td>Avatar URL</td>
					<td><asp:textbox id="txtAvatar" runat="server" MaxLength="256" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblAvatar" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>Home Page</td>
					<td><asp:textbox id="txtHomePage" runat="server" MaxLength="256" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblHomePage" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>Location</td>
					<td><asp:textbox id="txtLocation" runat="server" MaxLength="64" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblLocation" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
				<tr>
					<td>Interests</td>
					<td><asp:textbox id="txtInterests" runat="server" MaxLength="128" /></td>
					<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; padding-top: 0px"><asp:label id="lblInterests" runat="server" Font-Bold="True" ForeColor="Red" /></td>
				</tr>
		    </table>
		    <p>Fields marked with a * are required. An activation code will be sent to your email for verification.</p>
			<p><asp:checkbox id="chkHideContactInfo" runat="server" Text="Hide my contact info from other players" /></p>
			<p><asp:button id="cmdSignUp" runat="server" Text="Submit" /></p>
        </div>
    </form>
</body>
</html>
