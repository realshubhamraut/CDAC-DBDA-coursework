// Write a Java program where a Person class has name and age. Create a subclass
// Student that adds rollNumber and marks.


class Person{
    String name;
    int age;
    Person(String name, int age){
        this.name = name;
        this.age = age;

    }
}

class Student extends Person{
    int rollNumber;
    int marks;
    

        Student(String name, int age, int rollNumber, int marks){
        super(name, age);
        this.rollNumber = rollNumber;
        this.marks = marks;
    }

    public void print(){
        System.out.println("Student details");
        System.out.println("Name: " + this.name + " Age: " + this.age + "Marks: " + this.marks + "and Roll: " + this.rollNumber);

    }
}

public class Ques4 {
    public static void main(String[] args) {
        Student s = new Student("Shubham", 23, 123,98);
        s.print();
    }
    
}



