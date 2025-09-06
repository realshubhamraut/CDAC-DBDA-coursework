

// 1. Parent class
class Person {
    String name;
    int age;

    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    void display() {
        System.out.println("Name: " + name + ", Age: " + age);
    }

    void work() {
        System.out.println(name + " is doing some work.");
    }
}

// 2. Child class (Single Inheritance + super)
class Student extends Person {
    String course;

    Student(String name, int age, String course) {
        super(name, age); // calling parent constructor
        this.course = course;
    }

    @Override
    void work() {  // Method Overriding
        System.out.println(name + " is studying " + course);
    }
}

// 3. Another child class (Hierarchical Inheritance)
class Teacher extends Person {
    String subject;

    Teacher(String name, int age, String subject) {
        super(name, age);
        this.subject = subject;
    }

    @Override
    void work() {
        System.out.println(name + " is teaching " + subject);
    }
}

// 4. Multilevel Inheritance
class ResearchStudent extends Student {
    String researchTopic;

    ResearchStudent(String name, int age, String course, String researchTopic) {
        super(name, age, course);
        this.researchTopic = researchTopic;
    }

    @Override
    void work() {
        System.out.println(name + " is researching on " + researchTopic);
    }
}

public class InheritanceDemo {
    public static void main(String[] args) {
        Person p = new Person("Aakash", 40);
        p.work();

        Student s = new Student("Nilesh", 20, "Computer Science");
        s.work();

        Teacher t = new Teacher("Ganu", 35, "Mathematics");
        t.work();

        ResearchStudent rs = new ResearchStudent("Pankya", 25, "AI", "Machine Learning");
        rs.work();

        Person ref;
        ref = s;  
        ref.work();  // Calls Student's work()

        ref = t;
        ref.work();  // Calls Teacher's work()
    }
}