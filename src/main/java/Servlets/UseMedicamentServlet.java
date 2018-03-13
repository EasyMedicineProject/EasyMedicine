package Servlets;

import Models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/useMedicament")
public class UseMedicamentServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String url;
        String secondParameterKey = "";


        url = request.getQueryString().toString();
        System.out.println("UseMedicamentServlet: query string = " + url);
        System.out.println("(Out of if) Searching URL = " + session.getAttribute("searchingUrl"));
        String refererUrl = request.getHeader("Referer");

        if (refererUrl.contains("search")) {
            if (session.getAttribute("isLogged") == null) {
                System.out.println("(When not logged in) Searching URL = " + session.getAttribute("searchingUrl"));

                if (url.contains("&")) {
                    String[] keyValuePairs = url.split("&");
                    String medicamentName = keyValuePairs[1].split("=")[1];
                    String assessmentButtonNumber = keyValuePairs[1].split("=")[0].split("-")[1];
                    session.setAttribute("medicamentNumber", assessmentButtonNumber);
                    //session.setAttribute("currentMedicamentId", currentMedicamentId);
                } else {
                    String assessmentButtonNumber = url.split("=")[0].split("-")[1];
                    session.setAttribute("medicamentNumber", assessmentButtonNumber);
                }
                response.sendRedirect("/login.jsp");
            } else {
                String indexOtherParameterKey;
                String medicamentName = "";
                System.out.println(url);


                if (url.contains("&")) {
                    String[] keyValuePairs = url.split("&");
                    String firstParameterValue = "";
                    try {
                        secondParameterKey = keyValuePairs[1].split("=")[0];
                        firstParameterValue = keyValuePairs[0].split("=")[1];

                    } catch (Exception e) {
                        firstParameterValue = "no value";
                    }
                    medicamentName = keyValuePairs[1].split("=")[1];
                    medicamentName = URLDecoder.decode(medicamentName, "UTF-8");
                    if (!firstParameterValue.equals("no value")) {
                        System.out.println("In if no-value");

                        UseMedicament useMedicament = new UseMedicament();
                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        Date deadLineDate = null;
                        System.out.println("UseMedicamentServlet: firstParameterValue = " + firstParameterValue);
                        try {
                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            deadLineDate = dateFormat.parse(firstParameterValue);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        System.out.println("UseMedicamentServlet: medicamentParameterName = " + medicamentName);
                        if (!useMedicament.useMedicament((String) session.getAttribute("username"), deadLineDate, medicamentName)) {
                            session.setAttribute("wrongInputDate", true);
                        }
                    }
                    String assessmentButtonNumber = keyValuePairs[1].split("=")[0].split("-")[1];
                    session.setAttribute("medicamentNumber", assessmentButtonNumber);
                    indexOtherParameterKey = url.split("&")[1].split("=")[0].split("-")[1];
                } else {
                    System.out.println("In else no-value");
                    String assessmentButtonNumber = url.split("&")[1].split("=")[0];
                    session.setAttribute("medicamentNumber", assessmentButtonNumber);
                    secondParameterKey = url.split("&")[1].split("=")[0];
                    indexOtherParameterKey = url.split("&")[1].split("=")[0].split("-")[1];
                    System.out.println("UseMedicamentServlet: isUsingMedicament = " + session.getAttribute("isUsingMedicament"));
                }
                System.out.println("UseMedicamentServlet: indexOtherParameterKey = " + indexOtherParameterKey);
                System.out.println("UseMedicamentServlet: secondParameterKey = " + secondParameterKey);
                if (secondParameterKey.contains("Stop")) {
                    UseMedicament useMedicament = new UseMedicament();
                    useMedicament.stopUsingMedicament((String) session.getAttribute("username"), medicamentName);
                } else {
                    System.out.println("UseMedicamentServlet: in else statement");
                }
                String searchValue = session.getAttribute("searchingUrl").toString().split("=")[1];
                System.out.println("(When logged in) Searching Url = " + searchValue);
                Search search = new Search();
                List<Medicament> searchResult = search.searchHerbs(searchValue);
                session.setAttribute("searchResult", searchResult);
                //request.getRequestDispatcher("/search.jsp#"+session.getAttribute("medicamentNumber")).forward(request, response);
                System.out.println("UseMedicamentServlet: Previous URL = " + request.getHeader("referer").toString());
                System.out.println("UseMedicamentServlet: Current URL = " + request.getRequestURL().toString() + "?" + request.getQueryString());
                response.sendRedirect(request.getHeader("Referer") + "#" + session.getAttribute("medicamentNumber"));
            }
        }
        else {

            String[] urlParameters = url.split("&");
            String medicamentName = urlParameters[0].split("=")[1];
            String date = urlParameters[1].split("&")[0].split("=")[1];

            if (medicamentName != "" && date != "") {

                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date deadLineDate = null;
                try {
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    deadLineDate = dateFormat.parse(date);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                UseMedicament useMedicament = new UseMedicament();
                try {
                    useMedicament.useCustomMedicament(session.getAttribute("username").toString(), deadLineDate, medicamentName);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                response.sendRedirect(refererUrl);
            }
        }
    }

}
