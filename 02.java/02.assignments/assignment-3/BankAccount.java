import java.util.ArrayList;
import java.util.Scanner;

class Bank {
    private String name;
    private String accnumber;
    private int balance;

    public Bank(String name, String accnumber, int balance) {
        this.name = name;
        this.accnumber = accnumber;
        this.balance = balance;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAccnumber(String accnumber) {
        this.accnumber = accnumber;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public String getName() {
        return name;
    }

    public String getAccnumber() {
        return accnumber;
    }

    public int getBalance() {
        return balance;
    }

    public void display() {
        System.out.println("Name : " + name + "  Account no : " + accnumber + "  Balance : " + balance);
    }
}

public class BankAccount {
    private ArrayList<Bank> bankList;

    public BankAccount() {
        bankList = new ArrayList<>();
    }

    public void addAccount(Bank ba) {
        bankList.add(ba);
        System.out.println("Account details added successfully.");
    }

    public void depositMoney(String accno, int amount) {
        boolean found = false;
        for (Bank bk : bankList) {
            if (bk.getAccnumber().equals(accno)) {
                bk.setBalance(bk.getBalance() + amount);
                System.out.println("Money Deposited...");
                found = true;
                break;
            }
        }
        if (!found) {
            System.out.println("You have no account, create one...");
        }
    }

    public void withdraw(String accno, int amount) {
        boolean found = false;
        for (Bank bk : bankList) {
            if (bk.getAccnumber().equals(accno)) {
                if (bk.getBalance() < amount) {
                    System.out.println("Insufficient balance...");
                } else {
                    bk.setBalance(bk.getBalance() - amount);
                    System.out.println("Money Withdrawn...");
                }
                found = true;
                break;
            }
        }
        if (!found) {
            System.out.println("You have no account, create one...");
        }
    }

    public void transfer(String fromAcc, String toAcc, int amount) {
        boolean fromFound = false, toFound = false;
        for (Bank bk : bankList) {
            if (bk.getAccnumber().equals(fromAcc)) {
                fromFound = true;
                if (bk.getBalance() < amount) {
                    System.out.println("Insufficient balance to transfer.");
                    return;
                } else {
                    bk.setBalance(bk.getBalance() - amount);
                }
            }
        }
        for (Bank bk : bankList) {
            if (bk.getAccnumber().equals(toAcc)) {
                toFound = true;
                bk.setBalance(bk.getBalance() + amount);
            }
        }
        if (fromFound && toFound) {
            System.out.println("Transfer successful.");
        } else if (!fromFound) {
            System.out.println("Source account not found.");
        } else if (!toFound) {
            System.out.println("Destination account not found.");
        }
    }

    public void displayAll() {
        if (bankList.isEmpty()) {
            System.out.println("No Bank Details in the Database.");
            return;
        }
        for (Bank bk : bankList) {
            bk.display();
        }
    }

    public static void main(String[] args) {
        BankAccount ba = new BankAccount();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("1. Add Account to Database");
            System.out.println("2. Deposit Money");
            System.out.println("3. Withdraw Money");
            System.out.println("4. Display Account Details");
            System.out.println("5. Transfer Money");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter account holder Name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter Account number: ");
                    String accno = scanner.nextLine();
                    System.out.print("Enter Account Balance: ");
                    int balance = scanner.nextInt();
                    scanner.nextLine();
                    Bank bank = new Bank(name, accno, balance);
                    ba.addAccount(bank);
                    break;
                case 2:
                    System.out.print("Enter Account number for deposit: ");
                    String depoAcc = scanner.nextLine();
                    System.out.print("Enter Deposit amount: ");
                    int depositAmt = scanner.nextInt();
                    scanner.nextLine();
                    ba.depositMoney(depoAcc, depositAmt);
                    break;
                case 3:
                    System.out.print("Enter Account number for Withdraw: ");
                    String withdrawAcc = scanner.nextLine();
                    System.out.print("Enter Withdrawal amount: ");
                    int withdrawAmt = scanner.nextInt();
                    scanner.nextLine();
                    ba.withdraw(withdrawAcc, withdrawAmt);
                    break;
                case 4:
                    ba.displayAll();
                    break;
                case 5:
                    System.out.print("Enter Source Account number: ");
                    String srcAcc = scanner.nextLine();
                    System.out.print("Enter Destination Account number: ");
                    String destAcc = scanner.nextLine();
                    System.out.print("Enter Transfer amount: ");
                    int transferAmt = scanner.nextInt();
                    scanner.nextLine();
                    ba.transfer(srcAcc, destAcc, transferAmt);
                    break;
                case 6:
                    System.out.println("Exit from the Bank.....");
                    scanner.close();
                    System.exit(0);
                    break;
                default:
                    System.out.println("Enter Valid Choice... Try again...");
            }
        }
    }
}
