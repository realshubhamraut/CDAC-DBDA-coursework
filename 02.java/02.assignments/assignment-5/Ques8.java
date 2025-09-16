/**
 * Question 8
 * Write a Java program where the main thread waits for a
 * child thread to finish using the join() method.
 */
public class Ques8 {
    
    // Child thread class that performs a time-consuming task
    static class WorkerThread extends Thread {
        private final int workDuration;
        
        public WorkerThread(String name, int seconds) {
            super(name);
            this.workDuration = seconds;
        }
        
        @Override
        public void run() {
            System.out.println(getName() + " has started working");
            
            // Simulate a time-consuming task
            try {
                for (int i = 1; i <= workDuration; i++) {
                    System.out.println(getName() + " is working... (" + i + "/" + workDuration + ")");
                    Thread.sleep(1000); // Sleep for 1 second
                }
                System.out.println(getName() + " has completed its work");
            } catch (InterruptedException e) {
                System.out.println(getName() + " was interrupted");
            }
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create a worker thread that will run for 5 seconds
        WorkerThread workerThread = new WorkerThread("Worker-Thread", 5);
        
        System.out.println("Starting the worker thread...");
        workerThread.start();
        
        System.out.println("Main thread will now wait for the worker thread to finish");
        
        try {
            // Main thread waits for worker thread to complete using join()
            System.out.println("Main thread calling join() on worker thread");
            workerThread.join();
            
            // This code will only execute after the worker thread has finished
            System.out.println("Worker thread has finished, main thread can continue");
            
            // Demonstrate join with timeout
            WorkerThread anotherWorker = new WorkerThread("Another-Worker", 10);
            anotherWorker.start();
            
            System.out.println("Main thread will wait for Another-Worker for max 3 seconds");
            anotherWorker.join(3000); // Wait for max 3 seconds
            
            // This will execute after either the thread completes or 3 seconds pass
            if (anotherWorker.isAlive()) {
                System.out.println("Another-Worker is still running after 3 seconds, but main thread continues");
            } else {
                System.out.println("Another-Worker completed within 3 seconds");
            }
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting");
        }
        
        System.out.println("Main thread finished its execution");
    }
}