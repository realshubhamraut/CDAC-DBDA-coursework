// 13. Write a program to convert:
// a. short value into String
// b. short value into Short instance.
// c. String instance into Short instance.


public class Ques13 {
	public static void main(String[] args) {
		// a. short value into String
		short shortValue = 1234;
		String strFromShort = Short.toString(shortValue);
		System.out.println("a. short to String: " + strFromShort);

		// b. short value into Short instance
		Short shortInstance = Short.valueOf(shortValue);
		System.out.println("b. short to Short instance: " + shortInstance);

		// c. String instance into Short instance
		String strValue = "5678";
		Short shortFromString = Short.valueOf(strValue);
		System.out.println("c. String to Short instance: " + shortFromString);
	}
}
