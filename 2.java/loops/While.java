import java.util.*;
public class While{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter the number");
        int num;
        num = sc.nextInt();
        while(num>=10 && num <=20){
            System.out.println("num: "+ num--);
        }
    }
}