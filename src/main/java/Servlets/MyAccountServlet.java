package Servlets;

import Models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/myAccount")
public class MyAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        MyAccount myAccount = new MyAccount();
        List<UserMedicament> userMedicaments =myAccount.userMedicaments(session.getAttribute("username").toString());
        List<UserMedicament> todayMedicaments = new ArrayList<>();
        session.setAttribute("userMedicaments",userMedicaments);

        System.out.println("IN MY ACCOUNT SERVLET");

        for (UserMedicament currentMedicament : userMedicaments) {
            String rawDateFrom = currentMedicament.getDateFrom();
            String rawDateTo = currentMedicament.getDeadline();
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date dateFrom = format.parse(rawDateFrom);
                Date dateTo = format.parse(rawDateTo);
                Date date = new Date();
                String formattedDate = format.format(date);
                Date today = format.parse(formattedDate);

                if ((today.before(dateTo) && today.after(dateFrom))||today.equals(dateFrom)||today.equals(dateTo)) {
                    todayMedicaments.add(currentMedicament);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            session.setAttribute("todayMedicaments", todayMedicaments);
        }

       response.sendRedirect("/manage_account.jsp");
    }
}




