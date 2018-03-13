package Servlets;

import Models.PasswordChange;
import Models.User;
import com.sun.deploy.cache.Cache;
import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet("/login")
public class AccountManagment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = request.getHeader("Referer");

        if (url.contains("/registration.jsp")) {

            byte ptext[] = request.getParameter("email").getBytes("ISO-8859-1");
            String email = new String(ptext, "UTF-8");
            ptext = request.getParameter("password").getBytes("ISO-8859-1");
            String password = new String(ptext, "UTF-8");
            ptext = request.getParameter("username").getBytes("ISO-8859-1");
            String username = new String(ptext, "UTF-8");
            ptext = request.getParameter("gender").getBytes("ISO-8859-1");
            String gender = new String(ptext, "UTF-8");



            /*String email = (String) request.getParameter("email");
            String password = request.getParameter("password");
            String username = (String) request.getParameter("username");
            String gender = request.getParameter("gender");*/

            System.out.println("Account Managment Servlet Email = " + email);
            System.out.println("Account Managment Servlet Password = " + password);
            System.out.println("Account Managment Servlet Username = " + username);
            System.out.println("Account Managment Servlet Gender = " + gender);

            User user = new User();
            if(password.length()>=6){
            try {
                user.CreateRegistration(email, password, username, gender);
                response.sendRedirect("/login.jsp");

            } catch (SQLException e) {
                HttpSession session = request.getSession(true);
                session.setAttribute("invalidRegistration", true);
                response.setHeader("Refresh", "0; URL=http://localhost:8080/registration.jsp");
                e.printStackTrace();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            }
        else if(password.length()<6){
            HttpSession session = request.getSession(true);
            System.out.println("AccountManagment servlet: Too short password");
            session.setAttribute("shortPassword", true);
            response.setHeader("Refresh", "0; URL=http://localhost:8080/registration.jsp");
        }
        } else if (url.contains("/password_change.jsp")) {
            HttpSession session = request.getSession(false);
            String username = (String) session.getAttribute("username");
            String currentPassword = request.getParameter("currentPassword");
            System.out.println("account_managment: current password " + currentPassword);
            String newPassword = request.getParameter("newPassword");
            System.out.println("account_managment: new password " + newPassword);
            String newPasswordRepeated=request.getParameter("newPasswordRepeated");
            System.out.println("account_managment: new password repeated "+newPasswordRepeated);
            if(!currentPassword.equals(session.getAttribute("password"))){
                session.setAttribute("notMatchingCurrentPassword", true );
                System.out.println("inputed password is not the same with the current password");
            }
            else{
                session.setAttribute("notMatchingCurrentPassword", false );
                System.out.println("inputed password is  the same with the current password");
            }
            if (!(newPassword.equals(newPasswordRepeated))){
                session.removeAttribute("notMatchingNewPasswords");
                session.setAttribute("notMatchingNewPasswords", true );
                System.out.println("the passwords are diff");
            }
            else{
                session.removeAttribute("notMatchingNewPasswords");
                session.setAttribute("notMatchingNewPasswords", false );
                System.out.println("the passwords are the same");
            }

            if (session.getAttribute("notMatchingNewPasswords")!=null && session.getAttribute("notMatchingCurrentPassword")!=null) {
                if (!(Boolean) session.getAttribute("notMatchingNewPasswords") && !(Boolean) session.getAttribute("notMatchingCurrentPassword")) {
                    PasswordChange password_change = new PasswordChange();
                    password_change.changePassword(username, currentPassword, newPassword);
                    session.setAttribute("currentPassword", newPassword);
                    response.sendRedirect("/login.jsp");
                    session.invalidate();
                } else {
                    response.sendRedirect("/password_change.jsp");
                }
            }

            }

        }

    }




