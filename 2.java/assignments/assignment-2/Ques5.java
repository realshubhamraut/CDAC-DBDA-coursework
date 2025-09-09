//Create a base class Shape with a method area (). Create subclasses Circle and
// Rectangle that override area () to calculate their respective areas.



class Shape{
    void area(){
    }
}

class Circle extends Shape{
    float radius;
    Circle(float radius){
        this.radius = radius;
    }

    void area(){
    
        System.out.println("Area of Circle = "+ Math.PI * radius * radius);

    }

}

class Rectangle extends Shape{
    float length;
    float breadth;

    Rectangle(float length, float breadth){
        this.length = length;
        this.breadth = breadth;


    }
    void area(){
        float area = length*breadth;
        System.out.println("Area of Rectangle= "+area);
    }


}


public class Ques5 {
    public static void main(String args[]){
        Rectangle rec = new Rectangle(23,14);
        rec.area();
        Circle cir = new Circle(123);
        cir.area();

        
    }
    
}
