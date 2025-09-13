import java.util.*;
public class hashset{
    public static void main(String[] args) {
        HashSet<String> hs = new HashSet<>();
        hs.add("101-Ayushi");
        hs.add("102-Riya");
        hs.add("103-Sam");
        hs.add("104-Neha");

        System.out.println("Employees HashSet: " + hs);

        System.out.println("Elements count: " + hs.size());

        String[] empArray = hs.toArray(new String[0]);
        System.out.println("Converted to Array: " + Arrays.toString(empArray));

        Set<String> hashSetToTreeSet = new TreeSet<>(hs);
        System.out.println("hashset to treeset"+ hashSetToTreeSet);

        List<String> arrayList = new ArrayList<>(hs);
        System.out.println("HashSet converted to ArrayList: " + arrayList);

        hs.clear();
        System.out.println("HashSet remove all : " + hs);
    }
}
