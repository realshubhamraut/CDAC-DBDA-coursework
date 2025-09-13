
import java.util.*;

class HashMapQue5 {

    public static void main(String[] args) {
        HashMap<Integer, String> map1 = new HashMap<>();
        map1.put(1, "abc");
        map1.put(2, "pqr");
        map1.put(3, "xyz");
        System.out.println("First HashMap === " + map1);
        System.out.println(map1.size());
        HashMap<Integer, String> map2 = new HashMap<>();
        map2.putAll(map1);
        System.out.println("Second HashMap ==== " + map2);
        map2.clear();
        System.out.println("Second HashMap Removed " + map2);
        System.out.println("Contains Key === " + map1.containsKey(2));
        System.out.println("Contains value === " + map1.containsValue("a"));

    }
}
