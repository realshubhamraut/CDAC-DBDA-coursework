import java.util.*;
class Book{
    public static void main(String args[]){
        ArrayList<String> list1=new ArrayList<String>();
        list1.add("Mohit");
        list1.add("Alice");
        list1.add("Geeta");
        
        System.out.println("Iteratimg List1.....:");

        for(String str:list1){
            System.out.println(str);
        }

        System.out.println("Iteratimg List1 using Iterator.....:");
        Iterator<String> it =list1.iterator();
        while(it.hasNext()){
            String s =it.next();
            System.out.println(s);
        }

        System.out.println("Iteratimg List1 using ListIterator.....:");
        ListIterator<String> lit =list1.listIterator();
        while(lit.hasNext()){
            String s =lit.next();
            System.out.println(s);
        }

        System.out.println("Iteratimg List1 using Enumeration.....:");
        Enumeration<String> em =Collections.enumeration(list1);
        while(em.hasMoreElements()){
            String s =em.nextElement();
            System.out.println(s);
        }
        System.out.println("Iteratimg List1 using For Loop.....:");
        for(int i=0;i<list1.size();i++){
            String s=list1.get(i);
            System.out.println(s);
        }
    }
}

