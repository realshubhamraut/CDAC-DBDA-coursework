// Question 6.a


public class BooleanToString {
    public static void main(String[] args) {
        boolean isLightOn = true;
        boolean isRaining = false;
        
        String lightStatus = String.valueOf(isLightOn);
        String rainStatus = String.valueOf(isRaining);

        System.out.println("Light is: " + lightStatus);      
        System.out.println("Raining: " + rainStatus);

    }
}

