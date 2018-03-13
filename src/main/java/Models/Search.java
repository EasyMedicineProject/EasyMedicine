package Models;

import Utils.dbConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Search {

    public List<Medicament> searchHerbs (String keyword){

        Connection conn;
        ResultSet resultSetFromSymptomsSearch;
        ResultSet resultSetFromDiseasesSearch;
        ResultSet medicamentsResultSet;
        ResultSet averageRatingResultSet;
        ResultSet recipesResultSet;
        ResultSet commentsResultSet;
        List<Medicament> medicaments=new ArrayList<>();
        //Map<String, String> medicaments = new HashMap<>();
        String searchDiseasesQuery = "SELECT  LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments, diseases, medicaments_diseases WHERE diseases.id = medicaments_diseases.disease_id AND medicaments.id = medicaments_diseases.medicament_id AND diseases.name =? AND medicaments.`type` = 'herb'";
        String searchSymptomsQuery = "SELECT LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments, symptoms, medicaments_symptoms WHERE symptoms.id = medicaments_symptoms.symptom_id AND medicaments.id = medicaments_symptoms.medicament_id AND symptoms.name = ? AND medicaments.`type` = 'herb'";
        String searchMedicamentQuery="SELECT LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments WHERE medicaments.name=? AND medicaments.`type` = 'herb'";
        String searchCommentsQuery = "SELECT username, `comment` FROM users_medicaments_comments WHERE medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1);";
        String averageRatingQuery = "SELECT FORMAT(AVG(rating_value), 1) AS avg_rating  FROM users_medicaments_ratings  WHERE medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1) GROUP BY medicament_id ";
        String recipesQuery = "SELECT  LOWER(recipes.recipe) AS recipe FROM recipes, medicaments, medicaments_recipes WHERE recipes.id = medicaments_recipes.recipe_id AND medicaments.id = medicaments_recipes.medicament_id AND medicaments.`type` = 'herb' AND medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1);";

        PreparedStatement preparedStmt;
        try{
            conn = dbConnector.createConnection();

            preparedStmt = conn.prepareStatement(searchSymptomsQuery);
            preparedStmt.setString(1, keyword);
            resultSetFromSymptomsSearch= preparedStmt.executeQuery();


            preparedStmt = conn.prepareStatement(searchDiseasesQuery);
            preparedStmt.setString(1, keyword);
            resultSetFromDiseasesSearch = preparedStmt.executeQuery();


            preparedStmt = conn.prepareStatement(searchMedicamentQuery);
            preparedStmt.setString(1, keyword);
            medicamentsResultSet = preparedStmt.executeQuery();


            if(resultSetFromSymptomsSearch.next()){
               resultSetFromSymptomsSearch.previous();
               while(resultSetFromSymptomsSearch.next()) {

                   preparedStmt = conn.prepareStatement(searchCommentsQuery);
                   preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                   commentsResultSet = preparedStmt.executeQuery();

                   List<Commentary> comments = new ArrayList<>();
                   while(commentsResultSet.next()){
                       Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                       comments.add(currentComment);
                       System.out.println("Search model: Current comment (commentValue) = " + commentsResultSet.getString("comment"));
                       System.out.println("Search model: Current comment (username) = " + commentsResultSet.getString("username"));
                   }


                   preparedStmt = conn.prepareStatement(averageRatingQuery);
                   preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                   averageRatingResultSet = preparedStmt.executeQuery();

                   preparedStmt = conn.prepareStatement(recipesQuery);
                   System.out.println("1 symptoms medicamentName = " + resultSetFromSymptomsSearch.getString("name"));
                   preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                   recipesResultSet = preparedStmt.executeQuery();
                   List<String> recipes=new ArrayList<>();

                   while(recipesResultSet.next()){

                       recipes.add(recipesResultSet.getString("recipe"));
                   }

                   Medicament currentMedicament;
                   //System.out.println("Avg rating = " + String.valueOf(averageRatingResultSet.getDouble("avg_rating")));
                   if(averageRatingResultSet.next()){
                       currentMedicament=new Medicament(resultSetFromSymptomsSearch.getString("name"),resultSetFromSymptomsSearch.getString("imagePath"),resultSetFromSymptomsSearch.getString("description"), recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                    }
                   else {
                       currentMedicament=new Medicament(resultSetFromSymptomsSearch.getString("name"),resultSetFromSymptomsSearch.getString("imagePath"),resultSetFromSymptomsSearch.getString("description"), recipes ,comments);
                   }
                   medicaments.add(currentMedicament);
                   System.out.println(resultSetFromSymptomsSearch.getString("name"));
                   System.out.println(resultSetFromSymptomsSearch.getString("description"));
               }
               return medicaments;
           }
           else if(resultSetFromDiseasesSearch.next()){
               resultSetFromDiseasesSearch.previous();
               while(resultSetFromDiseasesSearch.next()) {

                   preparedStmt = conn.prepareStatement(searchCommentsQuery);
                   preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                   commentsResultSet = preparedStmt.executeQuery();

                   List<Commentary> comments = new ArrayList<>();
                   while(commentsResultSet.next()){
                       Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                       comments.add(currentComment);
                       System.out.println("Search model: Current comment (commentValue) = " + commentsResultSet.getString("comment"));
                       System.out.println("Search model: Current comment (username) = " + commentsResultSet.getString("username"));
                   }

                   preparedStmt = conn.prepareStatement(averageRatingQuery);
                   preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                   averageRatingResultSet = preparedStmt.executeQuery();

                   preparedStmt = conn.prepareStatement(recipesQuery);
                   System.out.println("2 diseases medicamentName = " + resultSetFromDiseasesSearch.getString("name"));
                   preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                   recipesResultSet = preparedStmt.executeQuery();
                   List<String> recipes=new ArrayList<>();

                   while(recipesResultSet.next()){

                       recipes.add(recipesResultSet.getString("recipe"));
                   }

                   Medicament currentMedicament;
                   if(averageRatingResultSet.next()){
                       System.out.println("v ifa sum za bolest");
                       System.out.println("Avg rating = " + averageRatingResultSet.getDouble("avg_rating"));
                       recipesResultSet.next();
                       currentMedicament=new Medicament(resultSetFromDiseasesSearch.getString("name"),resultSetFromDiseasesSearch.getString("imagePath"),resultSetFromDiseasesSearch.getString("description"),recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                   }
                   else {
                       currentMedicament=new Medicament(resultSetFromDiseasesSearch.getString("name"),resultSetFromDiseasesSearch.getString("imagePath"),resultSetFromDiseasesSearch.getString("description"),recipes, comments);
                   }
                   medicaments.add(currentMedicament);
                   System.out.println(resultSetFromDiseasesSearch.getString("name"));
                   System.out.println(resultSetFromDiseasesSearch.getString("description"));
               }
               return medicaments;
           }
           else if(medicamentsResultSet.next()){
               medicamentsResultSet.previous();
               System.out.println("Search model: searching medicaments (else if)");
               while(medicamentsResultSet.next()) {

                   preparedStmt = conn.prepareStatement(searchCommentsQuery);
                   preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                   commentsResultSet = preparedStmt.executeQuery();

                   List<Commentary> comments = new ArrayList<>();
                   while(commentsResultSet.next()){
                       Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                       comments.add(currentComment);
                   }


                   preparedStmt = conn.prepareStatement(averageRatingQuery);
                   preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                   averageRatingResultSet = preparedStmt.executeQuery();

                   preparedStmt = conn.prepareStatement(recipesQuery);
                   System.out.println("3 medicaments medicamentName = " + medicamentsResultSet.getString("name"));

                   preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                   recipesResultSet = preparedStmt.executeQuery();
                   List<String> recipes=new ArrayList<>();

                   while(recipesResultSet.next()){

                       recipes.add(recipesResultSet.getString("recipe"));
                   }

                   Medicament currentMedicament;
                   System.out.println(medicamentsResultSet.getString("name"));
                   if(averageRatingResultSet.next()){
                       currentMedicament=new Medicament(medicamentsResultSet.getString("name"),medicamentsResultSet.getString("imagePath"),medicamentsResultSet.getString("description"),recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                   }
                   else {
                       currentMedicament=new Medicament(medicamentsResultSet.getString("name"),medicamentsResultSet.getString("imagePath"),medicamentsResultSet.getString("description"),recipes, comments);
                   }
                   medicaments.add(currentMedicament);
                   System.out.println(medicamentsResultSet.getString("name"));
                   System.out.println(medicamentsResultSet.getString("description"));
               }
               return medicaments;
           }
           else{
                preparedStmt = conn.prepareStatement(averageRatingQuery);
                preparedStmt.setString(1, "");
                averageRatingResultSet = preparedStmt.executeQuery();
                preparedStmt = conn.prepareStatement(recipesQuery);
                System.out.println("4 empty medicamentName");
                preparedStmt.setString(1, "");
                recipesResultSet = preparedStmt.executeQuery();
                Medicament currentMedicament=new Medicament("Няма намерени резултати","опитайте отново");
                medicaments.add(currentMedicament);
           }

            resultSetFromSymptomsSearch.close();
            resultSetFromDiseasesSearch.close();
            medicamentsResultSet.close();
            averageRatingResultSet.close();
            recipesResultSet.close();
            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return medicaments;
    }

    public List<Medicament> searchMedicaments (String keyword){

        Connection conn;
        ResultSet resultSetFromSymptomsSearch;
        ResultSet resultSetFromDiseasesSearch;
        ResultSet medicamentsResultSet;
        ResultSet averageRatingResultSet;
        ResultSet recipesResultSet;
        ResultSet commentsResultSet;
        List<Medicament> medicaments=new ArrayList<>();
        //Map<String, String> medicaments = new HashMap<>();
        String searchDiseasesQuery = "SELECT  LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments, diseases, medicaments_diseases WHERE diseases.id = medicaments_diseases.disease_id AND medicaments.id = medicaments_diseases.medicament_id AND diseases.name =? AND medicaments.`type` = 'medicament'";
        String searchSymptomsQuery = "SELECT LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments, symptoms, medicaments_symptoms WHERE symptoms.id = medicaments_symptoms.symptom_id AND medicaments.id = medicaments_symptoms.medicament_id AND symptoms.name = ? AND medicaments.`type` = 'medicament'";
        String searchMedicamentQuery="SELECT LOWER(medicaments.name) AS name, LOWER(medicaments.description) AS description, medicaments.imagePath AS imagePath FROM medicaments WHERE medicaments.name=? AND medicaments.`type` = 'medicament'";
        String searchCommentsQuery = "SELECT username, `comment` FROM users_medicaments_comments WHERE medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1);";
        String averageRatingQuery = "SELECT FORMAT(AVG(rating_value), 1) AS avg_rating  FROM users_medicaments_ratings  WHERE medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1) GROUP BY medicament_id ";
        String recipesQuery = "SELECT  LOWER(recipes.recipe) AS recipe FROM recipes, medicaments, medicaments_recipes WHERE recipes.id = medicaments_recipes.recipe_id AND medicaments.id = medicaments_recipes.medicament_id AND medicaments.`type` = 'medicament' AND medicament_id=(SELECT id FROM medicaments WHERE name=? LIMIT 1);";

        PreparedStatement preparedStmt;
        try{
            conn = dbConnector.createConnection();

            preparedStmt = conn.prepareStatement(searchSymptomsQuery);
            preparedStmt.setString(1, keyword);
            resultSetFromSymptomsSearch= preparedStmt.executeQuery();
            System.out.println("resultSetFromSymptomsSearch = " + resultSetFromSymptomsSearch.next());
            resultSetFromSymptomsSearch.previous();


            preparedStmt = conn.prepareStatement(searchDiseasesQuery);
            preparedStmt.setString(1, keyword);
            resultSetFromDiseasesSearch = preparedStmt.executeQuery();
            System.out.println("resultSetFromDiseasesSearch = " + resultSetFromDiseasesSearch.next());
            resultSetFromDiseasesSearch.previous();

            preparedStmt = conn.prepareStatement(searchMedicamentQuery);
            preparedStmt.setString(1, keyword);
            medicamentsResultSet = preparedStmt.executeQuery();
            System.out.println("medicamentsResultSet = " + medicamentsResultSet.next());
            medicamentsResultSet.previous();

            if(resultSetFromSymptomsSearch.next()){
                resultSetFromSymptomsSearch.previous();
                while(resultSetFromSymptomsSearch.next()) {

                    preparedStmt = conn.prepareStatement(searchCommentsQuery);
                    preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                    commentsResultSet = preparedStmt.executeQuery();

                    List<Commentary> comments = new ArrayList<>();
                    while(commentsResultSet.next()){
                        Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                        comments.add(currentComment);
                        System.out.println("Search model: Current comment (commentValue) = " + commentsResultSet.getString("comment"));
                        System.out.println("Search model: Current comment (username) = " + commentsResultSet.getString("username"));
                    }


                    preparedStmt = conn.prepareStatement(averageRatingQuery);
                    preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                    averageRatingResultSet = preparedStmt.executeQuery();

                    preparedStmt = conn.prepareStatement(recipesQuery);
                    System.out.println("5 symptoms medicamentName = " + resultSetFromSymptomsSearch.getString("name"));
                    preparedStmt.setString(1, resultSetFromSymptomsSearch.getString("name"));
                    recipesResultSet = preparedStmt.executeQuery();
                    List<String> recipes=new ArrayList<>();

                    while(recipesResultSet.next()){

                        recipes.add(recipesResultSet.getString("recipe"));
                    }

                    Medicament currentMedicament;
                    //System.out.println("Avg rating = " + String.valueOf(averageRatingResultSet.getDouble("avg_rating")));
                    if(averageRatingResultSet.next()){
                        currentMedicament=new Medicament(resultSetFromSymptomsSearch.getString("name"),resultSetFromSymptomsSearch.getString("imagePath"),resultSetFromSymptomsSearch.getString("description"), recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                    }
                    else {
                        currentMedicament=new Medicament(resultSetFromSymptomsSearch.getString("name"),resultSetFromSymptomsSearch.getString("imagePath"),resultSetFromSymptomsSearch.getString("description"), recipes ,comments);
                    }
                    medicaments.add(currentMedicament);
                    System.out.println(resultSetFromSymptomsSearch.getString("name"));
                    System.out.println(resultSetFromSymptomsSearch.getString("description"));
                }
                return medicaments;
            }
            else if(resultSetFromDiseasesSearch.next()){
                resultSetFromDiseasesSearch.previous();
                while(resultSetFromDiseasesSearch.next()) {

                    preparedStmt = conn.prepareStatement(searchCommentsQuery);
                    preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                    commentsResultSet = preparedStmt.executeQuery();

                    List<Commentary> comments = new ArrayList<>();
                    while(commentsResultSet.next()){
                        Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                        comments.add(currentComment);
                        System.out.println("Search model: Current comment (commentValue) = " + commentsResultSet.getString("comment"));
                        System.out.println("Search model: Current comment (username) = " + commentsResultSet.getString("username"));
                    }

                    preparedStmt = conn.prepareStatement(averageRatingQuery);
                    preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                    averageRatingResultSet = preparedStmt.executeQuery();

                    preparedStmt = conn.prepareStatement(recipesQuery);
                    System.out.println("6 diseases medicamentName = " + resultSetFromDiseasesSearch.getString("name"));
                    preparedStmt.setString(1, resultSetFromDiseasesSearch.getString("name"));
                    recipesResultSet = preparedStmt.executeQuery();
                    List<String> recipes=new ArrayList<>();

                    while(recipesResultSet.next()){

                        recipes.add(recipesResultSet.getString("recipe"));
                    }

                    Medicament currentMedicament;
                    if(averageRatingResultSet.next()){
                        System.out.println("v ifa sum za bolest");
                        System.out.println("Avg rating = " + averageRatingResultSet.getDouble("avg_rating"));
                        recipesResultSet.next();
                        currentMedicament=new Medicament(resultSetFromDiseasesSearch.getString("name"),resultSetFromDiseasesSearch.getString("imagePath"),resultSetFromDiseasesSearch.getString("description"),recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                    }
                    else {
                        currentMedicament=new Medicament(resultSetFromDiseasesSearch.getString("name"),resultSetFromDiseasesSearch.getString("imagePath"),resultSetFromDiseasesSearch.getString("description"),recipes, comments);
                    }
                    medicaments.add(currentMedicament);
                    System.out.println(resultSetFromDiseasesSearch.getString("name"));
                    System.out.println(resultSetFromDiseasesSearch.getString("description"));
                }
                return medicaments;
            }
            else if(medicamentsResultSet.next()){
                medicamentsResultSet.previous();
                System.out.println("Search model: searching medicaments (else if)");
                while(medicamentsResultSet.next()) {

                    preparedStmt = conn.prepareStatement(searchCommentsQuery);
                    preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                    commentsResultSet = preparedStmt.executeQuery();

                    List<Commentary> comments = new ArrayList<>();
                    while(commentsResultSet.next()){
                        Commentary currentComment=new Commentary(commentsResultSet.getString("comment"),commentsResultSet.getString("username"));
                        comments.add(currentComment);
                    }


                    preparedStmt = conn.prepareStatement(averageRatingQuery);
                    preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                    averageRatingResultSet = preparedStmt.executeQuery();

                    preparedStmt = conn.prepareStatement(recipesQuery);
                    System.out.println("7 medicaments medicamentName = " + medicamentsResultSet.getString("name"));
                    preparedStmt.setString(1, medicamentsResultSet.getString("name"));
                    recipesResultSet = preparedStmt.executeQuery();
                    List<String> recipes=new ArrayList<>();

                    while(recipesResultSet.next()){
                        recipes.add(recipesResultSet.getString("recipe"));
                    }

                    Medicament currentMedicament;
                    System.out.println("Medicament search: medicament name = " + medicamentsResultSet.getString("name"));
                    System.out.println("Medicament search: averageRatingResultSet = " + averageRatingResultSet.next());
                    averageRatingResultSet.previous();
                    if(averageRatingResultSet.next()){
                        currentMedicament=new Medicament(medicamentsResultSet.getString("name"),medicamentsResultSet.getString("imagePath"),medicamentsResultSet.getString("description"),recipes, comments, averageRatingResultSet.getDouble("avg_rating"));
                    }
                    else {
                        currentMedicament=new Medicament(medicamentsResultSet.getString("name"),medicamentsResultSet.getString("imagePath"),medicamentsResultSet.getString("description"),recipes, comments);
                    }
                    medicaments.add(currentMedicament);
                    System.out.println(medicamentsResultSet.getString("name"));
                    System.out.println(medicamentsResultSet.getString("description"));
                }
                return medicaments;
            }
            else{
                preparedStmt = conn.prepareStatement(averageRatingQuery);
                preparedStmt.setString(1, "");
                averageRatingResultSet = preparedStmt.executeQuery();
                preparedStmt = conn.prepareStatement(recipesQuery);
                System.out.println("8 medicaments medicamentName = empty");
                preparedStmt.setString(1, "");
                recipesResultSet = preparedStmt.executeQuery();
                Medicament currentMedicament=new Medicament("Няма намерени резултати","опитайте отново");
                medicaments.add(currentMedicament);
            }

            resultSetFromSymptomsSearch.close();
            resultSetFromDiseasesSearch.close();
            medicamentsResultSet.close();
            averageRatingResultSet.close();
            recipesResultSet.close();
            preparedStmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return medicaments;
    }

    public List<String> usedMedicaments (String username) throws SQLException {

        Connection conn = dbConnector.createConnection();
        ResultSet usedMedicamentsResultSet;
        String usedMedicaments="SELECT medicaments_use FROM users WHERE username=? or email=?";

        PreparedStatement preparedStmt = conn.prepareStatement(usedMedicaments);
        preparedStmt.setString(1, username);
        preparedStmt.setString(2, username);
        usedMedicamentsResultSet= preparedStmt.executeQuery();

        usedMedicamentsResultSet.next();

        List<String> usedMedicament= new ArrayList<String>();
        if(usedMedicamentsResultSet.getString("medicaments_use")!=null) {
            usedMedicament = Arrays.asList(usedMedicamentsResultSet.getString("medicaments_use").split(","));
        }
        return usedMedicament;

    }

}
