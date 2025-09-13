// 14. Write a program to convert state of Short instance into byte,
// short, int, long, float and double.

public class Ques14 {
	public static void main(String[] args) {
		Short shortObj = 1234; // Example Short instance

		byte b = shortObj.byteValue();
		short s = shortObj.shortValue();
		int i = shortObj.intValue();
		long l = shortObj.longValue();
		float f = shortObj.floatValue();
		double d = shortObj.doubleValue();

		System.out.println("Short instance: " + shortObj);
		System.out.println("byte: " + b);
		System.out.println("short: " + s);
		System.out.println("int: " + i);
		System.out.println("long: " + l);
		System.out.println("float: " + f);
		System.out.println("double: " + d);
	}
}
