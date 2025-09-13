class Person {
    String name;
    int age;

    Person(String name, int age) {
        this.name = name;
        this.age = age;
        System.out.println("Person constructor: Name = " + name + ", Age = " + age);
    }
}

class Student1 extends Person {
    String course;

    Student1(String name, int age, String course) {
        super(name, age); // Calls Person constructor
        this.course = course;
        System.out.println("Student constructor: Course = " + course);
    }
}

public class Ques2a {
    public static void main(String[] args) {
        Student1 s = new Student1("Alice", 20, "Computer Science");
    }
}