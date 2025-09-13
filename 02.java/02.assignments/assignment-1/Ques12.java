// 12. Write a program to perform below operations on short type to
// get:
// a. The number of bits used to represent a short value
// b. The number of bytes used to represent a short value
// c. The minimum value a short
// d. The maximum value a short

public class Ques12 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a short value
		System.out.println("a. Number of bits in short: " + Short.SIZE);

		// b. The number of bytes used to represent a short value
		System.out.println("b. Number of bytes in short: " + Short.BYTES);

		// c. The minimum value a short
		System.out.println("c. Minimum value of short: " + Short.MIN_VALUE);

		// d. The maximum value a short
		System.out.println("d. Maximum value of short: " + Short.MAX_VALUE);
	}
}
