public class BoxingUnboxing {
    public static void main(String[] args) {
        int cr = 50;
        Integer objCr = cr;
        System.out.println(cr);
        // System.out.println(cr.hashCode());

        objCr = cr;
        System.out.println(objCr.hashCode());
        
        long o = 60001515;
        Long objO = o;
        System.out.println(objO.hashCode());

        float f = 344.13f;
        





    }
    
}
