// 25. Write a program to convert state of Float instance into byte,
// short, int, long, float and double.

public class Ques25 {
	public static void main(String[] args) {
		Float floatObj = 123.45f; // Example Float instance

		byte b = floatObj.byteValue();
		short s = floatObj.shortValue();
		int i = floatObj.intValue();
		long l = floatObj.longValue();
		float f = floatObj.floatValue();
		double d = floatObj.doubleValue();

		System.out.println("Float instance: " + floatObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
