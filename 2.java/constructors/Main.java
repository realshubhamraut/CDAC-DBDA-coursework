
// Main class to demonstrate the use of constructors in Java
public class Main{

    public static void main(String[] args){
        // Creating objects (instances) of the Human class using the constructor
        Human human1 = new Human("Shubham ", 23, 77); // Calls the constructor with parameters
        Human human2 = new Human("Payal ", 17, 45);   // Another object with different values

        // Calling methods on the objects
        human2.eat();     // prints "Payal eating"
        human1.drink();   // prints "Shubham is drinking!!"

        // Accessing a field of the object
        System.out.println(human2.name); // prints the name of human2
    }
} 