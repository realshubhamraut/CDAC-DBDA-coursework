// 22. Write a program to find minimum and maximum number as well as
// to add two long numbers using methods of Long.

public class Ques22 {
	public static void main(String[] args) {
		long a = 123456789L;
		long b = 987654321L;

		// Find minimum
		long min = Long.min(a, b);
		System.out.println("Minimum: " + min);

		// Find maximum
		long max = Long.max(a, b);
		System.out.println("Maximum: " + max);

		// Add two longs
		long sum = Long.sum(a, b);
		System.out.println("Sum: " + sum);
	}
}
