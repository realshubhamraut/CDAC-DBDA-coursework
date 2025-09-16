/**
 * Question 1
 * Write a Java program to create and run a thread by
 * extending the Thread class. The thread should print
 * "Hello from Thread" five times.
 */
public class Ques1 extends Thread {
    
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println("Hello from Thread");
            
            // Adding a small delay to make the output clearer
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                System.out.println("Thread was interrupted");
            }
        }
    }
    
    public static void main(String[] args) {
        // Create a new thread
        Ques1 thread = new Ques1();
        
        // Start the thread - this will call the run() method
        thread.start();
        
        System.out.println("Main method finished");
    }
}