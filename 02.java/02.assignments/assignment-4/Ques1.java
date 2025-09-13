import java.util.*;

public class Ques1 {
    public static void main(String[] args) {
        // 1. Create a new array list, add some Movie names and print out the collection.
        ArrayList<String> movies = new ArrayList<>();
        movies.add("Inception");
        movies.add("Interstellar");
        movies.add("The Matrix");
        movies.add("The Godfather");
        System.out.println("Movies: " + movies);

        // 2. Insert an element at the first position.
        movies.add(0, "Pulp Fiction");
        System.out.println("After inserting at first position: " + movies);

        // 3. Retrieve an element (at a specified index).
        String movieAt2 = movies.get(2);
        System.out.println("Element at index 2: " + movieAt2);

        // 4. Update specific array elements by given element.
        movies.set(1, "The Dark Knight");
        System.out.println("After updating index 1: " + movies);

        // 5. Remove the third element.
        movies.remove(2);
        System.out.println("After removing third element: " + movies);

        // 6. Search for an element.
        String search = "Inception";
        boolean found = movies.contains(search);
        System.out.println("Is '" + search + "' in the list? " + found);

        // 7. Sort the array list.
        Collections.sort(movies);
        System.out.println("Sorted movies: " + movies);

        // 8. Reverse elements in the array list.
        Collections.reverse(movies);
        System.out.println("Reversed movies: " + movies);

        // 9. Empty the array list.
        movies.clear();
        System.out.println("After emptying: " + movies);
    }
}


