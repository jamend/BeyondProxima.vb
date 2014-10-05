/// <reference path="XmlIntellisense.js />

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
}