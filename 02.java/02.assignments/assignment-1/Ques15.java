// 15. Write a program to perform below operations on int type to
// get :
// a. The number of bits used to represent a integer value
// b. The number of bytes used to represent a integer value
// c. The minimum value a integer
// d. The maximum value a integer

public class Ques15 {
	public static void main(String[] args) {
		// a. The number of bits used to represent an int value
		System.out.println("a. Number of bits in int: " + Integer.SIZE);

		// b. The number of bytes used to represent an int value
		System.out.println("b. Number of bytes in int: " + Integer.BYTES);

		// c. The minimum value an int
		System.out.println("c. Minimum value of int: " + Integer.MIN_VALUE);

		// d. The maximum value an int
		System.out.println("d. Maximum value of int: " + Integer.MAX_VALUE);
	}
}
