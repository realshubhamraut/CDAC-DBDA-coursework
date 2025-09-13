// 24. Write a program to convert:
// a. float value into String
// b. float value into Float instance.
// c. String instance into Float instance.
// d. float value into hexadecimal string.
public class Ques24 {
	public static void main(String[] args) {
		float floatValue = 12.34f;

		// a. float value into String
		String strFromFloat = Float.toString(floatValue);
		System.out.println("a. float to String: " + strFromFloat);

		// b. float value into Float instance
		Float floatInstance = Float.valueOf(floatValue);
		System.out.println("b. float to Float instance: " + floatInstance);

		// c. String instance into Float instance
		String strValue = "56.78";
		Float floatFromString = Float.valueOf(strValue);
		System.out.println("c. String to Float instance: " + floatFromString);

		// d. float value into hexadecimal string
		String hexStr = Float.toHexString(floatValue);
		System.out.println("d. float to hexadecimal string: " + hexStr);
	}
}
