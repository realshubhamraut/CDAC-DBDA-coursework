/**
 * Question 16
 * Write a Java program where one thread prints the
 * lowercase alphabet (a to z), and another thread prints the
 * uppercase alphabet (A to Z).
 */
public class Ques16 {
    
    // Thread class to print alphabets
    static class AlphabetPrinterThread extends Thread {
        private final boolean uppercase;
        private final int delayMillis;
        
        public AlphabetPrinterThread(boolean uppercase, int delayMillis) {
            this.uppercase = uppercase;
            this.delayMillis = delayMillis;
        }
        
        @Override
        public void run() {
            try {
                // Determine starting character based on case
                char startChar = uppercase ? 'A' : 'a';
                String threadType = uppercase ? "Uppercase" : "Lowercase";
                
                System.out.println(threadType + " thread started...");
                
                // Print 26 letters of the alphabet
                for (int i = 0; i < 26; i++) {
                    char currentChar = (char) (startChar + i);
                    System.out.println(threadType + " thread: " + currentChar);
                    
                    // Add a small delay to make the output more readable
                    Thread.sleep(delayMillis);
                }
                
                System.out.println(threadType + " thread finished.");
            } catch (InterruptedException e) {
                System.out.println("Thread was interrupted while printing alphabets.");
            }
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Starting alphabet printer threads...");
        
        // Create threads for lowercase and uppercase alphabets
        Thread lowercaseThread = new AlphabetPrinterThread(false, 100);
        Thread uppercaseThread = new AlphabetPrinterThread(true, 150);
        
        // Start both threads
        lowercaseThread.start();
        uppercaseThread.start();
        
        try {
            // Wait for both threads to complete
            lowercaseThread.join();
            uppercaseThread.join();
            
            System.out.println("Both alphabet printer threads have completed.");
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting for alphabet printer threads.");
        }
    }
}