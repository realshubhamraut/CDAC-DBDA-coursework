// Create a Calculator class with overloaded multiply () methods to accept integers,
// doubles, and a mix of both.
class Calculator{
    public void multiply(int i){
        System.out.println("Square(int): " + (i*i));
    }

    public void multiply(double d){
        System.out.println("multiple(double): " + (d*d));
    }

    public void multiply(double d, int i){
        System.out.println("Product(dobule,int): "+ (d*i));
    }
}
public class Ques13 {
    public static void main(String[] args){
        Calculator c = new Calculator();
        c.multiply(12);
        c.multiply(12.123);
        c.multiply(2.5,4);
    }
    
}
