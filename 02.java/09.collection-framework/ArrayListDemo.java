
import java.util.*;

class ArrayListDemo {

    public static void main(String[] args) {
        ArrayList<String> list1 = new ArrayList<String>();//ArrayList is Generic class
        list1.add("CDAC");
        list1.add("DBDA");
        list1.add("DAI");
        list1.add("VLSI");
        list1.add("DDD");
        list1.add("DAC");
        list1.add("XYZ");
        System.out.println("Iterating List1 ele using for-each loop :");
        //for each iteration
        for (String s : list1) {
            System.out.println(s);
        }
        //Iterator 
        System.out.println("Iterating List1 ele using Iterator :");
        Iterator<String> i = list1.iterator();
        while (i.hasNext()) {
            String s = i.next();
            System.out.println(s);
        }
        //Enumeration
        System.out.println("Iterating List1 ele using Enumeration :");
        Enumeration<String> em = Collections.enumeration(list1);
        while (em.hasMoreElements()) {
            String s = em.nextElement();
            System.out.println(s);
        }
        //Iterating using size(),get()
        System.out.println(list1.size());
        System.out.println("Iterating List1 using conventional for loop");
        for (int j = 0; j < 4; j++) {
            String s = list1.get(j);
            System.out.println(s);
        }
        //System.out.println(list1);
    }
}
