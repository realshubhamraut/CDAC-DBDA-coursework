// Create a base class Vehicle with properties brand and speed, Create a subclass Car
// that adds fuelType and a method displayCarDetails ().



class Vehicle{
    String brand;
    int speed;

    Vehicle(){

    }

}

class Car extends Vehicle{
    String fuelType;

    void displayCarDetails(){
        System.out.println("Vehicle details");
        System.out.println("");
        System.out.println("Brand" + brand);
        System.out.println("Speed" + speed);
    }

}



public class Ques2 {
    public static void main(String[] args){
        Car myCar = new Car();
        myCar.brand = "Toyota";
        myCar.speed = 123;
        myCar.fuelType = "Petrol";
        myCar.displayCarDetails();

    }
}



