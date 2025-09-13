// 17.Write a program to convert state of Integer instance into
// byte, short, int, long, float and double.

public class Ques17 {
	public static void main(String[] args) {
		Integer intObj = 12345; // Example Integer instance

		byte b = intObj.byteValue();
		short s = intObj.shortValue();
		int i = intObj.intValue();
		long l = intObj.longValue();
		float f = intObj.floatValue();
		double d = intObj.doubleValue();

		System.out.println("Integer instance: " + intObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
