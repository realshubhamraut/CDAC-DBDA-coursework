public class Try{
    public static void main(String[] args){
        try{
            int a = 10;
            int b = 12;
            int result = a/b;
            System.out.println("Result" + result);

        } catch (ArithmeticException ae){
            System.out.println("Zero division error");
        }
        System.out.println("Program continues....");
    }
}