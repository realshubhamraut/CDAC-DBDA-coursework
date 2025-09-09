
// Human class with a constructor and some methods
public class Human {
    // Fields (attributes) of the Human class
    String name;
    int age;
    double weight;

    // Constructor: special method called when an object is created
    // It initializes the fields of the object
    Human(String name, int age, double weight){
        this.name = name;     // 'this' refers to the current object
        this.age = age;
        this.weight = weight;
    }

    // Method for the Human to eat
    void eat(){
        System.out.println(this.name + "eating");
    }

    // Method for the Human to drink
    void drink(){
        System.out.println(this.name + "is drinking!!");
    }
}
