
import java.util.*;

public class LinkedListQue2 {

    public static void main(String[] args) {
        LinkedList<String> list1 = new LinkedList<>();
        list1.add("A");
        list1.add("B");
        list1.add("A");
        list1.add("C");
        System.out.println("list1 = " + list1);
        System.out.println("Iterating from position 1:");
        Iterator<String> it = list1.listIterator(1);
        while (it.hasNext()) {
            System.out.println(it.next());
        }
        System.out.println("reverse order iteration =");
        Iterator<String> revlist = list1.descendingIterator();
        while (revlist.hasNext()) {
            System.out.println(revlist.next());
        }
        list1.add(1, "Aaa");
        System.out.println("Inserted ele at position 1 = " + list1);
        list1.addFirst("K");
        list1.addLast("F");
        System.out.println("Inserted ele at first , at last = " + list1);
        list1.offerFirst("G");
        System.out.println(" Inserted G at front: " + list1);
        List<String> list2 = new ArrayList<>();
        list2.add("H");
        list2.add("I");
        list1.addAll(3, list2);
        System.out.println("Inserted new list at position 3 = " + list1);
        System.out.println("First ele = " + list1.getFirst());
        System.out.println("Last ele = " + list1.getLast());
        list1.add("M");
        System.out.println("First occurrence of 'A' = " + list1.indexOf("A"));
        System.out.println("Last occurrence of 'A' = " + list1.lastIndexOf("A"));
        list1.removeLast();
        list1.removeFirst();
        list1.removeLast();
        System.out.println("Removed first and last ele = " + list1);
        System.out.println("Swapping ele at indices 1 and 3...");
        Collections.swap(list1, 1, 3);
        System.out.println("List after swap= " + list1);
        LinkedList<String> list3 = new LinkedList<>();
        list3.add("O");
        list3.add("N");
        list1.addAll(list3);
        System.out.println("Joined lists = " + list1);
        System.out.println("Is 'D' in the list? " + list1.contains("D"));
        System.out.println("Is 'V' in the list? " + list1.contains("V"));
        ArrayList<String> arrayList = new ArrayList<>(list1);
        System.out.println("Converted to ArrayList = " + arrayList);
        LinkedList<String> listToCompare = new LinkedList<>();
        listToCompare.add("D");
        listToCompare.add("B");
        listToCompare.add("C");
        listToCompare.add("H");
        listToCompare.add("I");
        System.out.println("lists equal = " + list1.equals(listToCompare));
        System.out.println("list empty = " + list1.isEmpty());
        LinkedList<String> emptyList = new LinkedList<>();
        System.out.println("Is the empty list empty = " + emptyList.isEmpty());
        list1.set(1, "L");
        System.out.println("Replaced element at index 1 with 'L': " + list1);
    }
}
