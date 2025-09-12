import java.util.Scanner;
public class If_else{
    public static void main(String args[]){
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter your name: ");
        String name = sc.nextLine();
        System.out.print("Enter you age: ");
        int age = sc.nextInt();

        if (name.equals("Shubham") && age >= 18){
            System.out.println("He is shubham and he is adult");

        }
        else if(name.equals("Payal") && age <18){
            System.out.println("She is payal and she is adult");

        }

        else{
            System.out.println("This is unknown person");
        }

    }
}


