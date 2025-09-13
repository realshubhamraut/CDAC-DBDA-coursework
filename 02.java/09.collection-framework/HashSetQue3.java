/*1. Write a Java program to append the specified element to the end of a hash set for Employee Id and 
Employee name. 
-Write a Java program to get the number of elements in a hash set. 
-Write a Java program to convert a hash set to an array. 
-Write a Java program to convert a hash set to a tree set. 
-Write a Java program to convert a hash set to a List/ArrayList. 
-Write a Java program to remove all of the elements from a hash set. 
 */
import java.util.*;

class HashSetQue3 {

    static void display(Collection<?> set, String title) {
        System.out.println(set);
    }

    public static void main(String[] args) {
        System.out.println("elements of HashSets =");
        Set<Integer> employeeId = new HashSet<Integer>();
        Set<String> employeeName = new HashSet<String>();
        employeeId.add(101);
        employeeId.add(102);
        employeeId.add(103);
        employeeName.add("Abb");
        employeeName.add("Ccc");
        employeeName.add("Bbb");
        System.out.println("Employee IDs: " + employeeId);
        System.out.println("Employee Names: " + employeeName);
        employeeId.add(104);
        employeeName.add("Ddd");
        System.out.println("appending 104 Employee IDs: " + employeeId);
        System.out.println("appending Ddd Employee Names: " + employeeName);
        System.out.println("number of Employee IDs: " + employeeId.size());
        System.out.println("number of Employee Names: " + employeeName.size());
        System.out.println("HashSet to an ArrayList =");
        Integer[] idArray = employeeId.toArray(new Integer[0]);
        String[] nameArray = employeeName.toArray(new String[0]);
        System.out.println("Employee ID array: " + Arrays.toString(idArray));
        System.out.println("Employee Name array: " + Arrays.toString(nameArray));
        System.out.println("HashSet to TreeSet");
        Set<Integer> treeSetIds = new TreeSet<>(employeeId);
        Set<String> treeSetNames = new TreeSet<>(employeeName);
        display(treeSetIds, "TreeSet of EmployeeID)");
        display(treeSetNames, "TreeSet of EmployeeName");
        System.out.println("HashSet to ArrayList =");
        List<Integer> arrListid = new ArrayList<>(employeeId);
        List<String> arrListname = new ArrayList<>(employeeName);
        display(arrListid, "ArrayList of EmployeeID");
        display(arrListname, "ArrayList of EmployeeNames =");
        System.out.println("Removeall ele");
        employeeId.clear();
        System.out.println("EmployeeID after clear =" + employeeId);
        System.out.println("employeeId set empty=" + employeeId.isEmpty());
    }
}
