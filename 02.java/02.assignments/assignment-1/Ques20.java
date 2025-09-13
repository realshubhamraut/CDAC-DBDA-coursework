// 20. Write a program to convert:
// a. long value into String
// b. long value into Long instance.
// c. String instance into Long instance.
// d. long value into binary, octal and hexadecimal string.

public class Ques20 {
	public static void main(String[] args) {
		long longValue = 123456789L;

		// a. long value into String
		String strFromLong = Long.toString(longValue);
		System.out.println("a. long to String: " + strFromLong);

		// b. long value into Long instance
		Long longInstance = Long.valueOf(longValue);
		System.out.println("b. long to Long instance: " + longInstance);

		// c. String instance into Long instance
		String strValue = "987654321";
		Long longFromString = Long.valueOf(strValue);
		System.out.println("c. String to Long instance: " + longFromString);

		// d. long value into binary, octal and hexadecimal string
		String binaryStr = Long.toBinaryString(longValue);
		String octalStr = Long.toOctalString(longValue);
		String hexStr = Long.toHexString(longValue);
		System.out.println("d. long to binary string: " + binaryStr);
		System.out.println("d. long to octal string: " + octalStr);
		System.out.println("d. long to hexadecimal string: " + hexStr);
	}
}
