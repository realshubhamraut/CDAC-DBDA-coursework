class Order {
    int orderId;
    String customerName;
    double totalAmount;

    // Constructor 1: Only orderId
    Order(int orderId) {
        this.orderId = orderId;
        System.out.println("OrderId: " + orderId);
    }

    // Constructor 2: orderId and customerName
    Order(int orderId, String customerName) {
        this(orderId); // Calls constructor 1
        this.customerName = customerName;
        System.out.println("Customer Name: " + customerName);
    }

    // Constructor 3: orderId, customerName, and totalAmount
    Order(int orderId, String customerName, double totalAmount) {
        this(orderId, customerName); // Calls constructor 2
        this.totalAmount = totalAmount;
        System.out.println("Total Amount: " + totalAmount);
    }
}

public class Ques4a {
    public static void main(String[] args) {
        Order o1 = new Order(101);
        System.out.println("---");
        Order o2 = new Order(102, "Alice");
        System.out.println("---");
        Order o3 = new Order(103, "Bob", 2500.50);
    }
}