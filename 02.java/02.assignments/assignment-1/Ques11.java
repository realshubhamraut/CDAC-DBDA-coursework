// 11. Accept character from command line and perform below
// operations. Here you can use charAt () method to extract
// character:
// a. Check whether entered character is letter or digit. If it
// is digit then print its values as well as code point.
// b. If it is character then check whether it is in lowercase?
// If it is in lowercase then convert it into upper case and
// print it well as its code point. If it is in uppercase
// then convert it into lower case and print it well as its
// code point.

public class Ques11 {
	public static void main(String[] args) {
		if (args.length == 0 || args[0].length() == 0) {
			System.out.println("Please provide a character as a command line argument.");
			return;
		}
		char ch = args[0].charAt(0);

		if (Character.isDigit(ch)) {
			System.out.println("Entered character is a digit.");
			System.out.println("Value: " + ch);
			System.out.println("Code point: " + (int) ch);
		} else if (Character.isLetter(ch)) {
			System.out.println("Entered character is a letter.");
			if (Character.isLowerCase(ch)) {
				char upper = Character.toUpperCase(ch);
				System.out.println("Lowercase detected. Converted to uppercase: " + upper);
				System.out.println("Code point: " + (int) upper);
			} else if (Character.isUpperCase(ch)) {
				char lower = Character.toLowerCase(ch);
				System.out.println("Uppercase detected. Converted to lowercase: " + lower);
				System.out.println("Code point: " + (int) lower);
			}
		} else {
			System.out.println("Entered character is neither a letter nor a digit.");
		}
	}
}
