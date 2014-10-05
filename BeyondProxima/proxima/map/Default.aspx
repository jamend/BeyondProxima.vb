<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_map_Default" Codebehind="Default.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
    <title>Map</title>
    <link href="windows.css" rel="stylesheet"/>
    <style type="text/css">
        v\:* {
            behavior: url(#default#VML);
            position: absolute;
            z-index: 0;
            top: 0px;
            left: 0px;
        }
        
        html {
            height: 100%;
            overflow: hidden;
            -moz-user-select: none;
            -khtml-user-select: none;
            user-select: none;
        }
        
        body {
            height: 100%;
            margin: 0px;
            background-image: url('img/background.gif');
            background-repeat: repeat;
            background-attachment: fixed;
        }

        .fleet {
            z-index: 3;
            position: absolute;
        }
        
        .system {
            z-index: 2;
            position: absolute;
        }
        
        #svgDoc {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            z-index: 0;
        }
        
        #map {
            height: 100%;
        }
        
        #mapBlank {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 1;
            top: 0px;
            left: -1px;
        }
        
        .planet {
            border-bottom: solid 3px white;
            padding-bottom: 5px;
        }
    </style>
    <!-- <script src="ajax.js" type="text/javascript"></script> -->
    <!-- <script src="drawing.js" type="text/javascript"></script> -->
    <script src="windows.js" type="text/javascript"></script>
    <script src="interface.js" type="text/javascript"></script>
</head>
<body>
    <div id="systemDetailsWindow" class="window" style="left: 130px; top: 136px; width: 480px; z-index: 10">
        <div class="titleBar">
            <span class="titleBarText" />
            <img class="titleBarButtons" alt="" src="close.gif" usemap="#sampleMap1" width="26" height="26" />
            <map id="sampleMap1" name="sampleMap1">
                <area shape="rect" coords="2,2,27,27" href="#" alt="" title="Close" onclick="this.parentWindow.close();return false;" />
            </map>
        </div>
        <div class="clientArea" style="height: 200px;"></div>
    </div>
    <div id="fleetDetailsWindow" class="window" style="left: 157px; top: 116px; width: 480px; z-index: 10">
        <div class="titleBar">
            <span class="titleBarText" />
            <img class="titleBarButtons" alt="" src="close.gif" usemap="#sampleMap2" width="26" height="26" />
            <map id="sampleMap2" name="sampleMap2">
                <area shape="rect" coords="2,2,27,27" href="#" alt="" title="Close" onclick="this.parentWindow.close();return false;" />
            </map>
        </div>
        <div class="clientArea" style="height: 200px;" />
    </div>
    <div id="map" style="z-index: 10000;" />
</body>
</html>
