public class Swtich_case {
    public static void main(String[] args) {
        int day = 3; // Example: 1=Monday, 2=Tuesday, ... 7=Sunday
        switch(day) {
            case 1:
                System.out.println("Monday");
                break;
            case 2:
                System.out.println("Tuesday");
                break;
            case 3:
                System.out.println("Wednesday");
                break;
            case 4:
                System.out.println("Thursday");
                break;
            case 5:
                System.out.println("Friday");
                break;
            case 6:
                System.out.println("Saturday");
                break;
            case 7:
                System.out.println("Sunday");
                break;
            default:
                System.out.println("Invalid day");
        }
    }
}


// if not break if a pattern matches at particular case then rest of the cases are printed as well
// unless we add the break statement explicitly
