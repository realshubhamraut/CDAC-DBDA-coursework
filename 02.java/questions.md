1. Write a Java program that defines a method which takes a string as a parameter and prints the string concatenated with "Raut". Call this method twice from the main method with different names as arguments. What will be the output?

```java
public class Methods{
    public static void myMethod(String name){
        System.out.println(name + "Raut");
    }
    public static void main(String args[]){
        myMethod("Shubham");
        myMethod("Payal");
    }
}
```

2. do the question 1 but with 2 different arguments as name, middlename

```java
public class Methods {
    public static void myMethod(String firstName, String lastName){
        System.out.println(firstName + " " + lastName);
    }
    public static void main(String args[]){
        myMethod("Shubham", "Raut");
        myMethod("Payal", "Raut");
    }
}
```