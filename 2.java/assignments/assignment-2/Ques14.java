// Write a Java program where a Shape class has overloaded draw () methods, accepting
// different numbers of parameters to draw different shapes.


class Shape{
    public void draw(float length, float breadth){
        System.out.println("Area of rectangel is: " + length*breadth);
    }

    public void draw(double radius){
        System.out.println("Are of circle is" + Math.PI  * radius * radius);
    }
}
public class Ques14 {
    public static void main(String[] args){
        Shape sh = new Shape();
        sh.draw(123.312);
        sh.draw(12,41);
    }
    
}
