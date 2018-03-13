package Models;

import Utils.dbConnector;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Comment {
    public void comment(String username, String comment, String medicamentName) throws UnsupportedEncodingException {
        Connection conn;
        ResultSet resultSet;
        String selectQuery = "SELECT id FROM medicaments WHERE name=? LIMIT 1";
        String insertQuery = "INSERT INTO users_medicaments_comments(username, medicament_id, comment) VALUES(?,?,?);";
        System.out.println("Comment Model: username = " + username);
        System.out.println("Comment Model: comment = " + comment);
        medicamentName= URLDecoder.decode( medicamentName, "UTF-8" );
        comment= URLDecoder.decode( comment, "UTF-8" );
        System.out.println("Comment Model: medicamentName = " + medicamentName);
        try{
            conn = dbConnector.createConnection();

            PreparedStatement preparedStmt = conn.prepareStatement(selectQuery);
            preparedStmt.setString(1, medicamentName);
            resultSet= preparedStmt.executeQuery();
            System.out.println(resultSet.next());
            int id=resultSet.getInt("id");

            if(!resultSet.next() && username!=null){//tyka proverqvam da mojesh da komentirash samo kato si lognat...
                preparedStmt = conn.prepareStatement(insertQuery);
                preparedStmt.setString(1,username);
                preparedStmt.setInt(2,id);
                preparedStmt.setString(3,comment);
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
