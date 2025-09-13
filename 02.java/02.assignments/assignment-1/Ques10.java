// 10. Write a program to perform below operations on char type to
// get :
// a. The number of bits used to represent a char value
// b. The number of bytes used to represent a char value
// c. The minimum value a char
// d. The maximum value a char

public class Ques10 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a char value
		System.out.println("a. Number of bits in char: " + Character.SIZE);

		// b. The number of bytes used to represent a char value
		System.out.println("b. Number of bytes in char: " + Character.BYTES);

		// c. The minimum value a char
		System.out.println("c. Minimum value of char: " + (int) Character.MIN_VALUE);

		// d. The maximum value a char
		System.out.println("d. Maximum value of char: " + (int) Character.MAX_VALUE);
	}
}
