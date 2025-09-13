// 23. Write a program to perform below operations on float type to
// get :
// a. The number of bits used to represent a float value
// b. The number of bytes used to represent a float value
// c. The minimum value a float
// d. The maximum value a float

public class Ques23 {
	public static void main(String[] args) {
		// a. The number of bits used to represent a float value
		System.out.println("a. Number of bits in float: " + Float.SIZE);

		// b. The number of bytes used to represent a float value
		System.out.println("b. Number of bytes in float: " + Float.BYTES);

		// c. The minimum value a float
		System.out.println("c. Minimum value of float: " + Float.MIN_VALUE);

		// d. The maximum value a float
		System.out.println("d. Maximum value of float: " + Float.MAX_VALUE);
	}
}
