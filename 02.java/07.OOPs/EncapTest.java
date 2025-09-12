// Simplest encapsulation example
public class EncapTest {
   private String name; // private field

   // Getter method
   public String getName() {
      return name;
   }

   // Setter method
   public void setName(String name) {
      this.name = name;
   }

   // Main method to demonstrate encapsulation
   public static void main(String[] args) {
      EncapTest obj = new EncapTest();
      obj.setName("Alice"); // set value using setter
      System.out.println(obj.getName()); // get value using getter
   }
}