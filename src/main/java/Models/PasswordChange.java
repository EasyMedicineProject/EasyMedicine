package Models;

import Utils.dbConnector;

import java.sql.*;

public class PasswordChange {
    public void changePassword(String username, String currentPassword, String newPassword) {
        Connection conn;
        Statement getInfoStatement;
        Statement changeInfoStatement;
        ResultSet resultSet = null;
        String DBemail = "";
        String DBpassword = "";
        String DBusername = "";

        try {
            conn = dbConnector.createConnection();
            getInfoStatement = conn.createStatement();
            changeInfoStatement = conn.createStatement();
            resultSet = getInfoStatement.executeQuery("select * from users");
            while (resultSet.next()) {
                DBemail = resultSet.getString("email");
                DBpassword = resultSet.getString("password");
                DBusername = resultSet.getString("username");
                //TO DO Register check for duplicate users
                if((username.equals(DBemail) && currentPassword.equals(DBpassword)) ||
                        (username.equals(DBusername) && currentPassword.equals(DBpassword))) {
                    String query = " UPDATE users SET password=? WHERE username=? OR email=?";

                    PreparedStatement preparedStmt = conn.prepareStatement(query);
                    preparedStmt.setString(1, newPassword);
                    preparedStmt.setString(2, username);
                    preparedStmt.setString(3,username);
                    preparedStmt.executeUpdate();
                }


            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
