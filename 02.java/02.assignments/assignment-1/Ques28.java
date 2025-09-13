// 28. Write a program to convert:
// a. double value into String
// b. double value into Double instance.
// c. String instance into Double instance.
// d. double value into binary, octal and hexadecimal
// string (Note: Here you can use doubleToLongBits () method
// along with methods of Long class).

public class Ques28 {
	public static void main(String[] args) {
		double doubleValue = 123.456;

		// a. double value into String
		String strFromDouble = Double.toString(doubleValue);
		System.out.println("a. double to String: " + strFromDouble);

		// b. double value into Double instance
		Double doubleInstance = Double.valueOf(doubleValue);
		System.out.println("b. double to Double instance: " + doubleInstance);

		// c. String instance into Double instance
		String strValue = "789.012";
		Double doubleFromString = Double.valueOf(strValue);
		System.out.println("c. String to Double instance: " + doubleFromString);

		// d. double value into binary, octal and hexadecimal string
		long bits = Double.doubleToLongBits(doubleValue);
		String binaryStr = Long.toBinaryString(bits);
		String octalStr = Long.toOctalString(bits);
		String hexStr = Long.toHexString(bits);
		System.out.println("d. double to binary string: " + binaryStr);
		System.out.println("d. double to octal string: " + octalStr);
		System.out.println("d. double to hexadecimal string: " + hexStr);
	}
}
