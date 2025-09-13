
class MathOperations {
	// Add two integers
	public int add(int a, int b) {
		return a + b;
	}

	// Add three integers
	public int add(int a, int b, int c) {
		return a + b + c;
	}

	// Add two double values
	public double add(double a, double b) {
		return a + b;
	}
}

public class Ques11 {
	public static void main(String[] args) {
		MathOperations mo = new MathOperations();
		System.out.println("Add two ints: " + mo.add(2, 3));
		System.out.println("Add three ints: " + mo.add(1, 2, 3));
		System.out.println("Add two doubles: " + mo.add(2.5, 3.7));
	}
}
