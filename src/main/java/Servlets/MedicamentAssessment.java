package Servlets;

import Models.*;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/medicamentAssessment")
public class MedicamentAssessment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String url;
        System.out.println("(Out of if) Searching URL = " + session.getAttribute("searchingUrl"));
        if (session.getAttribute("isLogged") == null) {
            System.out.println("(When not logged in) Searching URL = " + session.getAttribute("searchingUrl"));
            url = request.getQueryString().toString();
            if(url.contains("&")) {
                String[] keyValuePairs = url.split("&");
                String medicamentParameterValue = keyValuePairs[1].split("=")[1];
                String assessmentButtonNumber = keyValuePairs[1].split("=")[0].split("-")[1];
                session.setAttribute("medicamentNumber", assessmentButtonNumber);
                //session.setAttribute("currentMedicamentId", currentMedicamentId);
            }
            else {
                String assessmentButtonNumber = url.split("=")[0].split("-")[1];
                session.setAttribute("medicamentNumber", assessmentButtonNumber);
            }
            response.sendRedirect("/login.jsp");
        }
        else {
            url = request.getQueryString().toString();
            System.out.println(url);
            if(url.contains("&")) {
                String[] keyValuePairs = url.split("&");
                String otherParameterValue;
                try {
                    otherParameterValue = keyValuePairs[0].split("=")[1];
                } catch (Exception e) {
                    otherParameterValue = "no value";
                }
                String medicamentParameterValue = keyValuePairs[1].split("=")[1];

                if (!otherParameterValue.equals("no value")) {
                    if (otherParameterValue.matches("1|2|3|4|5")) {
                        Rate rate = new Rate();
                        rate.rate((String) session.getAttribute("username"), otherParameterValue, medicamentParameterValue);
                    } else {
                        Comment comment = new Comment();
                        comment.comment((String) session.getAttribute("username"), otherParameterValue, medicamentParameterValue);
                    }
                }
                String assessmentButtonNumber = keyValuePairs[1].split("=")[0].split("-")[1];
                session.setAttribute("medicamentNumber", assessmentButtonNumber);
            }
            else {
                String assessmentButtonNumber = url.split("=")[0].split("-")[1];
                session.setAttribute("medicamentNumber", assessmentButtonNumber);
            }
            String searchValue = session.getAttribute("searchingUrl").toString().split("=")[1];
            System.out.println("(When logged in) Searching Url = " + searchValue);
            Search search = new Search();
            List<Medicament> searchResult = search.searchHerbs(searchValue);
            session.setAttribute("searchResult",searchResult);
            //request.getRequestDispatcher("/search.jsp#"+session.getAttribute("medicamentNumber")).forward(request, response);
            //response.sendRedirect("/search.jsp#"+session.getAttribute("medicamentNumber"));
            response.sendRedirect(request.getHeader("Referer") + "#" + session.getAttribute("medicamentNumber"));
        }
    }
}




