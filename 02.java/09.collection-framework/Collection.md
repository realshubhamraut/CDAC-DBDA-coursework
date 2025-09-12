# Collection Framework

The collection framework is used to work with a collection of objects. It works with objects only and not on primitive types.

## Container Types

- **List**
- **Set**
- **Map**

A container can contain a group of objects like `Integer` objects, `String` objects, or user-defined class objects (e.g., `Student`, `Employee`).

---

### List

- Implementing classes: `ArrayList`, `LinkedList`
- Maintains insertion order
- Can contain duplicate values
- Can have multiple `null` values
- Indexed-based access is possible

---

### Set

- Does not maintain insertion order
- Cannot contain duplicate values
- Can have at most one `null` value
- Indexed-based access is not possible
- Internally uses `Map`
- Use `LinkedHashSet` to maintain insertion order

---

### Map

- Stores data in key-value form
- Keys cannot be duplicate (only one `null` key allowed)
- Values can be duplicate
- Does not maintain insertion order

> We can use for-each and iterator with List and Set but not with Map, as Map is not a child interface of Iterable.

---

#### Example Program

```java
import java.util.*;

class MapDemo
{
    static void display(Collection<?> c)
    {
        for(Object ob : c)
        {
            System.out.println(ob);
        }
    }

    public static void main(String args[])
    {
        Map<Integer,String> map1 = new HashMap<>();

        map1.put(1,"Mohit");
        map1.put(2,"Aakash");
        map1.put(3,"Mathew");
        map1.put(4,"Geeta");
        map1.put(5,"Ananya");

        String s = map1.get(3);
        System.out.println(s);

        // Iterating map elements
        System.out.println("Iterating map elements using entry set:");
        Set<Map.Entry<Integer,String>> es = map1.entrySet();

        for(Map.Entry<Integer,String> entry: es)
        {
            Integer key = entry.getKey();
            String val = entry.getValue();
            System.out.println(key + " : " + val);
        }
    }
}
