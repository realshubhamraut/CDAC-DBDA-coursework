// Write a Java program to create a class Printer that has multiple overloaded print ()
// methods for String, int, and double values.

class Printer{
    public void print(String s){
        System.out.println("String" +s);
    }

    public void print(int i){
        System.out.println("Int" + i);
    }

    public void print(double d){
        System.out.println("Double" +d);
    }

}
public class Ques12 {
    public static void main(String[]args){
        Printer p = new Printer();
        p.print("Hello");
        p.print(42);
        p.print(3.14);
    }
    
}
