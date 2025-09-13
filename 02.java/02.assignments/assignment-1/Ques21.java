// 21.Write a program to convert state of Long instance into byte,
// short, int, long, float and double.

public class Ques21 {
	public static void main(String[] args) {
		Long longObj = 123456789L; // Example Long instance

		byte b = longObj.byteValue();
		short s = longObj.shortValue();
		int i = longObj.intValue();
		long l = longObj.longValue();
		float f = longObj.floatValue();
		double d = longObj.doubleValue();

		System.out.println("Long instance: " + longObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
