<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima._Default" Codebehind="Default.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Beyond Proxima Main Page</title>
    <link href="Global.css" rel="stylesheet"/>
</head>
<body>
    <div>
        <p><b>Welcome to Beyond Proxima!</b></p>
        <p><a href="LogIn.aspx">Log In</a></p>
        <p><a href="SignUp.aspx">Sign Up</a></p>
        <p><a href="About.aspx">About Proxima</a></p>
        <p><asp:Label ID="lblStatus" runat="server" /></p>
    </div>
</body>
</html>
