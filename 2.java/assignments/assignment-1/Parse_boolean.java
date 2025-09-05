//6. b string value into boolean value
// "true" (in any case) are allowed in (converted to true).
// Everyone else - whether they say "zebra", "hello", "yes", "1",
// or anything else - gets turned away (converted to false).
public class Parse_boolean {
    public static void main(String args[]){
        String door = "true";
        boolean isDoorOpen = Boolean.parseBoolean(door);
        System.out.println(door);
        System.out.println(isDoorOpen);


    }
}

