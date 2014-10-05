<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_Ships" Codebehind="Ships.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ships</title>
    <style type="text/css">
        html
        {
            height: 100%;
            overflow: hidden;
        }
        BODY
        {
        	height: 100%;
            font-size: 7pt;
            color: white;
            font-family: Verdana, Helvetica, sans-serif;
            background: black;
            margin: 0px;
        }
        A:link, A:visited, A:active
        {
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
        A:hover
        {
            color: #001EB8;
            text-decoration: none;
            font-weight: bold;
        }
        TABLE
        {
            font-size: 7pt;
            vertical-align: middle;
            color: white;
            font-family: Verdana;
            background-color: #232333;
        }
        TEXTAREA
        {
            border-right: #001EB8 1px solid;
            border-top: #001EB8 1px solid;
            border-left: #001EB8 1px solid;
            border-bottom: #001EB8 1px solid;
            font-size: 7pt;
            color: white;
            font-family: Verdana;
            background-color: #232333;
        }
        .textbox
        {
            border-right: #001EB8 1px solid;
            border-top: #001EB8 1px solid;
            border-left: #001EB8 1px solid;
            border-bottom: #001EB8 1px solid;
            font-size: 7pt;
            color: white;
            font-family: Verdana;
            background-color: #232333;
        }
        .slider
        {
            border-right: #001eb8 1px solid;
            padding-right: 1px;
            border-top: #001eb8 1px solid;
            padding-left: 1px;
            padding-bottom: 1px;
            overflow: hidden;
            border-left: #001eb8 1px solid;
            width: 208px;
            padding-top: 1px;
            border-bottom: #001eb8 1px solid;
            white-space: nowrap;
        }
        .bar1
        {
            background-color: #001eb8;
            border-right-width: 1px;
            border-right-color: #232333;
        }
        .bar2
        {
            cursor: w-resize;
            background-color: silver;
        }
        .bar2total
        {
            background-color: gray;
        }
        .sizer
        {
            background-color: Transparent;
            padding-right: 0px;
            padding-left: 0px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        TD
        {
            padding-right: 4px;
            padding-left: 4px;
            padding-top: 3px;
            padding-bottom: 3px;
        }
        .edges
        {
            padding-right: 0px;
            padding-left: 0px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        .topleft
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .top
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .topright
        {
            border-left: #001eb8 1px solid;
            border-right: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .left
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .inner
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .right
        {
            border-left: #001eb8 1px solid;
            border-right: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
        }
        .bottomleft
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
            border-bottom: #001eb8 1px solid;
        }
        .bottom
        {
            border-left: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
            border-bottom: #001eb8 1px solid;
        }
        .bottomright
        {
            border-left: #001eb8 1px solid;
            border-right: #001eb8 1px solid;
            border-top: #001eb8 1px solid;
            border-bottom: #001eb8 1px solid;
        }
        .ship
        {
            border-right: white 2px solid;
            border-top: white 2px solid;
            border-left: white 2px solid;
            border-bottom: white 2px solid;
            margin: 10px;
        }
        body
        {
            -moz-user-select: none;
        }
    </style>
	<script type="text/javascript">
        var mousedown;
	    var startx;
	    var starty;
    	
        window.onload = init;
        
        function init() {
            document.onmousedown = function () { return false; };
    	
	        if (document.layers) {
		        document.captureEvents(Event.MOUSEDOWN);
		        document.onmousedown = function (e) {
			        return false;
		        };
	        }
    	    
	        document.body.onmousedown = body_onmousedown;
	        document.body.onmouseup = body_onmouseup;
	        document.body.onmousemove = body_onmousemove;
        }
    	
	    function body_onmousedown(e) {
	        if (!e) e = window.event;
		    for (x = 0; x < document.images.length; x++) {
			    document.images.item(x).style.borderBottomColor = "white";
			    document.images.item(x).style.borderLeftColor = "white";
			    document.images.item(x).style.borderTopColor = "white";
			    document.images.item(x).style.borderRightColor = "white";
		    }
		    startx = e.clientX;
		    starty = e.clientY;
		    mousedown = true;
	    }
	
	    function body_onmouseup(e) {
	        if (!e) e = window.event;
		    mousedown = false;
		    for (x = 0; x < document.images.length; x++) {
			    if(document.images.item(x).id != "pagecover" && document.images.item(x).id != "selectedbox"){
				    if(e.clientX < startx){
					    if(getx(document.images.item(x)) > e.clientX && getx(document.images.item(x)) < startx){
						    if(e.clientY < starty){
							    if(gety(document.images.item(x)) > e.clientY && gety(document.images.item(x)) < starty){
								    document.images.item(x).style.borderBottomColor = "blue";
								    document.images.item(x).style.borderLeftColor = "blue";
								    document.images.item(x).style.borderTopColor = "blue";
								    document.images.item(x).style.borderRightColor = "blue";
							    }else{
								    document.images.item(x).style.borderBottomColor = "white";
								    document.images.item(x).style.borderLeftColor = "white";
								    document.images.item(x).style.borderTopColor = "white";
								    document.images.item(x).style.borderRightColor = "white";
							    }
						    }else{
							    if(gety(document.images.item(x)) < e.clientY && gety(document.images.item(x)) > starty){
								    document.images.item(x).style.borderBottomColor = "blue";
								    document.images.item(x).style.borderLeftColor = "blue";
								    document.images.item(x).style.borderTopColor = "blue";
								    document.images.item(x).style.borderRightColor = "blue";
							    }else{
								    document.images.item(x).style.borderBottomColor = "white";
								    document.images.item(x).style.borderLeftColor = "white";
								    document.images.item(x).style.borderTopColor = "white";
								    document.images.item(x).style.borderRightColor = "white";
							    }
						    }
					    }else{
						    document.images.item(x).style.borderBottomColor = "white";
						    document.images.item(x).style.borderLeftColor = "white";
						    document.images.item(x).style.borderTopColor = "white";
						    document.images.item(x).style.borderRightColor = "white";
					    }
				    }else{
					    if(getx(document.images.item(x)) < e.clientX && getx(document.images.item(x)) > startx){
						    if(e.clientY < starty){
							    if(gety(document.images.item(x)) > e.clientY && gety(document.images.item(x)) < starty){
								    document.images.item(x).style.borderBottomColor = "blue";
								    document.images.item(x).style.borderLeftColor = "blue";
								    document.images.item(x).style.borderTopColor = "blue";
								    document.images.item(x).style.borderRightColor = "blue";
							    }else{
								    document.images.item(x).style.borderBottomColor = "white";
								    document.images.item(x).style.borderLeftColor = "white";
								    document.images.item(x).style.borderTopColor = "white";
								    document.images.item(x).style.borderRightColor = "white";
							    }
						    }else{
							    if(gety(document.images.item(x)) < e.clientY && gety(document.images.item(x)) > starty){
								    document.images.item(x).style.borderBottomColor = "blue";
								    document.images.item(x).style.borderLeftColor = "blue";
								    document.images.item(x).style.borderTopColor = "blue";
								    document.images.item(x).style.borderRightColor = "blue";
							    }else{
								    document.images.item(x).style.borderBottomColor = "white";
								    document.images.item(x).style.borderLeftColor = "white";
								    document.images.item(x).style.borderTopColor = "white";
								    document.images.item(x).style.borderRightColor = "white";
							    }
						    }
					    }else{
						    document.images.item(x).style.borderBottomColor = "white";
						    document.images.item(x).style.borderLeftColor = "white";
						    document.images.item(x).style.borderTopColor = "white";
						    document.images.item(x).style.borderRightColor = "white";
					    }
				    }
			    }
		    }
		    document.getElementById("selectedbox").width = 1;
		    document.getElementById("selectedbox").height = 1;
		    document.getElementById("boundingbox").style.visibility = "hidden";
	    }
	    function cancelEvent(e) {
		    e.returnValue = false;
	    } 
	    function getx(element) {
		    var x = 0;
		    while (element.offsetParent){
			    x += element.offsetLeft;
    			
			    element = element.offsetParent;
		    }
		    return x + 16;
	    }
	    function gety(element) {
		    var y = 0;
		    while (element.offsetParent){
			    y += element.offsetTop;
			    element = element.offsetParent;
		    }
		    return y + 16;
	    }
	    function body_onmousemove(e) {
	        if (!e) e = window.event;
		    if(mousedown == true){
			    for (x = 0; x < document.images.length; x++) {
				    if(document.images.item(x).id != "pagecover" && document.images.item(x).id != "selectedbox"){
					    if(e.clientX < startx){
						    if(getx(document.images.item(x)) > e.clientX && getx(document.images.item(x)) < startx){
							    if(e.clientY < starty){
								    if(gety(document.images.item(x)) > e.clientY && gety(document.images.item(x)) < starty){
									    document.images.item(x).style.borderBottomColor = "red";
									    document.images.item(x).style.borderLeftColor = "red";
									    document.images.item(x).style.borderTopColor = "red";
									    document.images.item(x).style.borderRightColor = "red";
								    }else{
									    document.images.item(x).style.borderBottomColor = "white";
									    document.images.item(x).style.borderLeftColor = "white";
									    document.images.item(x).style.borderTopColor = "white";
									    document.images.item(x).style.borderRightColor = "white";
								    }
							    }else{
								    if(gety(document.images.item(x)) < e.clientY && gety(document.images.item(x)) > starty){
									    document.images.item(x).style.borderBottomColor = "red";
									    document.images.item(x).style.borderLeftColor = "red";
									    document.images.item(x).style.borderTopColor = "red";
									    document.images.item(x).style.borderRightColor = "red";
								    }else{
									    document.images.item(x).style.borderBottomColor = "white";
									    document.images.item(x).style.borderLeftColor = "white";
									    document.images.item(x).style.borderTopColor = "white";
									    document.images.item(x).style.borderRightColor = "white";
								    }
							    }
						    }else{
							    document.images.item(x).style.borderBottomColor = "white";
							    document.images.item(x).style.borderLeftColor = "white";
							    document.images.item(x).style.borderTopColor = "white";
							    document.images.item(x).style.borderRightColor = "white";
						    }
					    }else{
						    if(getx(document.images.item(x)) < e.clientX && getx(document.images.item(x)) > startx){
							    if(e.clientY < starty){
								    if(gety(document.images.item(x)) > e.clientY && gety(document.images.item(x)) < starty){
									    document.images.item(x).style.borderBottomColor = "red";
									    document.images.item(x).style.borderLeftColor = "red";
									    document.images.item(x).style.borderTopColor = "red";
									    document.images.item(x).style.borderRightColor = "red";
								    }else{
									    document.images.item(x).style.borderBottomColor = "white";
									    document.images.item(x).style.borderLeftColor = "white";
									    document.images.item(x).style.borderTopColor = "white";
									    document.images.item(x).style.borderRightColor = "white";
								    }
							    }else{
								    if(gety(document.images.item(x)) < e.clientY && gety(document.images.item(x)) > starty){
									    document.images.item(x).style.borderBottomColor = "red";
									    document.images.item(x).style.borderLeftColor = "red";
									    document.images.item(x).style.borderTopColor = "red";
									    document.images.item(x).style.borderRightColor = "red";
								    }else{
									    document.images.item(x).style.borderBottomColor = "white";
									    document.images.item(x).style.borderLeftColor = "white";
									    document.images.item(x).style.borderTopColor = "white";
									    document.images.item(x).style.borderRightColor = "white";
								    }
							    }
						    }else{
							    document.images.item(x).style.borderBottomColor = "white";
							    document.images.item(x).style.borderLeftColor = "white";
							    document.images.item(x).style.borderTopColor = "white";
							    document.images.item(x).style.borderRightColor = "white";
						    }
					    }
				    }
			    }
			    document.getElementById("boundingbox").style.visibility = "visible";
			    if(e.clientX < startx){
				    document.getElementById("boundingbox").style.left = e.clientX + "px";
				    document.getElementById("selectedbox").width = startx - e.clientX;
			    }else{
				    if(e.clientX == startx){ ;
					    document.getElementById("boundingbox").style.left = startx + "px";
					    document.getElementById("selectedbox").width = 1;
				    }else{
					    if(e.clientX > document.body.clientWidth){
						    document.getElementById("boundingbox").style.left = startx + "px";
						    document.getElementById("selectedbox").width = document.body.clientWidth - startx - 4;
					    }else{
						    document.getElementById("boundingbox").style.left = startx + "px";
						    document.getElementById("selectedbox").width = e.clientX - startx;
					    }
				    }
			    }
			    if(e.clientY < starty){
				    document.getElementById("boundingbox").style.top = e.clientY + "px";
				    document.getElementById("selectedbox").height = starty - e.clientY;
			    }else{
				    if(e.clientY == starty){
					    document.getElementById("boundingbox").style.top = starty + "px";
					    document.getElementById("selectedbox").height = 1;
				    }else{
					    if(e.clientY > document.body.clientHeight){
						    document.getElementById("boundingbox").style.top = starty + "px";
						    document.getElementById("selectedbox").height = document.body.clientHeight - starty - 4;
					    }else{
						    document.getElementById("boundingbox").style.top = starty + "px";
						    document.getElementById("selectedbox").height = e.clientY - starty;
					    }
				    }
			    }
		    }
	    }
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <p align="center">
        Ships</p>
    <p>
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <img class="ship" src="map/img/fleet.png">
        <br />
    </p>
    <div id="boundingbox" style="border-right: blue 2px solid; padding-right: 0px; border-top: blue 2px solid;
        padding-left: 0px; font-size: 1px; z-index: 2; left: 0px; background-image: url(../images/alpha.gif);
        visibility: hidden; padding-bottom: 0px; margin: 0px; overflow: visible; border-left: blue 2px solid;
        padding-top: 0px; border-bottom: blue 2px solid; position: absolute; top: 0px">
        <img id="selectedbox" src="../images/alpha.gif">
    </div>
    <table style="padding-right: 0px; padding-left: 0px; z-index: 1; padding-bottom: 0px;
        margin: 0px; overflow: visible; padding-top: 0px; position: absolute; top: 0px;
        background-color: transparent" height="100%" cellspacing="0" cellpadding="0"
        width="100%">
        <tr>
            <td>
                <img onmousedown="cancelEvent(event)" ondragstart="cancelEvent(event)" height="100%"
                    src="../images/alpha.gif" width="100%">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
