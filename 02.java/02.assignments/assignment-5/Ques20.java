/**
 * Question 20
 * Write a Java program where two threads run in parallel:
 * • The first thread prints "Learning Java" 5 times.
 * • The second thread prints "Multithreading in action" 5 times.
 */
public class Ques20 {
    
    static class MessagePrinterThread extends Thread {
        private final String message;
        private final int times;
        private final int delayMillis;
        
        public MessagePrinterThread(String message, int times, int delayMillis) {
            this.message = message;
            this.times = times;
            this.delayMillis = delayMillis;
        }
        
        @Override
        public void run() {
            try {
                for (int i = 0; i < times; i++) {
                    // Print the message with thread name and count
                    System.out.println(Thread.currentThread().getName() + ": " + message + " (Time " + (i+1) + ")");
                    
                    // Add a small delay
                    Thread.sleep(delayMillis);
                }
            } catch (InterruptedException e) {
                System.out.println(Thread.currentThread().getName() + " was interrupted.");
            }
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Starting two parallel threads...");
        
        // Create first thread that prints "Learning Java" 5 times
        Thread thread1 = new MessagePrinterThread("Learning Java", 5, 200);
        thread1.setName("Thread-1");
        
        // Create second thread that prints "Multithreading in action" 5 times
        Thread thread2 = new MessagePrinterThread("Multithreading in action", 5, 300);
        thread2.setName("Thread-2");
        
        // Start both threads
        thread1.start();
        thread2.start();
        
        try {
            // Wait for both threads to complete
            thread1.join();
            thread2.join();
            
            System.out.println("Both threads have completed their execution.");
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting for worker threads to complete.");
        }
    }
}