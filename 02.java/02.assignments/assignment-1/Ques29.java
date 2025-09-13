// 29. Write a program to convert state of Double instance into byte,
// short, int, long, float and double.

public class Ques29 {
	public static void main(String[] args) {
		Double doubleObj = 456.789;

		byte b = doubleObj.byteValue();
		short s = doubleObj.shortValue();
		int i = doubleObj.intValue();
		long l = doubleObj.longValue();
		float f = doubleObj.floatValue();
		double d = doubleObj.doubleValue();

		System.out.println("Double instance: " + doubleObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
