// 32. Write a program to accept and print full name as an argument
// from command line.
public class Ques32 {
	public static void main(String[] args) {
		if (args.length == 0) {
			System.out.println("Please provide your full name as a command line argument.");
			return;
		}
		StringBuilder fullName = new StringBuilder();
		for (String arg : args) {
			fullName.append(arg).append(" ");
		}
		System.out.println("Full Name: " + fullName.toString().trim());
	}
}
