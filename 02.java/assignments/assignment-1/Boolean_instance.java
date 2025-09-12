// 6. b  boolean value into Boolean instance

public class Boolean_instance{
    public static void main(String[] args) {
        boolean isLightOn = true;
        Boolean lightObj = Boolean.valueOf(isLightOn);
        System.out.println(lightObj);
    }
}