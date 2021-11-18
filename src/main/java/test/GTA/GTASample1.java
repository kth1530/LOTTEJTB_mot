package test.GTA;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;


public class GTASample1{
    
    public static void main(String[] args) throws ParserConfigurationException, TransformerException, IOException, SAXException, XPathExpressionException {
        
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.client = "187";
        loginInfo.email = "XML.EBSOLUTIONS@LOTTE.COM";
        loginInfo.password = "PASS";
        
        SearchHotelRequest searchHotelRequest = new SearchHotelRequest();
        searchHotelRequest.cityDestination = "LGW";
        searchHotelRequest.checkInDate = "2016-10-14";
        searchHotelRequest.duration = "2";
        searchHotelRequest.roomCode = "db";
        searchHotelRequest.numberOfRooms = "2";

        Document request = createRequest(loginInfo, searchHotelRequest);
        Document response = getResponse(request, "https://interface.demo.gta-travel.com/rbskrapi/RequestListenerServlet");
        printResponse(response);

    }
    
    private static void printResponse(Document response) throws XPathExpressionException {
        printErrors(response);
        printResults(response);
    }

    private static DocumentBuilder getDocumentBuilder() throws ParserConfigurationException {
        DocumentBuilderFactory dbfac = DocumentBuilderFactory.newInstance();
        return dbfac.newDocumentBuilder();
    }

    private static XPath getXPath() {
        XPathFactory factory = XPathFactory.newInstance();
        return factory.newXPath();
    }

    /**
     * Builds a request with one SearchHotelPriceRequest
     */
    private static Document createRequest(LoginInfo loginInfo, SearchHotelRequest searchHotelRequest) throws ParserConfigurationException {
        Document doc = getDocumentBuilder().newDocument();
        Element request = doc.createElement("Request");
        doc.appendChild(request);

        request.appendChild(createSourceTag(loginInfo, doc));
        request.appendChild(createSearchSubrequest(searchHotelRequest, doc));
        return doc;
    }

    /**
     * Builds the Source element
     */
    private static Element createSourceTag(LoginInfo loginInfo, Document doc) {
        Element source = doc.createElement("Source");
        Element requestorId = doc.createElement("RequestorID");
        source.appendChild(requestorId);
        requestorId.setAttribute("Client", loginInfo.client);
        requestorId.setAttribute("EMailAddress", loginInfo.email);
        requestorId.setAttribute("Password", loginInfo.password);
        Element requestorPrefs = doc.createElement("RequestorPreferences");
        source.appendChild(requestorPrefs);
        Element requestMode = doc.createElement("RequestMode");
        requestorPrefs.appendChild(requestMode);
        requestMode.appendChild(doc.createTextNode("SYNCHRONOUS"));
        return source;
    }

    /**
     * Builds a search subrequest
     */
    private static Element createSearchSubrequest(SearchHotelRequest searchHotelRequest, Document doc) {
        Element requestDetails = doc.createElement("RequestDetails");
        Element searchHotelPriceRequest = doc.createElement("SearchHotelPriceRequest");
        requestDetails.appendChild(searchHotelPriceRequest);
        Element itemDestination = doc.createElement("ItemDestination");
        searchHotelPriceRequest.appendChild(itemDestination);
        itemDestination.setAttribute("DestinationType", "city");
        itemDestination.setAttribute("DestinationCode", searchHotelRequest.cityDestination);
        Element periodOfStay = doc.createElement("PeriodOfStay");
        searchHotelPriceRequest.appendChild(periodOfStay);
        Element checkInDate = doc.createElement("CheckInDate");
        periodOfStay.appendChild(checkInDate);
        checkInDate.appendChild(doc.createTextNode(searchHotelRequest.checkInDate));
        Element duration = doc.createElement("Duration");
        periodOfStay.appendChild(duration);
        duration.appendChild(doc.createTextNode(searchHotelRequest.duration));
        Element rooms = doc.createElement("Rooms");
        searchHotelPriceRequest.appendChild(rooms);
        Element room = doc.createElement("Room");
        rooms.appendChild(room);
        room.setAttribute("Code", searchHotelRequest.roomCode);
        room.setAttribute("NumberOfRooms", searchHotelRequest.numberOfRooms);
        return requestDetails;
    }

    /**
     * Opens a connection to the given url and reads the response back
     *
     * @param request   to send to the server
     * @param serverUrl where to send the request
     */
    private static Document getResponse(Document request, String serverUrl) throws IOException, TransformerException, SAXException, ParserConfigurationException {
        URL url = new URL(serverUrl);
        URLConnection urlConnection = url.openConnection();
        urlConnection.addRequestProperty("Content-type", "text/xml; charset=utf-8");
        urlConnection.setDoOutput(true);

        // Object to transform the DOM tree to a String
        TransformerFactory transfac = TransformerFactory.newInstance();
        Transformer trans = transfac.newTransformer();
        trans.setOutputProperty(OutputKeys.INDENT, "yes");

        // Writing the DOM tree to the server
        StreamResult result = new StreamResult(urlConnection.getOutputStream());
        DOMSource domSource = new DOMSource(request);
        trans.transform(domSource, result);

        // Reading back the result from the server
        InputStream inputStream = urlConnection.getInputStream();
        return getDocumentBuilder().parse(inputStream);
    }

    /**
     * Prints all the error messages found in the response
     */
    private static void printErrors(Document response) throws XPathExpressionException {
        // We use XPath the find all the Error messages
        NodeList errorList = (NodeList) getXPath().evaluate("//ErrorText", response, XPathConstants.NODESET);
        for (int i = 0; i < errorList.getLength(); i++) {
            Element error = (Element) errorList.item(i);
            System.out.println(error.getFirstChild().getNodeValue());
        }
    }

    /**
     * Writes all the hotel results from all the SearchHotelPriceRequest.
     */
    private static void printResults(Document response) throws XPathExpressionException {
        XPath xPath = getXPath();
        // Find all the subrequest
        NodeList subrequestList = (NodeList) xPath.evaluate("//ResponseDetails/SearchHotelPriceResponse", response, XPathConstants.NODESET);
        for (int i = 0; i < subrequestList.getLength(); i++) {
            Element subrequest = (Element) subrequestList.item(i);
            // find all the hotels for the subrequest
            NodeList hotelList = (NodeList) xPath.evaluate("//Hotel", subrequest, XPathConstants.NODESET);
            for (int j = 0; j < hotelList.getLength(); j++) {
                Element hotel = (Element) hotelList.item(j);
                printHotelInfo(xPath, hotel);
            }
        }
    }

    /**
     * Prints the hotel information
     *
     * @param hotel to pring
     */
    private static void printHotelInfo(XPath xPath, Element hotel) throws XPathExpressionException {
        String city = xPath.evaluate("City", hotel);
        String item = xPath.evaluate("Item", hotel);
        String itemPrice = xPath.evaluate("ItemPrice", hotel);
        String confirmation = xPath.evaluate("Confirmation", hotel);
        System.out.println(city + " | " + item + " | " + itemPrice + " | " + confirmation);
    }

    /**
     * Data container for the Login properties
     */
    private static class LoginInfo {
        public String client;
        public String password;
        public String email;
    }

    /**
     * Data container for the Serach properties
     */
    private static class SearchHotelRequest {
        private String cityDestination;
        public String checkInDate;
        public String duration;
        public String numberOfRooms;
        public String roomCode;
    }

    
}