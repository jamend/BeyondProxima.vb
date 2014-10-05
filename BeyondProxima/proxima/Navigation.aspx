<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_Navigation" Codebehind="Navigation.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Navigation</title>
    <base target="main"/>
    <link href="../Global.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p><a href="Overview.aspx">Overview</a></p>
        <p><a href="map/">Map</a></p>
        <p><a href="Ships.aspx">Ships</a></p>
        <p><a href="Production.aspx">Production</a></p>
        <p><a href="Messages.aspx">Messages</a></p>
        <p><a href="forums/">Forums</a></p>
        <p><a href="UserSettings.aspx">Settings</a></p>
        <p><a href="LogOut.aspx" target="_top">Log Out</a></p>
        <br />
        <br />
        <p><a href="Tick.aspx" style="font-size: 14pt; font-weight: bold">Tick</a></p>
    </div>
    </form>
</body>
</html>
