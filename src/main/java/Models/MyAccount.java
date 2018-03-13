package Models;

import Utils.dbConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class MyAccount {
    public List<UserMedicament> userMedicaments(String username) {

        Connection conn;
        ResultSet resultSet;
        List<UserMedicament> medicaments = new ArrayList<>();
        //Map<String, String> medicaments = new HashMap<>();
        String getUserMedicamentsQuery = "SELECT medicament_name AS 'medicament_name',date_from,deadline FROM users_medicaments_use WHERE username = ?";

        PreparedStatement preparedStmt;
        try {
            conn = dbConnector.createConnection();

            preparedStmt = conn.prepareStatement(getUserMedicamentsQuery);
            preparedStmt.setString(1, username);
            resultSet = preparedStmt.executeQuery();
            System.out.println("medicamentsResultSet = " + resultSet.next());
            resultSet.previous();

            while(resultSet.next()){
                UserMedicament userMedicament;
                userMedicament = new UserMedicament(resultSet.getString("medicament_name"), resultSet.getString("date_from"), resultSet.getString("deadline"));

                medicaments.add(userMedicament);
            }

            resultSet.close();
            preparedStmt.close();
            conn.close();



        } catch (SQLException e) {
            e.printStackTrace();
        }

       return medicaments;
    }
}
