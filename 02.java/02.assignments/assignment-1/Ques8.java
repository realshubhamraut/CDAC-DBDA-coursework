// 8. Write a program to convert:
// a. byte value into String
// b. byte value into Byte instance.
// c. String instance into Byte instance.

public class Ques8 {
	public static void main(String[] args) {
		// a. byte value into String
		byte byteValue = 10;
		String strFromByte = Byte.toString(byteValue);
		System.out.println("a. byte to String: " + strFromByte);

		// b. byte value into Byte instance
		Byte byteInstance = Byte.valueOf(byteValue);
		System.out.println("b. byte to Byte instance: " + byteInstance);

		// c. String instance into Byte instance
		String strValue = "25";
		Byte byteFromString = Byte.valueOf(strValue);
		System.out.println("c. String to Byte instance: " + byteFromString);
	}
}
