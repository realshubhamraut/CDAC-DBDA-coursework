import java.util.*;
public class While2{
    public static void main(String args[]){
        Scanner sc = new Scanner(System.in);
        String key = "";
        while(!key.equals("Q")){
            System.out.println("Enter the Key");
            System.out.println("Press Q to quit");
            key = sc.next().toUpperCase();
        }

        System.out.println("You have quit the game");
    }
    
}