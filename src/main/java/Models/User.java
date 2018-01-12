package Models;

import Utils.dbConnector;
import sun.misc.BASE64Encoder;

import javax.jms.Session;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.*;


public class User {
    public boolean CreateRegistration(String email, String password, String username) throws SQLException {

        Connection conn;
        BASE64Encoder enc = new BASE64Encoder();
        String encodedPassword;

        try {
            conn = dbConnector.createConnection();
            encodedPassword = password;
            String query = " insert into users (email,password,username)"
                    + " values (?, ?, ?)";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setString(1, email);
            preparedStmt.setString(2, encodedPassword);
            preparedStmt.setString(3,username);
            preparedStmt.executeUpdate();
            System.out.println(preparedStmt);
            System.out.println("VKARA USERA V BAZATA dANNI");
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("NESHTO NE STAVA");
            return false;
        }


    }


}

