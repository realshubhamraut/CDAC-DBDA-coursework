
import java.util.*;

class MapDemo {

    static void display(Collection<?> map) {
        for (Object o : map) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        //Map<Integer, String> m1 = new HashMap<>();
        Map<Integer, String> m1 = new TreeMap<>();//key based sorting
        //Map<Integer, String> m1 = new LinkedHashMap<>();//orderbase
        //Map<Integer, String> m1 = new Hashtable<>();
        m1.put(4, "DAI");
        m1.put(1, "DAC");
        m1.put(2, "CDAC");
        m1.put(3, "DBDA");
        m1.put(5, "CSE");
        m1.put(6, "IT");
        String s = m1.get(3);
        System.out.println(s);
        //Iterating Map elements
        System.err.println("Interating map ele using entry set----");
        //Set<Map.Entry<Integer, String>> es = m1.entrySet();
        //Set<String>es;///belowl line shouls be like this x
        //   for (Map.Entry<Integer, String> entry : es);
        for (Map.Entry<Integer, String> entry : m1.entrySet()) {
            Integer key = entry.getKey();
            String val = entry.getValue();
            System.out.println(key + ":" + val);
        }
        //m1.put(6, "ECE");override the value only 
    }
}
