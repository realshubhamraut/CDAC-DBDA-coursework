import java.util.*;

class NegativeNumberException extends Exception {
    public 
}
public class CustomException {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        try{
            System.out.print("Enter the positive number: ");
            int num = sc.nextInt();
            if (num<0){
                throw new NegativeNumberException("negative numbers are not allowed");
            }
            System.out.println("You entered" + num);
        } catch(NegativeNumberException e){
            System.out.println("Custom Exception Caught" + e.getMessage());
        }
        sc.close();
    }
    
}
