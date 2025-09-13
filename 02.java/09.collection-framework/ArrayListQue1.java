
import java.util.*;

class ArrayListQue1 {

    static void displayList(List<?> list) {
        for (Object o : list) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        ArrayList<String> movie = new ArrayList<String>();
        movie.add("Aaa");
        movie.add("Bbb");
        movie.add("Ccc");
        movie.add("Ddd");
        movie.add("Eee");
        movie.add("Fff");
        movie.add(0, "Ggg");
        System.out.println("insert an element into the array list at the first -position :");
        displayList(movie);
        System.out.println("retrieve an ele at 4th index = ");
        System.out.println(movie.get(4));
        movie.set(4, "Ttt");
        System.out.println("updated list =");
        displayList(movie);
        System.err.println("removed the third element =" + movie.remove(3));
        System.out.println("search for an element =");
        Collections.sort(movie);
        System.out.println("list after sorting = ");
        displayList(movie);
        Collections.reverse(movie);
        System.out.println("Reverse list = ");
        displayList(movie);
        boolean b = movie.isEmpty();
        System.out.println("Empty list = " + b);
    }
}
