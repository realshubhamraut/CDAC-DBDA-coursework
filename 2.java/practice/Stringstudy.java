public class Stringstudy {
    public static void main(String args[]) {
        String str1 = "Shubham";
        String str3 = new String("Shubham");
        System.out.println(str1);
        System.out.println(str1.hashCode());
        System.out.println(str3.hashCode()); 
        System.out.println(str1==str3);
        System.out.println(str1.equals(str3));
    }
}
