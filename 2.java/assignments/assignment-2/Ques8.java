// Create a class Car with private variables model, year, and price. Provide public
// methods to get and set values while ensuring year is not negative.
import java.util.*;
class Car{
    
    private String model;
    private int year;
    private int price;

    public String getModel(){
        return model;
    }
    public int getYear(){
        return year;
    }

    public int getPrice(){
        return price;
    }

    public void setModel(String model){
        this.model = model;

    }

    public void setYear(int year){
        this.year = year;
    }

    public void setPrice(int price){
        this.price = price;
    }


}
public class Ques8 {
    public static void main(String[] args){
        int inputyear;
        Car c = new Car();

        Scanner sc = new Scanner(System.in);





        System.out.println("Enter year");
        inputyear = sc.nextInt();
        c.setYear(inputyear);

        while (c.getYear() < 0){
            System.out.println("Negative year, Try again");
            c.setYear(sc.nextInt());
            
        }



        c.setModel("A-Series");
        c.setPrice(34000);
        System.out.println("model" + c.getModel());
        System.out.println("price "+ c.getPrice());
        System.out.println("Year " + c.getYear());

    }
    
}
