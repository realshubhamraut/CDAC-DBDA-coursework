// handling multiple exceptions;

public class TryCatchCatch{
    public static void main(String[] args){
        try{
            int[] arr = {1,2,12,4,1};
            System.out.println(arr[23]);
        } catch (ArrayIndexOutOfBoundsException rt) {
            System.out.println("Array out of call");
        } catch (ArithmeticException ae){
            System.out.println("Division error/ cannot divide by zero");
        }
        System.out.println("Program executed safely, no worries");
    }
}