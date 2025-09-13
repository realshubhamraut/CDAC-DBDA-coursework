
import java.util.*;

class CollectionMethods {

    static void displayList(List<?> list) {
        for (Object o : list) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        List<String> list1 = new ArrayList<String>();
        List<String> list2 = new ArrayList<String>();
        list1.add("DBDA");
        list1.add("DAC");
        list1.add("DAI");
        list1.add("mmmm");
        list1.add("lll");
        list1.add("DAI");

        System.out.println("List1=== :");
        displayList(list1);
        list2.add("CSE");
        list2.add("IT");
        list2.add("ECE");

        ///tem.out.println("List2=== :");
        //st1.addAll(list2);
        /*stem.out.println("List1+List2======");
        displayList(list1);
        displayList(list1);
        //contains
        boolean b = list1.contains("AAA");
        System.out.println("list1 contains what it returns==" + b);
        //contains all
        b = list1.containsAll(list2);//return false ele not present
        System.out.println("list1.contains[list2]==" + b);//true bcz we add all ele in list1
        //equals
        list1.equals(list2);
        System.out.println("Is list1 == list2 -------" + b);
        //toArray()
        System.err.println("To Array()=====");
        Object[] arr = list2.toArray();
        for (Object s : arr) {
            System.err.println(s);
        }*/
        Collections.sort(list1);
        Collections.shuffle(list1);
        Collections.sort(list1, Collections.reverseOrder());
        displayList(list1);

    }
}
