// Write a Java program for a Laptop class with private attributes brand and price.
// Ensure price cannot be set below zero using validation inside the setter method.
import java.util.*;

class Laptop{
    private String brand;
    private int price;

    public void setPrice(int price){
        this.price = price;
    }

    public int getPrice(){
        return price;
    }

    public void setBrand(String brand){
        this.brand = brand;
    }

    public String getBrand(){
        return brand;
    }

}
public class Ques9 {
    public static void main(String[] args){
        int inputprice;
        String whichbrand;
        Laptop la = new Laptop();

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter the price");
        inputprice = sc.nextInt();
        la.setPrice(inputprice);

            

        while (la.getPrice()<0){
            System.out.println("Negative price, Try again");
            int price = sc.nextInt();

        }

        whichbrand = sc.nextLine();
        la.setBrand(whichbrand);
        System.out.println("Price and brand");
        System.out.println("Price: " + la.getPrice());
        System.out.println("Brand"+ la.getBrand());
    }

    
}
