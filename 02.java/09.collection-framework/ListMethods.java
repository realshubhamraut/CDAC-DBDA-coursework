
import java.util.*;

class ListMethods {

    static void displayList(List<?> list) {
        for (Object o : list) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        ArrayList<String> list1 = new ArrayList<String>();//ArrayList is Generic class
        list1.add("CDAC");
        list1.add("DBDA");
        list1.add("DAI");
        list1.add("VLSI");
        System.out.println("List=== :");
        displayList(list1);
        list1.set(2, "DDD");//updating element at specific index
        list1.set(3, "XYZ");
        System.out.println("List after update=== :");
        displayList(list1);
        System.out.println("Index of a specific value === " + list1.indexOf("DBDA"));
        list1.remove("XYZ");
        System.out.println("Index of a removing value=======");
        displayList(list1);
        //sublist()
        List<String> slist1 = list1.subList(1, 2);
        System.out.println("sublist====");

        displayList(list1);
    }
}
