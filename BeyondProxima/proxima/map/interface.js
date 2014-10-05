/// <reference path="ajax.js />
/// <reference path="drawing.js />
/// <reference path="windows.js />

/*
(c) Jonathan Amend, 2008
*/
var map; //the map div

//these hold the System and Fleet objects created from the init xml data
var systems = [];
var fleets = [];

//tracks the active fleet when setting a new course
var activeFleet;

//static data for planet environments
var environments = {
    1: {Name: "Gas Giant", PopulationFactor: 0, "ProductionFactor": 0, Image: "gasgiant"},
    2: {Name: "Volcanic", PopulationFactor: 0.25, "ProductionFactor": 0.5, Image: "volcanic"},
    3: {Name: "Ice", PopulationFactor: 0.5, "ProductionFactor": 0.75, Image: "ice"},
    4: {Name: "Barren", PopulationFactor: 0.75, "ProductionFactor": 0.75, Image: "barren"},
    5: {Name: "Desert", PopulationFactor: 0.75, "ProductionFactor": 1, Image: "desert"},
    6: {Name: "Terran", PopulationFactor: 1, "ProductionFactor": 1, Image: "terran"},
    7: {Name: "Rock", PopulationFactor: 0.75, "ProductionFactor": 1.25, Image: "rock"},
    8: {Name: "Jungle", PopulationFactor: 1.25, "ProductionFactor": 1, Image: "jungle"},
    9: {Name: "Terraformed", PopulationFactor: 1.25, "ProductionFactor": 1.25, Image: "jungle"}
};

window.onload = init;

function init() {
    //set up the map div
    map = document.getElementById("map");
    map.onclick = map_click_idle;
    map.onmousemove = map_mousemove_idle;
    map.onselectstart = null;

    initDrawing(map); //initiallize vml/svg/canvas drawing system
    winInit(); //initialize fake windowing system

    //get the init xml data
    sendAjaxCommand("MapCmd.aspx", "c=init", processMapData);

	//fix PNG transparency in ie<7
	var iev = parseFloat(navigator.appVersion.split("MSIE")[1]);
    if ((iev >= 5.5) && (iev < 7) && (document.body.filters)) {
        for (var i = document.images.length - 1; i >= 0; i--) {
            var img = document.images.item(i);
            var newImg = document.createElement("div");
            newImg.id = img.id;
            newImg.className = img.className;
            newImg.style.cssText = "filter: progid:DXImageTransform.Microsoft.AlphaImageLoader" + "(src=\'" + 
                img.src + "', sizingMethod='image'); " + img.style.cssText;
            newImg.style.width = img.width + "px";
            newImg.style.height = img.height + "px";
            newImg.alt = img.alt;
            newImg.innerHTML = "<!-- -->";
            img.outerHTML = newImg.outerHTML;
        }
    }
}

//create the System and Fleet objects from the init xml data
function processMapData(data) {
    /* input data ex:
    <result>
        <ship speed="1"/>
        <map>
            ﻿<S ID="4" X="0.000000000000000e+000" Y="0.000000000000000e+000" T="0"/>
            <S ID="5" X="4.000000000000000e+000" Y="6.000000000000000e+000" T="0"/>
            <S ID="6" X="2.000000000000000e+000" Y="7.000000000000000e+000" T="0"/>
            <S ID="7" X="5.000000000000000e+000" Y="2.000000000000000e+000" N="Zergland" T="0"/>
            <S ID="8" X="9.000000000000000e+000" Y="1.000000000000000e+000" T="0"/>
            <S ID="9" X="1.400000000000000e+001" Y="9.000000000000000e+000" T="0"/>
            <S ID="10" X="1.200000000000000e+001" Y="4.000000000000000e+000" T="0"/>
            <S ID="11" X="8.000000000000000e+000" Y="6.000000000000000e+000" N="Sol" T="0"/>
            <S ID="12" X="6.000000000000000e+000" Y="1.000000000000000e+001" T="0"/>
            <S ID="13" X="1.500000000000000e+001" Y="2.000000000000000e+000" T="0"/>
            <F ID="1" S1="13" X="1.500000000000000e+001" Y="2.000000000000000e+000" S="0.000000000000000e+000" T="0.000000000000000e+000"/>
            <F ID="5" S1="10" S2="6" X="1.200000000000000e+001" Y="4.000000000000000e+000" S="1.044030650891055e+001" T="0.000000000000000e+000"/>
            <F ID="6" S1="4" X="0.000000000000000e+000" Y="0.000000000000000e+000" S="0.000000000000000e+000" T="0.000000000000000e+000"/>
        </map>
    </result>
    
    S = System
        ID
        X, Y = coordinates (doubles)
        N = name
        T = star type
    F = Fleet
        ID
        S1 = system being orbited, or the last system it was orbiting
        S2 = destination fleet, if any
        X, Y = coordinates (doubles), will match S1 X, Y if in orbit
        S = total steps required for fleet's course
        T = total steps taken in fleet's course
    */
    var xmlSystems =  data.getElementsByTagName("S"); //select all S elements
    var xmlFleets = data.getElementsByTagName("F"); //select all F elements

    for (var i = 0; i < xmlSystems.length; i++) {
        systems[xmlSystems[i].getAttribute("ID")] = new System(
            xmlSystems[i].getAttribute("ID"),
            xmlSystems[i].getAttribute("X"),
            xmlSystems[i].getAttribute("Y"),
            xmlSystems[i].getAttribute("N"),
            xmlSystems[i].getAttribute("T")
        );
    }
    
    for (i = 0; i < xmlFleets.length; i++) {
        var fleet = new Fleet(
            xmlFleets[i].getAttribute("ID"),
            systems[xmlFleets[i].getAttribute("S1")],
            systems[xmlFleets[i].getAttribute("S2")],
            parseFloat(xmlFleets[i].getAttribute("X")),
            parseFloat(xmlFleets[i].getAttribute("Y")),
            parseFloat(xmlFleets[i].getAttribute("S")),
            parseFloat(xmlFleets[i].getAttribute("T"))
        );
        
        fleets[xmlFleets[i].getAttribute("ID")] = fleet;
        if (fleet.start) {
            systems[fleet.start.id].fleets[fleet.id] = fleet;
        }
    }
}

function processPlanets(data, system) {
    var xPlanets = data.getElementsByTagName("P");
    system.planets = [];
    
    for (var i = 0; i < xPlanets.length; i++) {
        system.planets[xPlanets[i].getAttribute("ID")] = new Planet(
            xPlanets[i].getAttribute("ID"),
            environments[xPlanets[i].getAttribute("E")],
            xPlanets[i].getAttribute("S"),
            xPlanets[i].getAttribute("O")
        );
    }
}

function showSystemDetails(system) {
    var win = winList["systemDetailsWindow"];
    win.titleBarText.innerHTML = system.img.alt;
    
    for (var i = win.clientArea.childNodes.length - 1; i >= 0; i--) {
        win.clientArea.removeChild(win.clientArea.childNodes.item(i));
    }

    for (var planet in system.planets) {
        win.clientArea.appendChild(system.planets[planet].div);
    }
    
    win.open();
}

function Planet(id, environment, size, occupied) {
    this.id = id;
    this.environment = environment;
    this.size = size;
    this.occupied = occupied;
    
    this.div = document.createElement("div");
    this.div.className = "planet";
    
    var img = document.createElement("img");
    img.src = "img/" + environment.Image + "128.jpg";
    this.div.appendChild(img);
}

function System(id, x, y, name, type) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.name = name;
    this.type = type;
    this.planets = null;
    this.fleets = [];
    
    this.realX = (64 * x);
    this.realY = (64 * y);
    
    this.showDetails = function () {
        if (this.planets === null) {
            sendAjaxCommand("MapCmd.aspx", "c=sysplanets&s=" + this.id, function(data, ref) {
                    processPlanets(data, ref);
                    showSystemDetails(ref);
                }, this);
        } else {
            showSystemDetails(this);
        }
    };
    
    var newObject = document.createElement("img");
    if (name === null) {
        newObject.alt = "System " + id;
    } else {
        newObject.alt = name;
    }
    newObject.src = "img/s" + this.type + ".png";
    newObject.className = "system";
    newObject.style.left = this.realX + "px";
    newObject.style.top = this.realY + "px";
    newObject.system = this;
    newObject.onmousemove = system_mousemove_idle;
    newObject.onclick = system_click_idle;
    map.appendChild(newObject);
    this.img = newObject;
}

function Fleet(id, start, dest, x, y, steps, step) {
    this.id = id;
    this.start = start;
    this.dest = dest;
    this.x = x;
    this.y = y;
    this.steps = steps;
    this.step = step;
    
    if (steps - step > 0) {
        //calculate fleet's position
        if (start && x == start.x && y == start.y) { //fleet just left orbit
            this.realX = start.realX;
            this.realY = start.realY + 32;
        } else {
            this.inorbit = false;
            this.realX = Math.round(64 * x) + 16;
            this.realY = Math.round(64 * y) + 16;
        }
    
        this.line = new Line(
                Math.round(16 + this.realX),
                Math.round(16 + this.realY),
                Math.round(32 + dest.realX),
                Math.round(32 + dest.realY),
                "green");
    } else { //in orbit
        this.inorbit = true;
        this.realX = 32 + start.realX;
        this.realY = start.realY;
        
        this.line = new Line(
                Math.round(start.realX + 16),
                Math.round(start.realY + 48),
                Math.round(start.realX + 32),
                Math.round(start.realY + 32),
                "red");
        this.line.hide();
    }
    
    var newObject = document.createElement("img");
    newObject.src = "img/fleet.png";
    newObject.className = "fleet";
    newObject.style.left = this.realX + "px";
    newObject.style.top = this.realY + "px";
    newObject.fleet = this;
    newObject.onclick = fleet_click_idle;
    newObject.onmousemove = fleet_mousemove_idle;
    map.appendChild(newObject);
    this.img = newObject;
}

var system_mousemove_idle = null;
var map_mousemove_idle = null;
var fleet_mousemove_idle = null;

var system_mousemove_coursechange = function(e) { //valid move
    activeFleet.line.change(
        Math.round(32 + this.system.realX),
        Math.round(32 + this.system.realY),
        "blue");
    
    if (window.event) {
        window.event.cancelBubble = true;
    } else {
        e.stopPropagation();
    }
}

var map_mousemove_coursechange = function(e) { //invalid move
    if (!e) e = window.event;
    activeFleet.line.change(e.clientX, e.clientY, "red");
}

var fleet_mousemove_coursechange = function(e) { //invalid move
    if (!e) e = window.event;
    activeFleet.line.change(e.clientX, e.clientY, "red");
}

var system_click_idle = function(e) {
    this.system.showDetails();
};

var map_click_idle = null;

var fleet_click_idle = function(e) { //course change
    activeFleet = this.fleet;
    if (activeFleet.inorbit) {
        activeFleet.line.show();
        //take ship out of orbit
        activeFleet.realX -= 32;
        activeFleet.realY += 32;
        this.style.left = activeFleet.realX + "px";
        this.style.top = activeFleet.realY + "px";
    };
    
    for (var system in systems) {
        systems[system].img.onclick = system_click_coursechange;
        systems[system].img.onmousemove = system_mousemove_coursechange;
    }
    map.onclick = function(e) { map.onclick = map_click_coursechange };
    map.onmousemove = function(e) { map.onmousemove = map_mousemove_coursechange };
    for (var fleet in fleets) {
        fleets[fleet].img.onclick = fleet_click_coursechange;
        fleets[fleet].img.onmousemove = fleet_mousemove_coursechange;
    }
}

var system_click_coursechange = function(e) { //set new course
    if (this.system == activeFleet.start && activeFleet.step == 0) {
        //undo course change
        sendAjaxCommand("MapCmd.aspx", "c=abortcourse&f=" + activeFleet.id, function(data, system) {
            activeFleet.dest = null;
            activeFleet.step = 0;
            activeFleet.steps = 0;
            activeFleet.inorbit = true;
            map_click_coursechange(e)
        }, this.system );
    } else {
        //new course
        sendAjaxCommand("MapCmd.aspx", "c=setcourse&f=" + activeFleet.id + "&d=" + this.system.id, function(data, system) {
            activeFleet.dest = system;
            activeFleet.step = 0;
            activeFleet.inorbit = false;
            activeFleet.line.change(
                32 + system.realX,
                32 + system.realY,
                "green"
            );
        }, this.system );
    }
    
    for (var system in systems) {
        systems[system].img.onclick = system_click_idle;
        systems[system].img.onmousemove = system_mousemove_idle;
    }
    map.onclick = map_click_idle;
    map.onmousemove = map_mousemove_idle;
    for (var fleet in fleets) {
        fleets[fleet].img.onclick = fleet_click_idle;
        fleets[fleet].img.onmousemove = fleet_mousemove_idle;
    }
}

var map_click_coursechange = function(e) { //abort course change
    if (activeFleet.inorbit) {
        activeFleet.line.hide();
        //move ship back to idle orbit
        activeFleet.realX += 32;
        activeFleet.realY -= 32;
        activeFleet.img.style.left = activeFleet.realX + "px";
        activeFleet.img.style.top = activeFleet.realY + "px";
    } else {
        activeFleet.line.change( //reset line to current path
            Math.round(32 + activeFleet.dest.realX),
            Math.round(32 + activeFleet.dest.realY),
            "green");
    }
    
    for (var system in systems) {
        systems[system].img.onclick = system_click_idle;
        systems[system].img.onmousemove = system_mousemove_idle;
    }
    map.onclick = map_click_idle;
    map.onmousemove = map_mousemove_idle;
    for (var fleet in fleets) {
        fleets[fleet].img.onclick = fleet_click_idle;
        fleets[fleet].img.onmousemove = fleet_mousemove_idle;
    }
}

var fleet_click_coursechange = function(e) {
    map_click_coursechange(e);
    
    //check if we should toggle to next fleet
    //TODO needs work
    if (this.fleet == activeFleet) {
        for (var fleet in fleets) {
            if (fleets[fleet] != activeFleet && fleets[fleet].realX == activeFleet.realX && fleets[fleet].realY == activeFleet.realY) {
                fleets[fleet].img.onclick(e);
                break;
            }
        }
    }
}

////////////////////////////////////////////
// ajax.js

function getXhr() {
    if (window.XMLHttpRequest && !(window.ActiveXObject)) {
    	try { return new XMLHttpRequest(); }
    	catch(e) {}
    } else if (window.ActiveXObject) {
       	try { return new ActiveXObject("Msxml2.XMLHTTP.6.0"); }
       	catch(e) {
       	    try { return new ActiveXObject("Msxml2.XMLHTTP.3.0"); }
       	    catch(e) {}
        }
    }
    alert("Your browser does not support AJAX.");
}

function sendAjaxCommand(url, data, oncomplete, ref) {
	var xhr = getXhr();
	if (xhr) {
		xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status == 200){
					if (xhr.responseXML) {
						oncomplete(xhr.responseXML, ref);
					} else {
						oncomplete(xhr.responseText, ref);
					}
				}
			}
     	xhr.open("POST", url, true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.setRequestHeader("Content-Length", data.length);
		xhr.setRequestHeader("Connection", "close");
		xhr.send(data);
	}
}

function xPath(xmlDoc, xpath) {
    if (document.implementation.hasFeature("XPath", "3.0")) { //firefox
        var ns = xmlDoc.createNSResolver(xmlDoc.documentElement);
        return xmlDoc.evaluate(xpath, xmlDoc, ns, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    } else { //ie
        return xmlDoc.selectSingleNode(xpath);
    }
    return new FakeNode();
}

function doNothing(data) {};

////////////////////////////////////////////
// drawing.js

var useVml;
var useCanvas;
var useSvg;
var base;

function initDrawing(container) {
    base = container;

    var canvas = document.createElement('canvas');
    if (!!(canvas.getContext && canvas.getContext('2d'))) {
        useCanvas = true;
    } else {
        if (document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#Shape", "1.0")) {
            var svgDoc = document.createElementNS("http://www.w3.org/2000/svg", "svg:svg");
            base.appendChild(svgDoc);
            base = svgDoc;
            useSvg = true;
        } else {
            useVml = true; // IE
        }
    }
}

function Line(x1, y1, x2, y2, colour) {
    this._line;
    
    if (useVml) {
        this._line = new VmlLine(x1, y1, x2, y2, colour);
    } else {
        if (useCanvas) {
            this._line = new CanvasLine(x1, y1, x2, y2, colour);
        } else {
            if (useSvg) {
                this._line = new SvgLine(x1, y1, x2, y2, colour);
            } else {
                //too bad, time to upgrade
            }
        }
    }
    
    this.hide = function() {
        this._line._line.style.visibility = "hidden";
    };
    
    this.show = function() {
        this._line._line.style.visibility = "visible";
    };
    
    this.change = function (x2, y2, colour) {
        this._line.change(x2, y2, colour);
    };
    
    this.destroy = function () {
        base.removeChild(this._line._line);
    };
}

function VmlLine(x1, y1, x2, y2, colour) {
    var vmlLine = document.createElement("v:line");
    vmlLine.strokeColor = colour;
    vmlLine.strokeWeight = "2px";
    vmlLine.from = x1 + "px," + y1 + "px";
    vmlLine.to = x2 + "px," + y2 + "px";
    base.appendChild(vmlLine);
    
    this._line = vmlLine;
    
    this.change = function (x2, y2, colour) {
        vmlLine.strokeColor = colour;
        vmlLine.to = x2 + "px," + y2 + "px";
    };
}

function CanvasLine(x1, y1, x2, y2, colour) {
    var canvas = document.createElement("canvas");
    canvas.style.position = "absolute";
    canvas.style.zIndex = "1";
    canvas.width = document.documentElement.clientWidth;
    canvas.height = document.documentElement.clientHeight;
    var ctx = canvas.getContext("2d");
    ctx.strokeStyle = colour;
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.stroke();
    base.appendChild(canvas);
    
    this._line = canvas;
    
    this.change = function (x2, y2, colour) {
        ctx.clearRect(0, 0, document.documentElement.clientWidth, document.documentElement.clientHeight);
        ctx.strokeStyle = colour;
        ctx.beginPath();
        ctx.moveTo(x1, y1);
        ctx.lineTo(x2, y2);
        ctx.stroke();
    };
}

function SvgLine(x1, y1, x2, y2, colour) {
    var svgLine = document.createElementNS("http://www.w3.org/2000/svg", "svg:line");
    svgLine.setAttributeNS(null, "x1", x1);
    svgLine.setAttributeNS(null, "y1", y1);
    svgLine.setAttributeNS(null, "x2", x2);
    svgLine.setAttributeNS(null, "y2", y2);
    svgLine.setAttributeNS(null, "stroke", colour);
    svgLine.setAttributeNS(null, "stroke-width", "2");
    base.appendChild(svgLine);
    
    this._line = svgLine;
    
    this.change = function (x2, y2, colour) {
        svgLine.setAttributeNS(null, "x2", x2);
        svgLine.setAttributeNS(null, "y2", y2);
        svgLine.setAttributeNS(null, "stroke", colour);
    };
}