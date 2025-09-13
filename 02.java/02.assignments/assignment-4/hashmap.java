import  java.util.*;
public class hashmap {
    public static void main(String[] args) {
 
        HashMap<Integer, String> map = new HashMap<Integer, String>();

        map.put(101, "Alice");
        map.put(102, "Bob");
        map.put(103, "Charlie");
        System.out.println("Initial HashMap: " + map);

        System.out.println("Size of map: " + map.size());

        HashMap<Integer, String> anotherMap = new HashMap<>();
        anotherMap.putAll(map);
        System.out.println("Copied HashMap: " + anotherMap);

        map.clear();
        System.out.println("After clearing, original map: " + map);

        System.out.println("Does copied map contain key 101? " + anotherMap.containsKey(101));
        System.out.println("Does copied map contain key 200? " + anotherMap.containsKey(200));

        System.out.println("Does copied map contain value 'Alice'? " + anotherMap.containsValue("Alice"));
        System.out.println("Does copied map contain value 'David'? " + anotherMap.containsValue("David"));
    }
}
