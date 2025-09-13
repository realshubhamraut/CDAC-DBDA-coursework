import java.util.*;

class Area1 {
    int length;
    int breadth;

    public Area1(int length, int breadth) {
        this.length = length;
        this.breadth = breadth;
    }

    public int returnArea() {
        return length * breadth;
    }
}

public class Ques7 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter length: ");
        int length = sc.nextInt();
        System.out.print("Enter breadth: ");
        int breadth = sc.nextInt();

        Area1 area = new Area1(length, breadth);
        System.out.println("Area of rectangle: " + area.returnArea());
        sc.close();
    }
}