class Vehicle {
    String type;

    Vehicle(String type) {
        this.type = type;
        System.out.println("Vehicle constructor: Type = " + type);
    }
}

class FourWheeler extends Vehicle {
    String brand;

    FourWheeler(String type, String brand) {
        super(type); // Calls Vehicle constructor
        this.brand = brand;
        System.out.println("FourWheeler constructor: Brand = " + brand);
    }
}

class Car extends FourWheeler {
    String model;
    double price;

    Car(String type, String brand, String model, double price) {
        super(type, brand); // Calls FourWheeler constructor
        this.model = model;
        this.price = price;
        System.out.println("Car constructor: Model = " + model + ", Price = " + price);
    }
}

public class Ques3a {
    public static void main(String[] args) {
        Car c = new Car("Automobile", "Toyota", "Camry", 25000.0);
    }
}