/**
 * Question 18
 * Write a Java program to demonstrate synchronization by
 * using the synchronized keyword on a method that
 * increments a counter.
 */
public class Ques18 {
    
    // Shared counter class with synchronization
    static class SynchronizedCounter {
        private int count = 0;
        
        // Synchronized method to increment counter safely
        public synchronized void increment() {
            count++;
        }
        
        // Synchronized method to get current count safely
        public synchronized int getCount() {
            return count;
        }
    }
    
    // Worker thread to increment the synchronized counter
    static class CounterThread extends Thread {
        private final SynchronizedCounter counter;
        private final int incrementTimes;
        
        public CounterThread(SynchronizedCounter counter, int incrementTimes, String name) {
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
                if (i % 1000 == 0) {
                    System.out.println(getName() + " has incremented " + i + " times. Counter value: " + counter.getCount());
                }
                
                // Simulate some work to make threads more likely to interleave
                if (i % 100 == 0) {
                    try {
                        Thread.sleep(1);
                    } catch (InterruptedException e) {
                        System.out.println(getName() + " was interrupted.");
                    }
                }
            }
            
            System.out.println(getName() + " finished incrementing.");
        }
    }
    
    public static void main(String[] args) {
        // Create a synchronized counter
        SynchronizedCounter synchronizedCounter = new SynchronizedCounter();
        
        // Number of increments per thread (much larger to demonstrate synchronization)
        final int incrementsPerThread = 100000;
        
        // Expected final count if synchronization works correctly
        final int expectedCount = incrementsPerThread * 3; // 3 threads
        
        System.out.println("Synchronization demonstration started.");
        System.out.println("Each thread will increment the counter " + incrementsPerThread + " times.");
        System.out.println("Expected final count: " + expectedCount);
        
        long startTime = System.currentTimeMillis();
        
        // Create multiple threads that will increment the same counter
        Thread thread1 = new CounterThread(synchronizedCounter, incrementsPerThread, "Thread-1");
        Thread thread2 = new CounterThread(synchronizedCounter, incrementsPerThread, "Thread-2");
        Thread thread3 = new CounterThread(synchronizedCounter, incrementsPerThread, "Thread-3");
        
        // Start all threads
        thread1.start();
        thread2.start();
        thread3.start();
        
        try {
            // Wait for all threads to complete
            thread1.join();
            thread2.join();
            thread3.join();
            
            long endTime = System.currentTimeMillis();
            
            // Print final result
            System.out.println("\nAll threads completed.");
            System.out.println("Final counter value: " + synchronizedCounter.getCount());
            System.out.println("Expected counter value: " + expectedCount);
            System.out.println("Time taken: " + (endTime - startTime) + " milliseconds");
            
            if (synchronizedCounter.getCount() == expectedCount) {
                System.out.println("SUCCESS! The synchronization worked correctly.");
                System.out.println("The synchronized keyword ensured that only one thread could increment the counter at a time,");
                System.out.println("preventing race conditions and ensuring data consistency.");
            } else {
                System.out.println("Something went wrong. The final count does not match the expected count.");
                System.out.println("This is unexpected with proper synchronization.");
            }
            
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting for worker threads.");
        }
        
        // Compare with Ques17's unsynchronized counter
        System.out.println("\nUnlike Ques17's unsynchronized counter, this implementation:");
        System.out.println("1. Uses the 'synchronized' keyword on methods that access shared data");
        System.out.println("2. Ensures atomic operations on the shared counter");
        System.out.println("3. Prevents race conditions by allowing only one thread to execute the synchronized methods at a time");
    }
}