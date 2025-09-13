// 18. Write a program to find minimum and maximum number as well as
// to add two integer numbers using methods of Integer.

public class Ques18 {
	public static void main(String[] args) {
		int a = 15;
		int b = 27;

		// Find minimum
		int min = Integer.min(a, b);
		System.out.println("Minimum: " + min);

		// Find maximum
		int max = Integer.max(a, b);
		System.out.println("Maximum: " + max);

		// Add two integers
		int sum = Integer.sum(a, b);
		System.out.println("Sum: " + sum);
	}
}
