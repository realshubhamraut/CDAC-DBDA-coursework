class PaymentTimeoutException extends Exception {
    public PaymentTimeoutException(String msg) { super(msg); }
}
class InvalidCardException extends Exception {
    public InvalidCardException(String msg) { super(msg); }
}
class InsufficientFundsException extends Exception {
    public InsufficientFundsException(String msg) { super(msg); }
}

public class PaymentHandler {
    public static void main(String[] args) {
        String card = "1234567891012131";   // wrong length (not 16 digits)
        double amount = 200;
        double balance = 1500000;
        boolean timeout = false;

        try {
            if (timeout)
                throw new PaymentTimeoutException("Payment timed out.");
            if (card == null || card.length() != 16)
                throw new InvalidCardException("Invalid card details.");
            if (balance < amount)
                throw new InsufficientFundsException("Insufficient funds.");

            System.out.println("Payment successful: $" + amount);

        } catch (PaymentTimeoutException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (InvalidCardException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (InsufficientFundsException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
