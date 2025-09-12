// Create a class CurrencyConverter that has overloaded methods to convert different
// currencies (INR to USD, INR to EUR, USD to INR, EUR to INR, etc.).







class CurrencyConverter {
    // INR to USD
    public void convert(double inr) {
        System.out.println(inr + " INR = " + (inr / 80) + " USD");
    }

    public void convert(int inr) {
        System.out.println(inr + " INR = " + (inr / 90) + " EUR");
    }

    public void convertUSD(double usd) {
        System.out.println(usd + " USD = " + (usd * 80) + " INR");
    }

    public void convertEUR(double eur) {
        System.out.println(eur + " EUR = " + (eur * 90) + " INR");
    }
}

public class Ques15 {
    public static void main(String[] args) {
        CurrencyConverter cc = new CurrencyConverter();
        cc.convert(800.0);   
        cc.convert(900);        
        cc.convertUSD(10.0);    
        cc.convertEUR(10.0);   
    }
}

