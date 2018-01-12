package Models;

import Utils.dbConnector;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoginModel {

    public String authenticateLogin(String email, String password) {
        Connection conn;
        Statement statement;
        ResultSet resultSet = null;
        String DBemail = "";
        String DBpassword = "";
        String DBusername = "";

        try {
            conn = dbConnector.createConnection();
            statement = conn.createStatement();
            resultSet = statement.executeQuery("select * from users");
            while (resultSet.next()) {
                DBemail = resultSet.getString("email");
                DBpassword = resultSet.getString("password");
                DBusername = resultSet.getString("username");

                //TO DO Register check for duplicate users
                if((email.equals(DBemail) && password.equals(DBpassword)) ||
                        (email.equals(DBusername) && password.equals(DBpassword))) {
                    return "SUCCESS";
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "FAIL";
    }
}