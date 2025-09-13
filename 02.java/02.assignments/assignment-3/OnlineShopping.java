
import java.util.Scanner;

public class OnlineShopping{
    public static void main(String[] args) {
        int arr[]={1,2,4,6,9};

        try {
            for (int i=0;i<=arr.length;i++){
                System.out.print(arr[i]+"  ");
            }
        } catch (IndexOutOfBoundsException ie) {
            System.out.println("This is IndexOutOfBoundsException");
        }

        try {
            Scanner scan = new Scanner(System.in);
            System.out.println("Enter Your Order ID Plz : ");
            String str = scan.nextLine();
            int number = Integer.parseInt(str);
            System.out.println("Your Order Id : "+number);
        } catch (NumberFormatException ne) {
            System.out.println("This is NumberFormatException : ID should not be in Alpha numeric");
        }

        try {
            Scanner scan = new Scanner(System.in);
            System.out.println("Enter number of products : ");
            int p = scan.nextInt();
            System.out.println("Enter the price : ");
            int totalp = scan.nextInt();

            int avg = totalp/p;
            System.out.println("Your Average price spend : "+avg);

        } catch (ArithmeticException ae) {
            System.out.println("This is ArithmeticException");
        }
    }
}