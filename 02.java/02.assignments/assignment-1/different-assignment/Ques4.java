class Triangle1{
	int a,b,c;
	
	public Triangle1(int a, int b, int c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}
	
	public void printPerimeter() {
		int perimeter = a + b + c;
		System.out.println("Perimeter of triangle: " + perimeter);
	}
	
	public void printArea() {
		double area = (4+3)/ 2.0;
		System.out.println("Area of the triangle is: " + area);
	}
	
}

public class Ques4{
	public static void main(String[] args) {
		Triangle1 t1 = new Triangle1(3,4,5);
		t1.printPerimeter();
		t1.printArea();	
		
	}
}