// 4. polymorphism - method overriding example
class Animal {
    void sound(){
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    void sound(){
        System.out.println("Dog barks");
    }
} 


public class TestOverride{
    public static void main(String[] args){
        Animal a = new Animal();
        a.sound(); //animal makes a sound

        Dog d = new Dog();
        d.sound(); // dog barks

        Animal a2 = new Dog();
        a2.sound(); // dog barks
    }
}