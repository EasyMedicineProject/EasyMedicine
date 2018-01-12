package Servlets;

import Models.PasswordChange;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class AccountManagment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
                String username = (String)session.getAttribute("username");
        System.out.println(username);
                String currentPassword=request.getParameter("currentPassword");
        System.out.println(currentPassword);
                String newPassword=request.getParameter("newPassword");
        System.out.println(newPassword);
        PasswordChange password_change= new PasswordChange();
        password_change.changePassword(username,currentPassword,newPassword);
        RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
        rd.forward(request, response);
    }
}
