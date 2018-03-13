package Models;

import Utils.dbConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MedicamentUtils {
    public List<Medicament> topFiveMedicaments() {

        Connection conn;
        ResultSet resultSet;
        List<Medicament> medicaments = new ArrayList<>();
        String getTopFiveMedicaments = "SELECT username, (SELECT name FROM medicaments WHERE id=(SELECT medicament_id)) AS medicament_name , (SELECT imagePath FROM medicaments WHERE id=(SELECT medicament_id)) AS image_path, AVG(rating_value) AS rating FROM users_medicaments_ratings GROUP BY medicament_id ORDER BY rating DESC LIMIT 5;";

        PreparedStatement preparedStmt;
        try {
            conn = dbConnector.createConnection();

            preparedStmt = conn.prepareStatement(getTopFiveMedicaments);
            resultSet = preparedStmt.executeQuery();
            System.out.println("topFiveMedicamentsResultSet = " + resultSet.next());
            resultSet.previous();

            while(resultSet.next()){
                Medicament medicament = new Medicament(resultSet.getString("medicament_name"), resultSet.getString("image_path"), resultSet.getString("rating"));
                medicaments.add(medicament);
            }

            resultSet.close();
            preparedStmt.close();
            conn.close();



        } catch (SQLException e) {
            e.printStackTrace();
        }

        return medicaments;
    }
    public String dailyHealthTips() {

        Connection conn;
        ResultSet resultSet;
        String recipesCount = "SELECT count(tip) AS tipsCount FROM health_tips;";
        String getDailyRecipe= "SELECT tip AS dailyHealthTip FROM health_tips WHERE id = ?;";
        String dailyRecipe="";
        PreparedStatement preparedStmt;
        try {
            conn = dbConnector.createConnection();

            preparedStmt = conn.prepareStatement(recipesCount);
            resultSet = preparedStmt.executeQuery();

            System.out.println("tipsCountResultSet = " + resultSet.next());
            int recipesCountNumber = resultSet.getInt("tipsCount");
            Random rand = new Random();

            int randomRecipeID = rand.nextInt(recipesCountNumber) + 1;
            System.out.println("RandomTipId = " + randomRecipeID);
            preparedStmt = conn.prepareStatement(getDailyRecipe);
            preparedStmt.setInt(1, randomRecipeID);
            resultSet = preparedStmt.executeQuery();
            System.out.println("dailyHealthTipResultSet = " + resultSet.next());

            dailyRecipe = resultSet.getString("dailyHealthTip");

            System.out.println("Daily healthTip (in model) = " + dailyRecipe);
            resultSet.close();
            preparedStmt.close();
            conn.close();


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dailyRecipe;
    }
}
