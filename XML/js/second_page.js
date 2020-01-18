var xslDoc;
var xmlDoc;
var xmlHttpObj;
var  sortKey =  "name";
var id = "";
var sortOrder = 'ascending'
var sortType = 'text';

function CreateXmlHttpRequestObject()
{
    var xmlObj;
    
    if (window.ActiveXObject) {
        alert('Sorry, old browsers are not supported!\nTo run the project open the .xsl file, uncomment first lines and then open the .xml file!');
        window.stop();
    } else {
        xmlObj = new XMLHttpRequest();
    }
    
    return xmlObj;
}

function getStyleSheet()
{
    xmlHttpObj = CreateXmlHttpRequestObject();
    try {
        xmlHttpObj.open('GET', 'second_page.xsl', false);
        xmlHttpObj.send(null);
    } catch (e) {
        alert('You must fix your browser\'s security settings!\nTry with Firefox.\nFor Chrome --disable-web-security.\nTo run the project open the .xsl file, uncomment first lines and then open the .xml file!');
    }
    if (xmlHttpObj.status == 200 || xmlHttpObj.status == 0) {
        xslDoc = xmlHttpObj.responseXML; 
    } else {
        alert('error loading stylesheet ' + xmlHttpObj.status);
    }
}

function getDataFile()
{
    xmlHttpObj = CreateXmlHttpRequestObject();    
    xmlHttpObj.open('GET', 'xml_project.xml', false);
    xmlHttpObj.send(null);
    console.log(xmlHttpObj);
    if (xmlHttpObj.status == 200 || xmlHttpObj.status == 0) {
        xmlDoc = xmlHttpObj.responseXML;
    } else {
        alert('error loading data file ' + xmlHttpObj.status);
    }
}

function doTranslation()
{
    try {
        var processor = new XSLTProcessor();
        processor.importStylesheet(xslDoc);
        processor.setParameter(null, 'id', id);
        var newDocument = processor.transformToDocument(xmlDoc);
        document.getElementById('table').innerHTML = new XMLSerializer().serializeToString(newDocument);
                console.log(xmlDoc);

    } catch (e) {
        alert('error translating data file');
    }
}


function initialize()
{
    id = getURLParameter('id');
    console.log(id);
    getStyleSheet();
    getDataFile();
    doTranslation();
}

function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
}

$( document ).ready(function() {
                $('th').click( function() {
                    alert("clicked");
                });
});
