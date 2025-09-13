/*1. Write a Java program to create a new tree set, add some fruits (string) and print out the tree set. 
-Write a Java program to iterate through all elements in a tree set. 
-Write a Java program to add all the elements of a specified tree set to another tree set. 
-Write a Java program to create a reverse order view of the elements contained in a given tree set. 
-Write a Java program to find the numbers less than 7 in a tree set. 
 */
import java.util.*;

class TreeSetQue4 {

    static void display(Collection<?> fruits) {
        System.out.println(fruits);
    }

    public static void main(String[] args) {
        TreeSet<String> fruits = new TreeSet<>();
        fruits.add("Apple");
        fruits.add("Pear");
        fruits.add("Mango");
        fruits.add("orange");
        fruits.add("Grapes");
        fruits.add("Chiku");
        System.out.println("Fruits TreeSet == ");
        display(fruits);
        TreeSet<String> fruitlist = new TreeSet<>();
        fruits.addAll(fruitlist);
        System.out.println("New Fruits TreeSet == ");
        display(fruits);
        NavigableSet<String> rev = fruits.descendingSet();
        System.out.println("Reverse == " + rev);
        TreeSet<Integer> nums = new TreeSet<>();
        System.out.println("Numbers Treeset == ");
        nums.addAll(Arrays.asList(1, 2, 3, 6, 8, 9, 7, 10, 11));
        display(nums);
        System.out.println("nums < 7 ==");
        SortedSet<Integer> num = nums.headSet(7);
        display(num);
    }
}
