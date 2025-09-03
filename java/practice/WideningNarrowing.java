public class WideningNarrowing {
    public static void main(String args[]) {
        int small = 60;
        long big = small; //widening
        System.out.println(big);

        float variable = 12.999f;
        int convert = (int) variable;
        System.out.println(convert);

        double variable2 = 12.999;
        int convert2 = (int) variable2;
        System.out.println(convert2);

        long abc = 5666666666666l;
        System.out.println(abc);
        float pqr = (float)abc;
        System.out.println(pqr);

        
    }    
}
