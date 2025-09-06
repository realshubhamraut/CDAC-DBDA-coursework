import java.util.*;
public class If_else{
    public static void main(String args[]){
        String name;
        int age;
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter you name: ");
        name = sc.nextLine();
        System.out.println("Enter you age:");
        age = sc.nextInt();

        if(name.equals("Shubham") && age >= 18){
            System.out.println("this is shubam and adult");

        }
        else if(name.equals("payal")&& age <=18){
            System.out.println("this is payal and she is minor");

        }
        
        else{
            System.out.println("This is unknown person");
        }
    }
}