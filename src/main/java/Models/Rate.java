package Models;

import Utils.dbConnector;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Rate {
    public void rate(String username, String rating, String medicamentName) throws UnsupportedEncodingException {
        Connection conn;
        ResultSet resultSet;
        String selectQuery = "SELECT id FROM medicaments WHERE name=? LIMIT 1";
        String insertQuery = "INSERT INTO users_medicaments_ratings(username, medicament_id, rating_value) VALUES(?,?,?);";
        String checkQuery = "SELECT username,medicament_id FROM users_medicaments_ratings WHERE username=? AND medicament_id=? LIMIT 1";
        System.out.println("Rate Model: username = " + username);
        System.out.println("Rate Model: rating = " + rating);
        medicamentName=URLDecoder.decode( medicamentName, "UTF-8" );
        System.out.println("Rate Model: medicamentName = " + medicamentName);
        try{
            conn = dbConnector.createConnection();

            PreparedStatement preparedStmt = conn.prepareStatement(selectQuery);
            preparedStmt.setString(1, medicamentName);
            resultSet= preparedStmt.executeQuery();
            System.out.println(resultSet.next());
            int id=resultSet.getInt("id");

            preparedStmt = conn.prepareStatement(checkQuery);
            preparedStmt.setString(1, username);
            preparedStmt.setInt(2, id);
            resultSet= preparedStmt.executeQuery();

            if(!resultSet.next() && username!=null){  //tuka izbqgvam povtoreniqta (edin user da ne moje da slaga 2 reitinga za 1 lekarstvo) i da ne moje kato ne si lognata da ratevash
                preparedStmt = conn.prepareStatement(insertQuery);
                preparedStmt.setString(1,username);
                preparedStmt.setInt(2,id);
                preparedStmt.setString(3,rating);
                preparedStmt.executeUpdate();
            }


            resultSet.close();
            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

