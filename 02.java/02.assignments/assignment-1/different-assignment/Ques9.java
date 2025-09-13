//
//9. Print the sum, difference and product of two complex numbers by creating a class named
//'Complex' with separate methods for each operation whose real and imaginary parts are entered by
//the user.


import java.util.*;

class Complex {
    double real, imag;

    Complex(double r, double i) {
        real = r;
        imag = i;
    }

    Complex add(Complex o) {
        return new Complex(real + o.real, imag + o.imag);
    }

    Complex sub(Complex o) {
        return new Complex(real - o.real, imag - o.imag);
    }

    Complex mul(Complex o) {
        double realPart = real * o.real - imag * o.imag;
        double imagPart = real * o.imag + imag * o.real;
        return new Complex(realPart, imagPart);
    }

    void print() {
        System.out.println(real + " + " + imag + "i");
    }
}
public class Ques9 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        double r1 = sc.nextDouble();
        double i1 = sc.nextDouble();
        double r2 = sc.nextDouble();
        double i2 = sc.nextDouble();

        Complex c1 = new Complex(r1, i1);
        Complex c2 = new Complex(r2, i2);

        Complex sum = c1.add(c2);
        Complex diff = c1.sub(c2);
        Complex prod = c1.mul(c2);

        sum.print();
        diff.print();
        prod.print();

        sc.close();
    }
}



