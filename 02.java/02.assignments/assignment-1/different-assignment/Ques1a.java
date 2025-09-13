class Car {
    String brand;
    String model;
    double price;

    // Constructor 1: Only brand
    Car(String brand) {
        this.brand = brand;
        System.out.println("Brand: " + brand);
    }

    // Constructor 2: Brand and model
    Car(String brand, String model) {
        this(brand); // Calls constructor 1
        this.model = model;
        System.out.println("Model: " + model);
    }

    // Constructor 3: Brand, model, and price
    Car(String brand, String model, double price) {
        this(brand, model); // Calls constructor 2
        this.price = price;
        System.out.println("Price: " + price);
    }
}

public class Ques1a {
    public static void main(String[] args) {
        Car c1 = new Car("Toyota");
        System.out.println("---");
        Car c2 = new Car("Honda", "Civic");
        System.out.println("---");
        Car c3 = new Car("Ford", "Mustang", 35000.0);
    }
}