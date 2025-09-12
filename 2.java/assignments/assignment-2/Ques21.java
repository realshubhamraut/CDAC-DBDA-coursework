// Create an abstract class Vehicle with an abstract method start (). Create subclasses
// Car and Bike that provide their own implementation of start ().

abstract class Vehicle{
    public abstract void start();
}

class Bike extends Vehicle{
    public void start(){
        System.out.println("The bike start with kick");
    }
}

class Car extends Vehicle{
    public void start(){
        System.out.println("The car starts with the starter");  
    }
}

public class Ques21 {
    public static void main(String[] args){
        Bike b = new Bike();
        Car c = new Car();
        c.start();
        b.start();
    }
}
