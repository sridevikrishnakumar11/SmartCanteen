package com.smartcanteen.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * MenuXmlServlet - XML Output Servlet
 * Emits canteen menu catalog in XML format (application/xml) demonstrating Servlet + XML data interchange.
 */
@WebServlet("/MenuXmlServlet")
public class MenuXmlServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/xml");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");

        PrintWriter out = response.getWriter();
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.println("<canteenCatalog>");
        out.println("    <generatedAt>" + new java.util.Date() + "</generatedAt>");
        out.println("    <items>");
        
        out.println("        <item id=\"1\" category=\"South Indian\" veg=\"true\">");
        out.println("            <name>Crispy Masala Dosa</name>");
        out.println("            <price currency=\"INR\">45.00</price>");
        out.println("            <prepTimeMinutes>6</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"2\" category=\"South Indian\" veg=\"true\">");
        out.println("            <name>Steamed Idli Sambar (2 pcs)</name>");
        out.println("            <price currency=\"INR\">30.00</price>");
        out.println("            <prepTimeMinutes>4</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"3\" category=\"Meals &amp; Biryani\" veg=\"false\">");
        out.println("            <name>Chicken Dum Biryani</name>");
        out.println("            <price currency=\"INR\">120.00</price>");
        out.println("            <prepTimeMinutes>5</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"15\" category=\"Beverages\" veg=\"true\">");
        out.println("            <name>Special Masala Tea</name>");
        out.println("            <price currency=\"INR\">15.00</price>");
        out.println("            <prepTimeMinutes>3</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"16\" category=\"Beverages\" veg=\"true\">");
        out.println("            <name>South Indian Filter Coffee</name>");
        out.println("            <price currency=\"INR\">20.00</price>");
        out.println("            <prepTimeMinutes>3</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"17\" category=\"Snacks &amp; Bakery\" veg=\"true\">");
        out.println("            <name>Crispy Samosa (2 pcs)</name>");
        out.println("            <price currency=\"INR\">30.00</price>");
        out.println("            <prepTimeMinutes>4</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"19\" category=\"Snacks &amp; Bakery\" veg=\"true\">");
        out.println("            <name>Crispy Onion Bajji</name>");
        out.println("            <price currency=\"INR\">20.00</price>");
        out.println("            <prepTimeMinutes>5</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"20\" category=\"Snacks &amp; Bakery\" veg=\"true\">");
        out.println("            <name>Golden Potato Bonda</name>");
        out.println("            <price currency=\"INR\">25.00</price>");
        out.println("            <prepTimeMinutes>4</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"21\" category=\"Beverages\" veg=\"true\">");
        out.println("            <name>Cavin's Cold Milkshake</name>");
        out.println("            <price currency=\"INR\">40.00</price>");
        out.println("            <prepTimeMinutes>1</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("        <item id=\"22\" category=\"Snacks &amp; Bakery\" veg=\"false\">");
        out.println("            <name>Bakery Masala Egg Puff</name>");
        out.println("            <price currency=\"INR\">25.00</price>");
        out.println("            <prepTimeMinutes>2</prepTimeMinutes>");
        out.println("            <status>AVAILABLE</status>");
        out.println("        </item>");

        out.println("    </items>");
        out.println("</canteenCatalog>");
    }
}
