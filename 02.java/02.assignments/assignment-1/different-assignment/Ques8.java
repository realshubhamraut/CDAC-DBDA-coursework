//8. Print the average of three numbers entered by the user by creating a class named 'Average'
//having a method to calculate and print the average.

import java.util.Scanner;

class Average{
	int a, b, c;
	int aver;
	
	public double printAvg() {
		Scanner sc = new Scanner(System.in);
		
		System.out.println("Enter three nums");
		a = sc.nextInt();
		b = sc.nextInt();
		c = sc.nextInt();
		double avg = (a+b+c) /3.0;
		return avg;
		
		
		
		
	}
}

public class Ques8 {
	public static void main(String[] args) {
		Average a = new Average();
		System.out.println("Average of three nums: " + a.printAvg());
		
	}
}
