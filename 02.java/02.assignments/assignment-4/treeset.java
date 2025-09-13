import java.util.*;
public class treeset {

    public static void main(String[] args) {
        TreeSet<String> fruits = new TreeSet<>();

        fruits.add("banana");
        fruits.add("Mango");
        fruits.add("apple");
        fruits.add("grapes");

        System.out.println("Fruits : " + fruits);

        Iterator<String> itr = fruits.iterator();
        while(itr.hasNext()){
            System.out.println(itr.next()+" ");
        }
        System.out.println();

        TreeSet<String> fruits2 = new TreeSet<>(Arrays.asList("Papaya", "Kiwi", "Strawberry", "Pear", "Peach"));
        fruits.addAll(fruits2);
        System.out.println(fruits);

        Iterator<String> itr2 = fruits.descendingIterator();
         System.out.println("fruits in descending order : ");
        while(itr2.hasNext()){
            System.out.println(itr2.next()+ "");  
              }
              TreeSet<Integer> numbers = new TreeSet<>();
numbers.add(1);
numbers.add(3);
numbers.add(5);
numbers.add(7);
numbers.add(9);
numbers.add(11);
TreeSet<Integer> lessThan7 = new TreeSet<>(numbers.headSet(7));
System.out.println("Numbers less than 7: " + lessThan7);

    }
    
}
