import java.util.Scanner;

class Area {
    private double length;
    private double breadth;

    public void setDim(double length, double breadth) {
        this.length = length;
        this.breadth = breadth;
    }

    public double getArea() {
        return length * breadth;
    }
}

public class RectangleArea2{
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter length of rectangle: ");
        double length = sc.nextDouble();

        System.out.print("Enter breadth of rectangle: ");
        double breadth = sc.nextDouble();

        Area rect = new Area();
        rect.setDim(length, breadth);

        System.out.println("Area of rectangle: " + rect.getArea());
    }
}
