//3. constructor chaining

public class Student1 {
    String name;
    int age;
    boolean gender;

    // 1. No-argument constructor
    Student1() {
        this("Unknown", 0, false); // Calls the main constructor
    }

    // 2. Constructor with name and age
    Student1(String name, int age) {
        this(name, age, false); // Calls the main constructor
    }

    // 3. Main constructor with all fields
    Student1(String name, int age, boolean gender) {
        this.name = name;
        this.age = age;
        this.gender = gender;
    }

}
