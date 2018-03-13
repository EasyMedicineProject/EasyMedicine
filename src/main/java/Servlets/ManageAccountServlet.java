package Servlets;

import Models.Medicament;
import Models.Search;
import Models.UserMedicament;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/datePick")
public class ManageAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        System.out.println("user = " + session.getAttribute("username"));
        String url = request.getQueryString();

        if(session.getAttribute("userMedicaments")!=null){
            List<UserMedicament> userMedicaments =(List<UserMedicament>) session.getAttribute("userMedicaments");
            List<UserMedicament> currentDateMedicaments = new ArrayList<>();
            String rawSelectedDate = url.split("=")[1];
            session.setAttribute("selectedDate", rawSelectedDate);

            for (UserMedicament currentMedicament : userMedicaments) {
                String rawDateFrom = currentMedicament.getDateFrom();
                String rawDateTo = currentMedicament.getDeadline();
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    Date dateFrom = format.parse(rawDateFrom);
                    Date dateTo = format.parse(rawDateTo);
                    Date selectedDate = format.parse(rawSelectedDate);

                    if ((selectedDate.before(dateTo) && selectedDate.after(dateFrom))||selectedDate.equals(dateFrom)||selectedDate.equals(dateTo)) {
                        currentDateMedicaments.add(currentMedicament);
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                session.setAttribute("currentDateMedicaments", currentDateMedicaments);
            }
        }
        response.sendRedirect("/manage_account.jsp");


    }
}


