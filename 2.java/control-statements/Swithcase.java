public class Swithcase {
    public static void main(String args[]){
        int day;
        Scanner sc = new Scanner(System.in);
        
        switch(day){
            case 1:
            System.out.println("Monday");
            break;

            case 2:
            System.out.println("Tuesday");

            case 3:
            System.out.println("Wednesday");

            case 4:
            System.out.println("Thursday");

            case 5:
            System.out.println("Friday");

            case 6:
            System.out.println("Saturday");

            case 7:
            System.out.println("Sunday");
            
            default:
            System.out.println("invalid day");
        }
    }
    
}
