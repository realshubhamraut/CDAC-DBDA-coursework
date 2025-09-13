class BankAccount {
    int accountNumber;
    String holderName;
    double balance;

    // Constructor 1: Only accountNumber
    BankAccount(int accountNumber) {
        this.accountNumber = accountNumber;
        System.out.println("Account Number: " + accountNumber);
    }

    // Constructor 2: accountNumber and holderName
    BankAccount(int accountNumber, String holderName) {
        this(accountNumber); // Calls constructor 1
        this.holderName = holderName;
        System.out.println("Holder Name: " + holderName);
    }

    // Constructor 3: accountNumber, holderName, and balance
    BankAccount(int accountNumber, String holderName, double balance) {
        this(accountNumber, holderName); // Calls constructor 2
        this.balance = balance;
        System.out.println("Balance: " + balance);
    }

    void display() {
        System.out.println("Account Number: " + accountNumber +
                           ", Holder Name: " + holderName +
                           ", Balance: " + balance);
    }
}

public class Ques5a {
    public static void main(String[] args) {
        BankAccount b1 = new BankAccount(1001);
        b1.display();
        System.out.println("---");
        BankAccount b2 = new BankAccount(1002, "Alice");
        b2.display();
        System.out.println("---");
        BankAccount b3 = new BankAccount(1003, "Bob", 5000.0);
        b3.display();
    }
}