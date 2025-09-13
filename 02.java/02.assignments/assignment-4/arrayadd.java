import java.util.*;
public class arrayadd {
    public static void main(String[] args) {

        ArrayList<String> movies = new ArrayList<>();

        movies.add("The Shawshank Redemption");
        movies.add("Inception");
        movies.add("The Dark Knight");
        movies.add("Forrest Gump");
        movies.add("Pulp Fiction");

        System.out.println("Original movie list:");
        printList(movies);

        movies.add(0, "The Lord of the Rings");
        System.out.println("\nAfter inserting at first position:");
        printList(movies);

        String retrieved = movies.get(3);
        System.out.println("\nElement at index 3: " + retrieved);

        movies.set(2, "Interstellar");
        System.out.println("\nAfter updating element at index 2:");
        printList(movies);

        movies.remove(2);
        System.out.println("\nAfter removing the third element:");
        printList(movies);

        String searchMovie = "Inception";
        if (movies.contains(searchMovie)) {
            System.out.println("\n'" + searchMovie + "' is present in the list.");
        } else {
            System.out.println("\n'" + searchMovie + "' is not found in the list.");
        }

        Collections.sort(movies);
        System.out.println("\nAfter sorting:");
        printList(movies);

        Collections.reverse(movies);
        System.out.println("\nAfter reversing:");
        printList(movies);

        movies.clear();
        System.out.println("\nAfter emptying the list: Size = " + movies.size());
    }

    public static void printList(ArrayList<String> list) {
        for (String item : list) {
            System.out.println(item);
        }
    }
}

