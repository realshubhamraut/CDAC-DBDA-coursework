/**
 * Question 17
 * Write a Java program to demonstrate how multiple
 * threads can access a shared counter variable. Show the
 * problem of race condition (without synchronization).
 */
public class Ques17 {
    
    // Shared counter class without synchronization
    static class SharedCounter {
        private int count = 0;
        
        // Method to increment counter without synchronization
        public void increment() {
            // Read current value
            int temp = count;
            
            // Simulate some processing time that makes race condition more likely
            try {
                Thread.sleep(1); 
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            
            // Update the value (this is where the race condition can occur)
            count = temp + 1;
        }
        
        // Get current count
        public int getCount() {
            return count;
        }
    }
    
    // Worker thread to increment the shared counter
    static class CounterThread extends Thread {
        private final SharedCounter counter;
        private final int incrementTimes;
        
        public CounterThread(SharedCounter counter, int incrementTimes, String name) {
            super(name);
            this.counter = counter;
            this.incrementTimes = incrementTimes;
        }
        
        @Override
        public void run() {
            System.out.println(getName() + " started incrementing the counter...");
            
            for (int i = 0; i < incrementTimes; i++) {
                counter.increment();
                
                // Print progress occasionally
                if (i % 10 == 0) {
                    System.out.println(getName() + " has incremented " + i + " times. Counter value: " + counter.getCount());
                }
            }
            
            System.out.println(getName() + " finished incrementing. Final count from thread's perspective: " + counter.getCount());
        }
    }
    
    public static void main(String[] args) {
        // Create a shared counter
        SharedCounter sharedCounter = new SharedCounter();
        
        // Number of increments per thread
        final int incrementsPerThread = 100;
        
        // Expected final count if everything worked correctly
        final int expectedCount = incrementsPerThread * 3; // 3 threads
        
        System.out.println("Race condition demonstration started.");
        System.out.println("Expected final count (if no race condition): " + expectedCount);
        
        // Create multiple threads that will increment the same counter
        Thread thread1 = new CounterThread(sharedCounter, incrementsPerThread, "Thread-1");
        Thread thread2 = new CounterThread(sharedCounter, incrementsPerThread, "Thread-2");
        Thread thread3 = new CounterThread(sharedCounter, incrementsPerThread, "Thread-3");
        
        // Start all threads
        thread1.start();
        thread2.start();
        thread3.start();
        
        try {
            // Wait for all threads to complete
            thread1.join();
            thread2.join();
            thread3.join();
            
            // Print final result
            System.out.println("\nAll threads completed.");
            System.out.println("Final counter value: " + sharedCounter.getCount());
            System.out.println("Expected counter value: " + expectedCount);
            
            if (sharedCounter.getCount() != expectedCount) {
                System.out.println("RACE CONDITION DETECTED! The final count is less than expected.");
                System.out.println("This happens because threads interfere with each other when updating the shared variable.");
                System.out.println("Without synchronization, one thread's updates can overwrite another's.");
            } else {
                System.out.println("Surprisingly, no race condition was detected in this run.");
                System.out.println("Try running the program again, as race conditions are non-deterministic.");
            }
            
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting for worker threads.");
        }
    }
}