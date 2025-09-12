import java.util.ArrayList;

public class Ques1 {
    public static void main(String[] args) {
        // Create a new ArrayList to store movie names
        ArrayList<String> movies = new ArrayList<>();

        // Add some movie names
        movies.add("Inception");
        movies.add("The Matrix");
        movies.add("Interstellar");
        movies.add("The Dark Knight");

        // Print the collection
        System.out.println("Movie list: " + movies);

        // Insert a movie at the first position (index 0)
        movies.add(0, "Shawshank Redemption");

        // Print the updated collection
        System.out.println("After inserting at first position: " + movies);
    }
}
