/**
 * Question 3
 * Write a Java program where the main thread prints "Main
 * Thread Running" and a child thread prints "Child Thread
 * Running". Run them simultaneously.
 */
public class Ques3 {
    
    // Child thread class
    static class ChildThread extends Thread {
        @Override
        public void run() {
            for (int i = 0; i < 5; i++) {
                System.out.println("Child Thread Running");
                
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    System.out.println("Child thread was interrupted");
                }
            }
        }
    }
    
    public static void main(String[] args) {
        // Create and start child thread
        ChildThread childThread = new ChildThread();
        childThread.start();
        
        // Main thread prints its message
        for (int i = 0; i < 5; i++) {
            System.out.println("Main Thread Running");
            
            try {
                Thread.sleep(150);
            } catch (InterruptedException e) {
                System.out.println("Main thread was interrupted");
            }
        }
        
        // Wait for child thread to complete (optional)
        try {
            childThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted while waiting for child");
        }
        
        System.out.println("All threads finished execution");
    }
}