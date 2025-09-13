import java.util.Scanner;

public class ExceptinHandling{
    public static void main(String[] args) {
        String accountno;
        Scanner scan=new Scanner(System.in);
        System.out.print("Enter you account number : ");
        accountno=scan.nextLine();
        int accnumber = 0;

        try {
            accnumber=Integer.parseInt(accountno);

        } catch (NumberFormatException ne) {
            System.out.println("String can not be converted to Integer...");
        } 
        catch(NullPointerException npe){
            System.out.println("String can not be Null...");
        }
        finally{
            System.out.println("Conversion attempt completed : "+accnumber);
        }
        scan.close();
    }
}