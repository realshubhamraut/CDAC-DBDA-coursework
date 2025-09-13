// 27. Write a program to perform below operations on Double type to
// get:
// a. The number of bits used to represent a double value
// b. The number of bytes used to represent a double value
// c. The minimum value a double
// d. The maximum value a double

public class Ques27 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a double value
		System.out.println("a. Number of bits in double: " + Double.SIZE);

		// b. The number of bytes used to represent a double value
		System.out.println("b. Number of bytes in double: " + Double.BYTES);

		// c. The minimum value a double
		System.out.println("c. Minimum value of double: " + Double.MIN_VALUE);

		// d. The maximum value a double
		System.out.println("d. Maximum value of double: " + Double.MAX_VALUE);
	}
}
