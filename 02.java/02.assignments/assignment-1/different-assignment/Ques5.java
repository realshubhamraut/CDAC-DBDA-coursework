class Rectangle{
	int length;
	int breadth;
	int area;
	public Rectangle(int length, int breadth) {
		this.length = length;
		this.breadth = breadth;
	}
	
	public void Area() {
		area = length * breadth;
		System.out.println("Area of the rectangle is: "+ area);
	}
}

public class Ques5 {
	public static void main(String[] args) {
		Rectangle r = new Rectangle(23,21);
		Rectangle r2 = new Rectangle(43,12);
		
		r.Area();
		r2.Area();
	}

}
