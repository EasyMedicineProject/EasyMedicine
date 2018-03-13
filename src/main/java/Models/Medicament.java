package Models;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

public class Medicament {
    private String name;
    public String getName(){ return name; }
    private void setName(String name){ this.name = name; }

    private String imagePath;
    public String getImagePath(){return this.imagePath;}
    private void setImagePath(String imagePath){this.imagePath=imagePath;}

    private String description;
    public String getDescription(){ return description; }
    private void setDescription(String description){ this.description = description; }

    private List<String> recipes;
    public List<String> getRecipe(){ return recipes; }
    private void setRecipes(List<String> recipes){ this.recipes = recipes; }

    private List<Commentary> comments;
    public List<Commentary> getComments(){ return comments; }
    private void setComments(List<Commentary> comments){ this.comments = comments; }

    private double averageRating;
    public double getAverageRating(){ return averageRating; }
    private void setAverageRating(double averageRating){ this.averageRating = averageRating; }

    public Medicament(String name,String imagePath,String description, List<String> recipes, List<Commentary> comments, double averageRating){

        this.comments=new ArrayList<>();
        this.recipes=new ArrayList<>();
        setName(name);
        setImagePath(imagePath);
        setDescription(description);
        setRecipes(recipes);
        setComments(comments);
        setAverageRating(averageRating);
    }

    public Medicament(String name,String imagePath,String description, List<String> recipes, List<Commentary> comments){

        this.comments=new ArrayList<>();
        this.recipes=new ArrayList<>();
        setName(name);
        setImagePath(imagePath);
        setDescription(description);
        setRecipes(recipes);
        setComments(comments);
    }

    public Medicament(String name,String imagePath,String description, List<Commentary> comments, double averageRating){

        this.comments=new ArrayList<>();
        setName(name);
        setImagePath(imagePath);
        setDescription(description);
        setComments(comments);
        setAverageRating(averageRating);
    }

    public Medicament(String name,String imagePath,String description, double averageRating){

        setName(name);
        setImagePath(imagePath);
        setDescription(description);
        setAverageRating(averageRating);
    }

    public Medicament(String name,String imagePath,String description, List<Commentary> comments){

        this.comments=new ArrayList<>();
        setName(name);
        setImagePath(imagePath);
        setDescription(description);
        setComments(comments);
    }

    public Medicament(String name,String imagePath,String description){

        setName(name);
        setImagePath(imagePath);
       setDescription(description);
    }

    public Medicament(String name,String imagePath, double averageRating){

        setName(name);
        setImagePath(imagePath);
        setAverageRating(averageRating);
    }

    public Medicament(String name,String description){
        setName(name);
        setDescription(description);
    }

}
