package Servlets;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Models.AccountDelete;
import Models.LoginModel;
import Models.User;
import com.sun.org.apache.xpath.internal.SourceTree;

@WebServlet("/index")
public class GoToIndexServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String url=request.getHeader("Referer");


        System.out.println(url);
        if (url.equals("http://localhost:8080/login.jsp")/*TOZI LOGIN E OT INDEXA*/|| url.equals("http://localhost:8080/login")/*TOZI LINK E OT LOGIN SLED SMQNA NA PASS*/) {
            String email = request.getParameter("email");
            System.out.println("vzeh emaila");
            String password = request.getParameter("password");
            System.out.println("vzeh parolata");
            System.out.println("Variables: " + email + password);
            HttpSession session = request.getSession();
            LoginModel model = new LoginModel();
            String type = model.authenticateLogin(email, password);
            System.out.println("LOGIN message: " + type);
            if (type.equals("SUCCESS")) {
                session.setAttribute("check", true);
                session.setAttribute("username", email);
                session.setAttribute("password", password);
                RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);

            } else if (type.equals("FAIL")) {
                session.setAttribute("check", false);
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
            }
        }

        else if(url.equals("http://localhost:8080/registration.jsp")/* TOZI E OT REGISTER KYM INDEX */) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String username= request.getParameter("username");
            System.out.println("PARAMETRITE OT REGISTER FORMATA SA VZETI");
            User user = new User();
            try {
                user.CreateRegistration(email, password,username);
                RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                RequestDispatcher rd = request.getRequestDispatcher("/registration.jsp");
                rd.forward(request, response);
            }


        }

        else if(url.equals("http://localhost:8080/manage_account.jsp")/*TOZI E OT ACCOUNT CHANGE KYM INDEX*/){
            HttpSession session = request.getSession(true);
            String inputedPassword = request.getParameter("password");
            System.out.println(inputedPassword);
            String currentPassword = (String) session.getAttribute("password");
            System.out.println(currentPassword);
            String username= (String) session.getAttribute("username");
            if (inputedPassword.equals(currentPassword)){
                AccountDelete accountDelete= new AccountDelete();
                accountDelete.deleteAccount(username);
                RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
            }
            else{
                System.out.println("spira na proverka na parolata");
            }
        }


    }


}

