// 6. Write a program to perform below operations on Boolean type to
// convert:
// a. boolean value into String
// b. boolean value into Boolean instance.
// c. String value into boolean value
// d. String value into Boolean instance.

public class Ques6 {
	public static void main(String[] args) {
		// a. boolean value into String
		boolean boolValue = true;
		String strFromBool = Boolean.toString(boolValue);
		System.out.println("a. boolean to String: " + strFromBool);

		// b. boolean value into Boolean instance
		Boolean boolInstance = Boolean.valueOf(boolValue);
		System.out.println("b. boolean to Boolean instance: " + boolInstance);

		// c. String value into boolean value
		String strValue = "true";
		boolean boolFromString = Boolean.parseBoolean(strValue);
		System.out.println("c. String to boolean: " + boolFromString);

		// d. String value into Boolean instance
		Boolean boolInstanceFromString = Boolean.valueOf(strValue);
		System.out.println("d. String to Boolean instance: " + boolInstanceFromString);
	}
}
