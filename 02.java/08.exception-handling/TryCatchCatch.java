// handling multiple exceptions;

import java.util.*;


public class TryCatchCatch{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        try{
            int whichIndex;
            int[] arr = {123,141,45,112,12};
            System.out.print("Tell me the index you wanna access: ");
            whichIndex = sc.nextInt();
            System.out.print("Value at index: "+ whichIndex + ": " + arr[whichIndex]);
            
        } catch (ArrayIndexOutOfBoundsException exind){
            System.out.println("index out of scope for the array");
        }

        try{
            System.out.print("Enter the number 1: ");
            int a = sc.nextInt();
            System.out.print("Enter the number 2: ");
            int b = sc.nextInt();
            int result = a / b;
            System.out.println("result:" + result); 
        } catch(ArithmeticException ae){
            System.out.println("arithmetic exception");
        }
        System.out.println("No errors detected, program moved ahead");
        sc.close();
    }
}

