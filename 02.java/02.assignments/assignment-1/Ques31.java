// 31. Read the documentation of NumberFormatException and try to
// generate it in Java code.
// Reference:https://docs.oracle.com/javase/8/docs/api/java/lang/
// NumberFormatException.html

public class Ques31 {
	public static void main(String[] args) {
		String invalidNumber = "abc123";
		try {
			int num = Integer.parseInt(invalidNumber);
			System.out.println("Parsed number: " + num);
		} catch (NumberFormatException e) {
			System.out.println("NumberFormatException caught: " + e.getMessage());
		}
	}
}
