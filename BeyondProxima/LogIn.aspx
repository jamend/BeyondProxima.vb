<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.LogIn" Codebehind="LogIn.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Log in to Beyond Proxima</title>
    <link href="Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p>Log in to Beyond Proxima</p>
        <p>
            Log in as <strong>test/test</strong> if you just want to look around.</p>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="True"/>
            <table border="1">
                <tr>
                    <td>
        Username</td>
                    <td style="width: 159px">
                        <asp:TextBox ID="txtUsername" runat="server" Width="159px" /></td>
                </tr>
                <tr>
                    <td style="height: 26px">
            Password</td>
                    <td style="width: 159px; height: 26px">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="159px" /></td>
                </tr>
            </table>
        <p>
            <asp:Label ID="lblStatus" runat="server" /></p>
        <p><asp:CheckBox ID="chkRemember" runat="server" Text="Log me in automatically next time"/></p>
        <p><asp:Button ID="cmdLogIn" runat="server" Text="Log In"/></p>
    </div>
    </form>
</body>
</html>
