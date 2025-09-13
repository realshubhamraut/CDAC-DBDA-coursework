// 9. Write a program to convert state of Byte instance into byte,
// short, int. long, float and double.

public class Ques9 {
	public static void main(String[] args) {
		Byte byteObj = 42; // Example Byte instance

		// Convert Byte instance to different primitive types
		byte b = byteObj.byteValue();
		short s = byteObj.shortValue();
		int i = byteObj.intValue();
		long l = byteObj.longValue();
		float f = byteObj.floatValue();
		double d = byteObj.doubleValue();

		System.out.println("Byte instance: " + byteObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
