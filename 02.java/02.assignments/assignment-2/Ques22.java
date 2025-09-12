// Write a Java program with an abstract class Shape that has an abstract method calculateArea(). Implement it in Circle and Rectangle classes.


abstract class Shape{
    public abstract void calculateArea();
}


class Circle extends Shape{
    private double radius;

    public Circle(double radius){
        this.radius = radius;
    }

    public void calculateArea(){
        double area = Math.PI * radius * radius;
        System.out.println("Area of the circle: " + area);
    }
}

class Rectangle extends Shape{
    private double length;
    private double breadth;

    public Rectangle(double length, double breadth){
        this.breadth = breadth;
        this.length = length;
    }
    public void calculateArea(){
        double area = length * breadth;
        System.out.println("Area of the rectangle: " + area);
    }

}

public class Ques22{
    public static void main(String[] arsg){
        Circle c = new Circle(013);
        Rectangle r = new Rectangle(23, 13);

        r.calculateArea();
        c.calculateArea();
    }
}

