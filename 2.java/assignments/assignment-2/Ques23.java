// Create an abstract class Payment with an abstract method payAmount () . Create
// subclasses CreditCardPayment and UPI Payment that implement it differently.


abstract class Payment{
    abstract public void payAmount();


}


class CreditCardPayment extends Payment{
    int CreditNum;
    public CreditCardPayment(int CreditNum){
        this.CreditNum = CreditNum;
    }
    public void payAmount(){
        System.out.println("Payment done with using the Credit Card with number " + CreditNum);
    }
}


class UPIPayment extends Payment{
    int upiNum;
    public UPIPayment(int upiNum){
        this.upiNum= upiNum;
    }

    public void payAmount(){
        System.out.println("Payment done using UPI with number " + upiNum);
    }
}
public class Ques23 {
    public static void main(String[] args){
        UPIPayment u = new UPIPayment(12341);
        CreditCardPayment c = new CreditCardPayment(14114);  
        c.payAmount();
        u.payAmount();

    }
}
