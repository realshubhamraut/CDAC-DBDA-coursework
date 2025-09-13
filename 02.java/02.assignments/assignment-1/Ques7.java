// 7. Write a program to perform below operations on byte type to
// get :
// a. The number of bits used to represent a byte value
// b. The number of bytes used to represent a byte value
// c. The minimum value a byte
// d. The maximum value a byte

public class Ques7 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a byte value
		System.out.println("a. Number of bits in byte: " + Byte.SIZE);

		// b. The number of bytes used to represent a byte value
		System.out.println("b. Number of bytes in byte: " + Byte.BYTES);

		// c. The minimum value a byte
		System.out.println("c. Minimum value of byte: " + Byte.MIN_VALUE);

		// d. The maximum value a byte
		System.out.println("d. Maximum value of byte: " + Byte.MAX_VALUE);
	}
}
