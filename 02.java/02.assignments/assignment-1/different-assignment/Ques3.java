
//3. Write a program to print the area and perimeter of a triangle having sides of 3, 4 and 5 units by
//creating a class named 'Triangle' without any parameter in its constructor.

import java.util.*;
class Triangle{
	int a, b, c;
	int base;
	int height;
	
	public Triangle() {
		a = 3;
		b = 4;
		c = 5;
		
	}
	public void printPerimeter() {
		int perimeter = a + b + c;
		System.out.println("The perimeter of the triangle is: " + perimeter);
	}
	
	public void printArea(int base, int height) {
		double area = (base* height) / 2.0;
		System.out.println("Area:" + area);
	}
}

public class Ques3 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Triangle t = new Triangle();
		t.printPerimeter();
		t.printArea(23,123);
		
		
		
		
	}

}
