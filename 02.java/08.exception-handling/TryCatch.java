import java.util.*;

public class TryCatch {
    public static void main(String[] args){

        Scanner sc = new Scanner(System.in);
        try {
            System.out.print("Enter first number: ");
            int a = sc.nextInt();
            System.out.print("Enter second number: ");
            int b = sc.nextInt();

            int result = a / b;
            System.out.println("Result: " + result);
        } catch (ArithmeticException ae) {
            System.out.println("Zero division error / cannot divide by zero");
        }
        System.out.println("Program continues.....");
        sc.close();
    }
}