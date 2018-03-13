package Servlets;

import Models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /*ServletContext servletContext = getServletContext();
        String contextPath = servletContext.getRealPath(File.separator);
        PrintWriter out = response.getWriter();
        System.out.println("<br/>File system context path (in TestServlet): " + contextPath);*/

        HttpSession session = request.getSession(true);
        String url = request.getHeader("Referer");
        if (url==null){
            url=request.getRequestURI();
        }
        String searchingURL = request.getRequestURL()+"?"+ request.getQueryString();
        session.setAttribute("searchingUrl",searchingURL);
        if(url!=null){
            if (url.contains("/index") || url.contains("/search") || url.contains("/medicamentAssessment") || url.contains("/manage_account") || url.contains("/password_change") || url.contains("/map") || url.contains("/login")) {
                String searchValue = request.getParameter("search").toLowerCase();
                Search search = new Search();
                List<Medicament> searchResultHerbs = search.searchHerbs(searchValue);
                List<Medicament> searchResultMedicaments = search.searchMedicaments(searchValue);
                if(session.getAttribute("isLogged")!=null){
                    try {
                        List<String>usedMedicaments=search.usedMedicaments((String)session.getAttribute("username"));
                        session.setAttribute("usedMedicaments", usedMedicaments);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                }
                System.out.println("searchResultHerbs: firstElementName = " + searchResultHerbs.get(0).getName());
                System.out.println("searchResultMedicaments: firstElementName = " + searchResultMedicaments.get(0).getName());
                session.setAttribute("searchResultHerbs", searchResultHerbs);
                session.setAttribute("searchResultMedicaments", searchResultMedicaments);
                request.getRequestDispatcher("/search.jsp").forward(request, response);
            }
        }
        else{
            request.getRequestDispatcher("/search.jsp").forward(request, response);
        }
    }
}

