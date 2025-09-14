import java.util.*;
public class Exception{
    public static void main(String[] args){
        String accountno;
        Scanner scan = new Scanner(System.in);
        System.out.println("Enter you account number: ");
        accountno = scan.nextLine();
        int accunumber = 0;

        try{
            accunumber = Integer.parseInt(accountno);

        } catch (NumberFormatException ne) {
            System.out.println("String could not be converted to integer");

        }
        catch(NullPointerException npe){
            System.out.println("String can not be null...");

        }
        finally{
            System.out.println("Conversion " +  accunumber);

        }

        scan.close();
        
    }
}