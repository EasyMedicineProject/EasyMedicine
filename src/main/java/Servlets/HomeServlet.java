package Servlets;

import java.io.IOException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Models.*;
import com.sun.deploy.net.HttpResponse;
import com.sun.org.apache.xpath.internal.SourceTree;
import com.sun.org.apache.xpath.internal.operations.Bool;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("IN HOME SERVLET!!!");
        HttpSession session = request.getSession(true);
        MedicamentUtils medicamentUtils = new MedicamentUtils();
        List<Medicament> topFiveMedicaments = medicamentUtils.topFiveMedicaments();

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        Timestamp currentTimestamp = new java.sql.Timestamp(date.getTime());
        Date newDate=null;
        try {
            newDate = dateFormat.parse(dateFormat.format(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String dailyHealthTips="";
        System.out.println("Current date 1 = " + newDate);
        System.out.println("(session) Current date 1 = " + session.getAttribute("todayDate"));
        if(session.getAttribute("todayDate")!=null){
            if(newDate.before((Date)session.getAttribute("todayDate")) || newDate.after((Date)session.getAttribute("todayDate"))){
                System.out.println("today in if");
                session.setAttribute("todayDate", newDate);
                dailyHealthTips = medicamentUtils.dailyHealthTips();
                session.setAttribute("dailyHealthTips",dailyHealthTips);
            }
        }
        else{
            System.out.println("today in else");
            session.setAttribute("todayDate", newDate);
            dailyHealthTips = medicamentUtils.dailyHealthTips();
            session.setAttribute("dailyHealthTips",dailyHealthTips);
        }

        //Timestamp currentTimestamp = new java.sql.Timestamp(date.getTime());
        System.out.println("Daily healthTips (in servlet) = " + dailyHealthTips);
        session.setAttribute("topFiveMedicaments", topFiveMedicaments);
        if (session.getAttribute("indexFlag")==null) {
            session.setAttribute("indexFlag", false);
        }
        response.sendRedirect("/index.jsp");
    }
}

