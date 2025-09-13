// 26. Write a program to find minimum and maximum number as well as
// to add two float numbers using methods of Float.

public class Ques26 {
	public static void main(String[] args) {
		float a = 12.34f;
		float b = 56.78f;

		// Find minimum
		float min = Float.min(a, b);
		System.out.println("Minimum: " + min);

		// Find maximum
		float max = Float.max(a, b);
		System.out.println("Maximum: " + max);

		// Add two floats
		float sum = Float.sum(a, b);
		System.out.println("Sum: " + sum);
	}
}
