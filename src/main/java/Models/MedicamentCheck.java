package Models;

import Utils.dbConnector;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MedicamentCheck {
    public boolean isExpired(String username) throws UnsupportedEncodingException, SQLException, ParseException {
        System.out.println("in isExpired method");
        Connection conn;
        ResultSet usedMedicamentsResultSet;
        ResultSet medicamentCheckResultSet;

        String getUsedMedicament = "SELECT medicaments_use FROM users WHERE username=? OR email=?";
        String medicamentCheck = "SELECT um.username, um.medicament_name AS medicament_name,um.date_from, um.deadline FROM users_medicaments_use AS um INNER JOIN (SELECT username, max(date_from) AS MaxDate FROM users_medicaments_use GROUP BY username) AS umu ON um.username = umu.username AND um.date_from = umu.MaxDate  WHERE um.deadline<=? AND um.username = ?;";
        String updateQuery = "UPDATE users SET medicaments_use = ? WHERE username = ?;";

        conn = dbConnector.createConnection();

        PreparedStatement preparedStmt = conn.prepareStatement(getUsedMedicament);
        preparedStmt.setString(1, username);
        preparedStmt.setString(2, username);
        usedMedicamentsResultSet= preparedStmt.executeQuery();
        usedMedicamentsResultSet.next();
        System.out.println("usedMedicamentsResultSet medicaments_use = " + usedMedicamentsResultSet.getString("medicaments_use"));
        String medicamentsUse = usedMedicamentsResultSet.getString("medicaments_use");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String dateAsString = dateFormat.format(date);
        date = dateFormat.parse(dateAsString);
        System.out.println("Current date = " + dateFormat.format(date));
        Timestamp currentTimestamp = new java.sql.Timestamp(date.getTime());

        preparedStmt = conn.prepareStatement(medicamentCheck);
        preparedStmt.setTimestamp(1, currentTimestamp);
        preparedStmt.setString(2, username);
        medicamentCheckResultSet= preparedStmt.executeQuery();

        System.out.println("before while loop (Medicament check)");

        while(medicamentCheckResultSet.next()){
            System.out.println("in while loop (Medicament check)");
            String currentMedicament = medicamentCheckResultSet.getString("medicament_name").substring(0, 1).toLowerCase() +  medicamentCheckResultSet.getString("medicament_name") .substring(1);
            System.out.println("current string = " + currentMedicament);
            if(medicamentsUse.contains(currentMedicament)){
                System.out.println("in if check (Medicament check)");
                medicamentsUse = medicamentsUse.replace(","+currentMedicament,"");
            }
        }

        preparedStmt = conn.prepareStatement(updateQuery);
        preparedStmt.setString(1,medicamentsUse);
        preparedStmt.setString(2,username);
        preparedStmt.executeUpdate();

        return true;
    }
}
