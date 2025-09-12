public class Try{
    public static void main(String[] args){
        try{
            int a = 10;
            int b = 0;
            int result = a /b;
            System.out.println("Result: " + result);

        } catch (ArithmeticException ae){
            System.out.println("cannot divide by zero/ zero divsion error");
        }
        System.out.println("No error program continues");
    }
}