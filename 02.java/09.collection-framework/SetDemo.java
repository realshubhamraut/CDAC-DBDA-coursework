
import java.util.*;

class SetDemo {

    static void display(Collection<?> set) {
        for (Object o : set) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        Set<String> set1 = new HashSet<String>();
        Set<String> set2 = new HashSet<String>();
        set1.add("DBDA");
        set1.add("DAC");
        set1.add("DAI");
        System.out.println("Set1=== :");
        display(set1);
        set2.add("CSE");
        set2.add("IT");
        set2.add("ECE");
        System.out.println("=Set2=== :");
        set1.addAll(set2);
        System.out.println("Set1+Set2======");
        display(set1);
        display(set1);
        //contains
        boolean b = set1.contains("AAA");
        System.out.println("set1 contains what it returns==" + b);
        //contains all
        b = set1.containsAll(set2);//return false ele not present
        System.out.println("set1.contains[set2]==" + b);//true bcz we add all ele in list1
        //equals
        set1.equals(set2);
        System.out.println("Is set1 == set2 -------" + b);
        Set<String> set3 = new HashSet<String>();
        set3.add("CSE");
        set3.add("IT");
        set3.add("ECE");
        set3.add("PPP");
        display(set3);
    }
}
