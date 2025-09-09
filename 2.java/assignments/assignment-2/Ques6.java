// Create a class BankAccount with private attributes accountNumber and balance. Use
// getters and setters to access and modify them.

class BankAccount{
    private int accountNumber;
    private int balance;

    // Default constructor
    public BankAccount() {
        this.accountNumber = 0;
        this.balance = 0;
    }

    // Parameterized constructor
    public BankAccount(int accountNumber, int balance){
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public int getaccountNumber(){
        return accountNumber;
    }

    public int getbalance(){
        return balance;
    }


    public void setaccountNumber(int accountNumber){
        this.accountNumber = accountNumber;
    }

    public void setbalance(int balance){
        this.balance = balance;
    }
}







public class Ques6 {
    public static void main(String[] args){
        BankAccount bk = new BankAccount();

        System.out.println("Account number: "+bk.getaccountNumber());
        System.out.println("Balance: "+bk.getbalance());


        bk.setaccountNumber(1222);
        bk.setbalance(900);


        System.out.println("Account number: "+bk.getaccountNumber());
        System.out.println("Balance: "+bk.getbalance());
    }
    
}
