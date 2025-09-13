// 16. Write a program to convert:
// a. int value into String
// b. int value into Integer instance.
// c. String instance into Integer instance.
// d. int value into binary, octal and hexadecimal string.

public class Ques16 {
	public static void main(String[] args) {
		int intValue = 42;

		// a. int value into String
		String strFromInt = Integer.toString(intValue);
		System.out.println("a. int to String: " + strFromInt);

		// b. int value into Integer instance
		Integer intInstance = Integer.valueOf(intValue);
		System.out.println("b. int to Integer instance: " + intInstance);

		// c. String instance into Integer instance
		String strValue = "123";
		Integer intFromString = Integer.valueOf(strValue);
		System.out.println("c. String to Integer instance: " + intFromString);

		// d. int value into binary, octal and hexadecimal string
		String binaryStr = Integer.toBinaryString(intValue);
		String octalStr = Integer.toOctalString(intValue);
		String hexStr = Integer.toHexString(intValue);
		System.out.println("d. int to binary string: " + binaryStr);
		System.out.println("d. int to octal string: " + octalStr);
		System.out.println("d. int to hexadecimal string: " + hexStr);
	}
}
