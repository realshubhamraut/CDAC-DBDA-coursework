import java.util.*;
public class Ticketbook1{
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        try{
            String[] seats = {"A1", "A2", "A3", "A4", "A5"};

            // 1. InputMismatchException
            System.out.print("Enter number of ticket: ");
            int tickets = sc.nextInt();

            // 2. IllegalArgumentException
            if (tickets <= 0) {
                throw new IllegalArgumentException("Number of ticket must be positive");
            }
            System.out.print("Choose seat between 0-4: ");
            int index = sc.nextInt();

            // 3. IndexOutOfBoundsException
            System.out.println("You booked seat: " + seats[index]);

        } 
        catch(InputMismatchException e){
            System.out.println("Error: Invalid input type. Please enter a number.");
        } 
        catch(IllegalArgumentException e){
            System.out.println("Error: " + e.getMessage());
        } 
        catch(IndexOutOfBoundsException e){
            System.out.println("Error: Invalid seat index. Please choose within range.");
        } 
        finally{
            System.out.println("Booking process finished.");
            sc.close();
        }
    }
}