
a

# Java Basics

---

## 1. Introduction to Java

- Java is a high-level, object-oriented programming language developed by Sun Microsystems (now Oracle).
- Java code is compiled into bytecode, which runs on the Java Virtual Machine (JVM).
- Platform-independent: "Write Once, Run Anywhere" (WORA).

---

## 2. Structure of a Java Program

- Every Java application must have a `main` method as the entry point:

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello, world!");
    }
}
```

- The filename should match the public class name (e.g., `Hello.java`).
- Classes are required; variables cannot be declared in the global scope directly (unlike Python).
- The `main` method signature: `public static void main(String[] args)`
    - `public`: accessible from anywhere
    - `static`: belongs to the class, not an instance
    - `void`: returns nothing
    - `String[] args`: command-line arguments

---

## 3. JVM, JIT, and Memory Management

- **JVM (Java Virtual Machine):** Executes Java bytecode, provides platform independence.
- **JIT (Just-In-Time Compiler):** Frequently used code is compiled at runtime for faster execution.
- **Heap vs Stack:**
    - Heap: Stores objects, is expandable, starts from the top of memory.
    - Objects are stored in the heap; references/instances are stored in the stack.

---

## 4. Naming Conventions


---

## 5. Data Types and Variables

- Primitive types: `int`, `float`, `double`, `char`, `boolean`, `byte`, `short`, `long`
- Reference types: `String`, arrays, objects

## 6. Access Modifiers

- `public`: accessible everywhere
- `private`: accessible only within the class
- `protected`: accessible within the package and subclasses
- (default): accessible within the package
## 7. Key Concepts

- **Object-Oriented:** Everything is part of a class/object
- **Encapsulation:** Data hiding using access modifiers
- **Inheritance:** Classes can inherit properties from other classes
- **Polymorphism:** Methods can be overridden or overloaded
## 8. Other Basics

- `args` refers to command-line arguments
- `System.out.println()` is used for output
- Java is case-sensitive
- Comments: `// single-line`, `/* multi-line */`
## 9. Example: Hello World

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
```

---
## 10. Compilation and Execution

1. Save your file as `HelloWorld.java`
3. Run: `java HelloWorld`

---


- Java programs can be run from any drive/partition (e.g., C: or D:), as long as the JVM can access them.
- Heap and stack separation helps avoid variable name collisions in different scopes.

---

## 12. Summary Table

| Concept         | Description                                      |
|-----------------|--------------------------------------------------|
| JVM             | Runs Java bytecode, platform independence        |
| JIT             | Compiles code at runtime for speed               |
| Heap            | Stores objects, expandable                       |
| Stack           | Stores method calls/local vars, limited          |
| main method     | Entry point of Java program                      |
| Class name      | Should match filename, start with capital letter |
| args            | Command-line arguments                           |
| System.out      | Used for output                                  |


the java compiler can compiles the code without caring about if you have put the same file and class name

there is the java.lang package which is already loaded while programmming without specifically mentioning it, but after compiles we cannot really call the class with the filesname, because the class name declared is not matching with the filename itself.

but we don't really need the file name and classname to be the same if we are running the compiled class name with the proper class name
filename = javaclass.java
classname = javaclass1


while we need to import other packages. like `utils` and `io`

the java compiler can compiles the code without caring about if you have put the same file and class name

in java by default boolean values is false
and character values by default is null



z