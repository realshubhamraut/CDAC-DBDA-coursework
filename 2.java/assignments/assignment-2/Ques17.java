// Write a Java program where a Vehicle class has a run () method. Create subclasses
// Bike and Car that override run () with specific messages.

class Vehicle {
    public void run() {
        System.out.println("Vehicle is running");
    }
}

class Bike extends Vehicle {
    public void run() {
        System.out.println("Bike is running safely");
    }
}

class Car extends Vehicle {
    public void run() {
        System.out.println("Car is running smoothly");
    }
}






public class Ques17{
    public static void main(String[] args) {
        Vehicle v = new Vehicle();
        Bike b = new Bike();
        Car c = new Car();

        v.run();
        b.run();
        c.run();
    }
}