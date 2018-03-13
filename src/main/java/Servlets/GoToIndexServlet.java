package Servlets;

import java.io.IOException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Models.*;
import com.sun.deploy.net.HttpResponse;
import com.sun.org.apache.xpath.internal.SourceTree;
import com.sun.org.apache.xpath.internal.operations.Bool;

@WebServlet("/index")
public class GoToIndexServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        String url=request.getHeader("Referer");
        System.out.println("Go ToIndex Servlet: URL = " + url);

        System.out.println(url);
        Boolean isLogged = false;
        if(session.getAttribute("isLogged")!=null){
            isLogged = (Boolean) session.getAttribute("isLogged");
        }
        if (url.contains("/login") || (url.contains("/index.jsp") && !isLogged)) {
            System.out.println("Go ToIndex Servlet: v ifa sum za login");

            byte ptext[] = request.getParameter("email").getBytes("ISO-8859-1");
            String email = new String(ptext, "UTF-8");
            ptext = request.getParameter("password").getBytes("ISO-8859-1");
            String password = new String(ptext, "UTF-8");

            /*String email = request.getParameter("email");
            String password = request.getParameter("password");*/

            LoginModel model = new LoginModel();
            String type = model.authenticateLogin(email, password);
            if (!type.equals("FAIL")) {
                session = request.getSession(true);
                session.setAttribute("isLogged", true);
                session.setAttribute("username", type);
                session.setAttribute("password", password);

                String emailFromDB = null;
                try {
                    emailFromDB = model.getEmail(type);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                String genderFromDB = null;
                try {
                    genderFromDB = model.getGender(type);
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                System.out.println("Email from DB = " + emailFromDB);
                System.out.println("Gender from DB = " + genderFromDB);
                session.setAttribute("email", emailFromDB);
                session.setAttribute("gender", genderFromDB);


                MedicamentCheck medicamentCheck = new MedicamentCheck();
                try {
                    medicamentCheck.isExpired(type);
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                String isCheckedRememberMe = request.getParameter("rememberMe");
                if(isCheckedRememberMe!=null && isCheckedRememberMe.equals("on")){
                    System.out.println("Remember me = " + isCheckedRememberMe);
                    Cookie usernameCookie = new Cookie("username", email);
                    usernameCookie.setPath("/");
                    usernameCookie.setMaxAge(60*60*24*30);
                    usernameCookie.setHttpOnly(true);
                    response.addCookie(usernameCookie);

                    Cookie passwordCookie = new Cookie("password", password);
                    passwordCookie.setPath("/");
                    passwordCookie.setMaxAge(60*60*24*30);
                    passwordCookie.setHttpOnly(true);
                    response.addCookie(passwordCookie);
                }

                if (session.getAttribute("searchingUrl")!=null){
                    String searchingURL = session.getAttribute("searchingUrl").toString();
                    //response.sendRedirect(searchingURL);
                    System.out.println("searching URL = " + searchingURL);
                    //response.sendRedirect("/search.jsp#"+ session.getAttribute("currentMedicamentId").toString());
                    //request.getRequestDispatcher(searchingURL).forward(request, response);
                    //response.sendRedirect("/search.jsp#"+session.getAttribute("medicamentNumber"));
                    //response.sendRedirect(searchingURL);
                    //response.sendRedirect(searchingURL+ "#" + session.getAttribute("medicamentNumber"));
                    response.sendRedirect(searchingURL+"#"+session.getAttribute("medicamentNumber"));
                }
                else if(session.getAttribute("previousURL")!=null){
                    response.sendRedirect((String)session.getAttribute("previousURL"));
                    session.removeAttribute("previousURL");
                }
                else{
                response.sendRedirect("/index.jsp");
                }
            }
            else if (type.equals("FAIL")) {
                System.out.println("vuv fail logina sum");
                session.setAttribute("hasFailedLogin",true);
                response.sendRedirect("/login.jsp");
            }
        }


        else if(url.contains("/manage_account.jsp")){
            session = request.getSession(false);
            String inputedPassword = request.getParameter("password");
            String currentPassword = (String) session.getAttribute("password");
            String username= (String) session.getAttribute("username");

            Cookie[] logoutCookies = request.getCookies();
            System.out.println("array lenght: " + logoutCookies.length);
            int j=0;
            Boolean isLogoutButtonClicked=null;
            for (Cookie cookie:logoutCookies) {

                if (logoutCookies[j].getName().equals("logoutButtonClicked")&&logoutCookies[j].getValue().equals("true")){
                    isLogoutButtonClicked=true;
                    break;
                }
                j++;
            }

            if(isLogoutButtonClicked!=null){
                System.out.println("GoToIndexServlet: logoutButtonClick (if)");
                if(isLogoutButtonClicked) {
                    if (session != null) {
                        session.invalidate();
                        Cookie[] cookies = request.getCookies();
                        System.out.println("array lenght: " + cookies.length);
                        int i=0;
                        for (Cookie cookie:cookies) {
                            System.out.println("(Before delete) Current cookie name: " + cookies[i].getName());
                            System.out.println("(Before delete) Current cookie value: " + cookies[i].getValue());
                            cookies[i].setValue(null);
                            cookies[i].setPath("/");
                            cookies[i].setMaxAge(0);
                            response.addCookie(cookies[i]);
                            System.out.println("(After delete) Current cookie name: " + cookies[i].getName());
                            System.out.println("(After delete) Current cookie value: " + cookies[i].getValue());//Panayot:Eisq idvam; Ivan:okeee!!!!!!!!!!!!!;
                            i++;
                            System.out.println("i = " + i + ";");
                        }
                    }
                    response.sendRedirect("/index.jsp");
                }
            }

            else if (inputedPassword.equals(currentPassword)){
                AccountDelete accountDelete= new AccountDelete();
                accountDelete.deleteAccount(username);
                session.invalidate();
                response.sendRedirect("/index.jsp");
            }
            else{
                response.sendRedirect("/manage_account.jsp");
                session.setAttribute("wrongPasswordAccountDelete", true);
            }
        }

        else if ((url.contains("/index.jsp") && isLogged) || url.contains("/search") || url.contains("/medicamentAssessment") || url.contains("/password_change") || url.contains("/map")){
            session = request.getSession(false);
            if (session != null) {
                session.invalidate();
                Cookie[] cookies = request.getCookies();
                System.out.println("array lenght: " + cookies.length);
                int i=0;
                for (Cookie cookie:cookies) {
                    System.out.println("(Before delete) Current cookie name: " + cookies[i].getName());
                    System.out.println("(Before delete) Current cookie value: " + cookies[i].getValue());
                    cookies[i].setValue(null);
                    cookies[i].setPath("/");
                    cookies[i].setMaxAge(0);
                    response.addCookie(cookies[i]);
                    System.out.println("(After delete) Current cookie name: " + cookies[i].getName());
                    System.out.println("(After delete) Current cookie value: " + cookies[i].getValue());//Panayot:Eisq idvam; Ivan:okeee!!!!!!!!!!!!!;
                    i++;
                    System.out.println("i = " + i + ";");
                }
            }
                response.sendRedirect("/index.jsp");
        }
    }
}

