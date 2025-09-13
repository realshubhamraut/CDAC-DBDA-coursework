// 33. Pass integer, float and double value from command line. Parse
// it appropriately and perform arithmetic operations (+,-,*,/›
// on it. Here you can you switch case.
// Reference:https://docs.oracle.com/javase/tutorial/java/nutsand
// bolts/switch.html

public class Ques33 {
	public static void main(String[] args) {
		if (args.length < 4) {
			System.out.println("Usage: java Ques33 <int> <float> <double> <operation>");
			System.out.println("operation: +, -, *, /");
			return;
		}
		int intVal = Integer.parseInt(args[0]);
		float floatVal = Float.parseFloat(args[1]);
		double doubleVal = Double.parseDouble(args[2]);
		char op = args[3].charAt(0);

		switch (op) {
			case '+':
				System.out.println("int + float + double = " + (intVal + floatVal + doubleVal));
				break;
			case '-':
				System.out.println("int - float - double = " + (intVal - floatVal - doubleVal));
				break;
			case '*':
				System.out.println("int * float * double = " + (intVal * floatVal * doubleVal));
				break;
			case '/':
				if (floatVal == 0 || doubleVal == 0) {
					System.out.println("Division by zero error.");
				} else {
					System.out.println("int / float / double = " + (intVal / floatVal / doubleVal));
				}
				break;
			default:
				System.out.println("Invalid operation. Use +, -, * or /");
		}
	}
}
