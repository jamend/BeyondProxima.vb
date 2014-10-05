<%@ Page Language="VB" AutoEventWireup="false" Inherits="BeyondProxima.proxima_Production" Codebehind="Production.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Production</title>
    <style type="text/css">
        html
        {
            height: 100%;
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
        .slider 
        {
        	-moz-user-select: none;
            -khtml-user-select: none;
            user-select: none;
        }
    </style>
	<script type="text/javascript">
	    var selectedslider;
		var mousedown;
		var displacement;
		
        window.onload = init;
        
        function init() {
            make_slider("income");
			make_slider("construction");
			make_slider("research");
			
	        document.body.onmouseup = body_onmouseup;
	        document.body.onmousemove = body_onmousemove;
        }
		
		function make_slider(slidername) {
			var div = document.getElementById(slidername + "div");
			var bar1 = document.getElementById(slidername + "1");
			var bar2 = document.getElementById(slidername + "2");
			var textbox = document.getElementById(slidername);
			bar1.width = textbox.value * 2;
			div.ondragstart = function () {
                window.event.returnValue = false;
			};
			
            div.onmousedown = function (e) {
                if (mousedown) {
			        return false;
			    }
			};
			textbox.onchange = function () {
				if (parseInt(textbox.value) > 100){
					textbox.value = 100;
				}else{
					if (parseInt(textbox.value) < 0){
						textbox.value = 0;
					}
				}
				bar1.width = textbox.value * 2;
				updatetotal();
			};
			bar2.onmousedown = function (e) {
				mousedown = true;
				selectedslider = slidername;
				if (e == null) {
					displacement = (getx(bar2) - event.clientX);
				}else{
					displacement = (getx(bar2) - e.clientX);
				}
			};
		}
		
		function body_onmouseup(e) {
		    if (!e) e = window.event;
			mousedown = false;
		}
		
		function body_onmousemove(e) {
		    if (!e) e = window.event;
			if(mousedown == true){
				document.body.style.cursor = "w-resize";
				var bar1 = document.getElementById(selectedslider + "1");
				var textbox = document.getElementById(selectedslider);
				if (e.clientX < getx(bar1)) {
					bar1.width = 0;
				}else{
					if (e.clientX > getx(bar1) + 200) {
						bar1.width = 200;
					}else{
						bar1.width = (e.clientX - getx(bar1) + displacement);
					}
				}
				textbox.value = parseInt(bar1.width / 2)
				updatetotal();
			}else{
				document.body.style.cursor = "auto";
			}
		}
		
		function total() {
			return parseInt(document.getElementById("income").value) + parseInt(document.getElementById("construction").value) + parseInt(document.getElementById("research").value);
		}
		
		function updatetotal() {
			if(total() != 100){
				document.getElementById("savesettings").disabled = true;
				document.getElementById("savesettings").style.backgroundColor = "gray";
				if(total() > 100){
					document.getElementById("total1").width = 200;
				}else{
					document.getElementById("total1").width = total() * 2;
				}
			}else{
				document.getElementById("savesettings").disabled = false;
				document.getElementById("savesettings").style.backgroundColor = "#232333";
				document.getElementById("total1").width = 200;
			}
			document.getElementById("total").value = total();
		}
		
		function getx(element) {
			var x = 0;
			while (element.offsetParent){
				x += element.offsetLeft;
				element = element.offsetParent;
			}
			return x;
		}
</script>
</head>
<body>
    <form id="form1" method="post" runat="server">
		<P align="center">Set how the production of your planets should be alloted:</P>
		<P align="center"><asp:label id="lblError" runat="server" ForeColor="#001EB8"></asp:label></P>
		<P align="center">
			<TABLE id="tblProfile" cellSpacing="0" cellPadding="0" align="center">
				<TR>
					<TD background="../images/tabletopleftcorner.gif" height="12" class="edges"></TD>
					<TD colSpan="3" height="12" class="edges"></TD>
					<TD background="../images/tabletoprightcorner.gif" height="12" class="edges"></TD>
				</TR>
				<TR>
					<TD class="edges"><IMG src="../images/spacer12.gif"></TD>
					<TD vAlign="middle" align="right" class="topleft"><STRONG>Income</STRONG></TD>
					<TD align="center" width="1" class="top">
						<DIV class="slider" id="incomediv" align="left"><IMG class="bar1" id="income1" height="12" src="../images/alpha.gif" width="20"><IMG class="bar2" id="income2" height="12" src="../images/alpha.gif" width="4"></DIV>
					</TD>
				    <TD align="center" class="topright"><INPUT class="textbox" id="income" style="WIDTH: 28px" type="text" maxLength="3" size="1"
				                                               value="20" name="computers" runat="server" />%</TD>
					<TD class="edges"><IMG src="../images/spacer12.gif"></TD>
				</TR>
				<TR>
					<TD class="edges"></TD>
					<TD vAlign="middle" align="right" class="left"><STRONG>Construction</STRONG></TD>
					<TD align="center" width="1" class="inner">
						<DIV class="slider" id="constructiondiv" align="left"><IMG class="bar1" id="construction1" height="12" src="../images/alpha.gif" width="10"><IMG class="bar2" id="construction2" height="12" src="../images/alpha.gif" width="4"></DIV>
					</TD>
				    <TD align="center" class="right"><INPUT class="textbox" id="construction" style="WIDTH: 28px" type="text" maxLength="3"
				                                            size="1" value="10" name="communications" runat="server" />s%</TD>
					<TD class="edges"></TD>
				</TR>
				<TR>
					<TD class="edges"></TD>
					<TD vAlign="middle" align="right" class="left"><STRONG>Research</STRONG></TD>
					<TD align="center" width="1" class="inner">
						<DIV class="slider" id="researchdiv" align="left"><IMG class="bar1" id="research1" height="12" src="../images/alpha.gif" width="20"><IMG class="bar2" id="research2" height="12" src="../images/alpha.gif" width="4"></DIV>
					</TD>
				    <TD align="center" class="right"><INPUT class="textbox" id="research" style="WIDTH: 28px" type="text" maxLength="3" size="1"
				                                            value="20" name="engines" runat="server" />%</TD>
					<TD class="edges"></TD>
				</TR>
				<TR>
					<TD class="edges"></TD>
					<TD vAlign="middle" align="right" class="bottomleft"><STRONG>Total</STRONG></TD>
					<TD align="center" width="1" class="bottom">
						<DIV class="slider" align="left"><IMG class="bar1" id="total1" height="12" src="../images/alpha.gif" width="200"><IMG class="bar2total" id="total2" height="12" src="../images/alpha.gif" width="4"></DIV>
					</TD>
					<TD align="center" class="bottomright"><INPUT class="textbox" id="total" style="WIDTH: 28px" readOnly type="text" maxLength="3"
							size="1" value="100" name="total">%</TD>
					<TD class="edges"></TD>
				</TR>
				<TR>
					<TD background="../images/tablebottomleftcorner.gif" class="edges"></TD>
					<TD colSpan="3" height="12" class="edges"></TD>
					<TD background="../images/tablebottomrightcorner.gif" height="12" class="edges"></TD>
				</TR>
			</TABLE>
		</P>
		<P align="center">
			<asp:button id="savesettings" runat="server" Text="Save Settings" CssClass="textbox"></asp:button></P>
	</form>
</body>
</html>
