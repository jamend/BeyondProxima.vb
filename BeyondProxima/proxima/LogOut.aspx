<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_LogOut" Codebehind="LogOut.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Log Out</title>
    <link href="../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p><asp:label id="lblLoggedOut" runat="server" Font-Bold="True" /></p>
	    <p><a href="../Default.aspx" target="_top"> Main Page</a></p>
	    <p><a href="../LogIn.aspx" target="_top"> Log In</a></p>
    </div>
    </form>    
</body>
</html>