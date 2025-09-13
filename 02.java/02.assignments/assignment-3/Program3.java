class vehicles {
    String make;
    String model;
    int year;
    
    vehicles(String make,String model,int year){
        this.make=make;
        this.model=model;
        this.year=year;
    }
    vehicles(String make,String model){
        this.make=make;
        this.model=model;
    }
    String getmake(String make){
        return make;
    }
    String getmodel(String model){
        return model;
    }
    int getyear(int year){
        return year;
    }
}

class Car extends vehicles{
    int numOfDoors;

    Car(String make,String model,int year,int numOfDoors){
        super(make,model,year);
        this.numOfDoors=numOfDoors;
    }
    Car(String make,String model){
        super(make,model);
    }
    void displayCarDetails(){
        System.out.println("Make : "+make);
        System.out.println("Model : "+model);
        System.out.println("Year : "+year);
        System.out.println("Number of Doors : "+numOfDoors);
    }
} 
public class Program3{
    public static void main(String[] args) {
        Car c= new Car("Bajaj","bajaj",2022,4);
        Car c2= new Car("Bajaj","bajaj");

        c.displayCarDetails();
        System.out.println("--------");
        c2.displayCarDetails();
    }
}