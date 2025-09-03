public class BooleanBoxing {
    public static void main(String[] args) {
        // Create primitive boolean values
        boolean isHappy = true;
        boolean isTired = false;
        
        // Convert boolean to Boolean object using auto-boxing
        // Java automatically wraps the primitive in an object
        Boolean happyObject = isHappy;  // auto-boxing happens here
        Boolean tiredObject = isTired;  // auto-boxing happens here
        
        // Display the results
        System.out.println("Original boolean: " + isHappy);
        System.out.println("Boolean object: " + happyObject);
        System.out.println("Original boolean: " + isTired);
        System.out.println("Boolean object: " + tiredObject);
        
        // Prove they are objects by checking their type
        System.out.println("happyObject is a: " + happyObject.getClass().getSimpleName());
        System.out.println("tiredObject is a: " + tiredObject.getClass().getSimpleName());
    }
}