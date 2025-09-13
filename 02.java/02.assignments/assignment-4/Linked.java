import java.util.*;
public class Linked{
    public static void main(String[] args) {
        LinkedList<String> list = new LinkedList<>(Arrays.asList("A", "B", "C", "D"));
        System.out.println("Initial List: " + list);

        list.add("E");
        System.out.println("1. After appending: " + list);

        int startIndex = 2;
        System.out.print("2. Iterating from index " + startIndex + ": ");
        Iterator<String> itr = list.listIterator(startIndex);
        while (itr.hasNext()) {
            System.out.print(itr.next() + " ");
        }
        System.out.println();

        System.out.print("3. Reverse order: ");
        Iterator<String> revItr = list.descendingIterator();
        while (revItr.hasNext()) {
            System.out.print(revItr.next() + " ");
        }
        System.out.println();

        list.add(2, "X");
        System.out.println("4. After insertion at index 2: " + list);

        list.addFirst("First");
        list.addLast("Last");
        System.out.println("5. After insert first/last: " + list);

        list.offerFirst("Front");
        System.out.println("6. After front insert: " + list);

        List<String> newElements = Arrays.asList("M", "N");
        list.addAll(3, newElements);
        System.out.println("7. After multiple insert at index 3: " + list);

        System.out.println("8. First index of B: " + list.indexOf("B"));
        System.out.println("   Last index of B: " + list.lastIndexOf("B"));

        list.removeFirst();
        list.removeLast();
        System.out.println("9. After removing first/last: " + list);

        Collections.swap(list, 1, 3);
        System.out.println("10. After swapping index 1 and 3: " + list);

        LinkedList<String> list2 = new LinkedList<>(Arrays.asList("P", "Q", "R"));
        list.addAll(list2);
        System.out.println("11. After joining with another list: " + list);

        System.out.println("12. Contains 'C'? " + list.contains("C"));

        ArrayList<String> arrayList = new ArrayList<>(list);
        System.out.println("13. Converted ArrayList: " + arrayList);

        LinkedList<String> list3 = new LinkedList<>(list);
        System.out.println("14. Compare with another same list? " + list.equals(list3));

        System.out.println("15. Is empty? " + list.isEmpty());

        list.set(2, "Replaced");
        System.out.println("16. After replacement at index 2: " + list);
    }
}
