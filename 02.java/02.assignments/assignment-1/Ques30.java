// 30. Write a program to find minimum and maximum number as well as
// to add two double numbers using methods of Double.

public class Ques30 {
	public static void main(String[] args) {
		double a = 123.45;
		double b = 678.90;

		// Find minimum
		double min = Double.min(a, b);
		System.out.println("Minimum: " + min);

		// Find maximum
		double max = Double.max(a, b);
		System.out.println("Maximum: " + max);

		// Add two doubles
		double sum = Double.sum(a, b);
		System.out.println("Sum: " + sum);
	}
}
