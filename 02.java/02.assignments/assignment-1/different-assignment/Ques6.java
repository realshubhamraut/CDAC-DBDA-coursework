import java.util.*;

class Area{
	int length;
	int breadth;
	
	public void setDim() {
		Scanner sc = new Scanner(System.in);

		
		System.out.println("Enter the breadth");
		breadth = sc.nextInt();
		System.out.println("Enter the length");
		length = sc.nextInt();
		
	}
	public int getArea() {
		return length *  breadth;
	}
}

public class Ques6 {
	public static void main(String args[]) {
		Area a = new Area();
		a.setDim();
		System.out.println("Area" + a.getArea());
		
		
	}

}
