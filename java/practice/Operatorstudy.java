public class Operatorstudy {
    public static void main(String[] args) {
        int a = 5;
        int c = 43;
        int b = 43;
        a += 5;
        System.out.println(a);
        System.out.println(a++); //here value becomes 6 but will still print 5
        System.out.println(--a); // so that's why here it will print 5 again
        System.out.println(a==c); // Invalid comparison between int and boolean
        System.out.println(b); // Print the boolean value instead

        if(a>10 && b>10){
            System.out.println(a);
            (a>b?"hi":"bye");


        }
    }
}


