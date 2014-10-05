<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_forums_Default" Codebehind="Default.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Beyond Proxima Forums</title>
    <link href="../../Global.css" rel="stylesheet"/>
    <style type="text/css">
        .forum { width: 98%; text-align: left; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid; padding-right: 5px; padding-left: 5px; padding-bottom: 5px; margin: 5px; padding-top: 5px }
        .forumtitle { font-size: 10pt; font-weight: bold }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p style="font-size: 14pt; font-weight: bold;">Beyond Proxima Forums</p>
        <center><asp:Panel ID="pnlForums" runat="server">
        </asp:Panel></center>
    </div>
    </form>
</body>
</html>