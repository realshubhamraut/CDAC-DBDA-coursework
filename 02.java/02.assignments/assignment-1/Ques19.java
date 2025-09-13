// 19. Write a program to perform below operations on long type to
// get:
// a. The number of bits used to represent a long value
// b. The number of bytes used to represent a long value
// c. The minimum value a long
// d. The maximum value a long

public class Ques19 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a long value
		System.out.println("a. Number of bits in long: " + Long.SIZE);

		// b. The number of bytes used to represent a long value
		System.out.println("b. Number of bytes in long: " + Long.BYTES);

		// c. The minimum value a long
		System.out.println("c. Minimum value of long: " + Long.MIN_VALUE);

		// d. The maximum value a long
		System.out.println("d. Maximum value of long: " + Long.MAX_VALUE);
	}
}
