# Exception Handling in Java

Exceptions are unwanted events which cause our program to terminate during its execution.
**Examples:** division by zero, null pointer exception, array index out of bound exception

## Exception Handling Keywords

- `try`
- `catch`
- `finally`
- `throw`
- `throws`

**try**: a block which contains the code which may cause exception  
**catch**: a block/handler which catches and handles the generated exception

Every exception in Java is an object of some exception class.

```java
try {
	// code which might generate exception
}
catch(ExceptionType1) {
}
catch(ExceptionType2) {
}
```

A try block can have multiple catch blocks.

---

## Example Program

```java
class MyExceptionDemo {
	public static void main(String args[]) {
		System.out.println("Program started");
		int a = 8;
		int b = 0;
		int res;

		try {
			res = a / b;
			System.out.println("Result = " + res);
		}
		catch (ArithmeticException ae) { // Exception Handler
			System.out.println("Arithmetic Exception Handled");
		}

		System.out.println("Program terminated successfully");
	}
}
```

**OUTPUT:**
```
Program started
Arithmetic Exception Handled
Program terminated successfully
```

---

## Example: Multiple Exceptions

```java
class MyExceptionDemo1 {
	public static void main(String args[]) {
		System.out.println("Program started");
		int a = 8;
		int b = 4;
		int res;

		int arr[] = {2,4,6,8,10};

		try {
			res = a / b;
			System.out.println("Result = " + res);

			// Printing array elements
			System.out.println("Array elements: ");
			for(int i = 0 ; i < 6; i++) {
				System.out.println(arr[i]);
			}
		}
		catch (ArithmeticException ae) {
			System.out.println("Arithmetic Exception Handled");
		}
		catch (ArrayIndexOutOfBoundsException abe) {
			System.out.println("ArrayIndexOutOfBound Exception Handled");
		}

		System.out.println("Program terminated successfully");
	}
}
```

---

## Notes

- Local variable must be initialized before its use.

---

## Example: Multiple Catch with Parent-Child Relationship

If there are multiple catch handlers with parent-child relationship, the child handler should come first before the parent handler.

---

## finally Block

- A block which must be executed independent of exception (whether exception is generated or not).
- Comes at the end of try-catch.
- A try block can have only one finally block.
- A try can exist with finally only and without any catch block.

---

## try-with-resources

We can use try-with-resources with any catch and finally block.

```java
try(FileReader fr = new FileReader("filepath")) {
	// code
}
```

---

## Multi-catch

A single catch block (multi-catch statement) can be used to handle multiple exceptions.

```java
try {
	// Code
}
catch(ArithmeticException | ArrayIndexOutOfBoundsException | NullPointerException e) {
}
```
- There must not be any parent-child relationship between exceptions in a multi-catch.

---

## Nested try-catch

```java
try {
	// code1
	try {
		// code2
	}
	catch(ExceptionType1) { }
	catch(ExceptionType2) { }
}
catch(ExceptionType3) { }
catch(ExceptionType4) { }
```

---

## printStackTrace() and getMessage() Methods

```java
class MyExceptionDemo7 {
	public static int doDivision(int a, int b) {
		int r = a / b;
		return r;
	}

	public static int doArithOperation(int a, int b) {
		int r = doDivision(a,b);
		return r;
	}

	public static void main(String args[]) {
		System.out.println("Program started");
		int a = 8;
		int b = 0;
		int res;

		try {
			res = doArithOperation(a,b);
			System.out.println("Result = "+ res);
		}
		catch(ArithmeticException e) {
			System.out.println("An exception is caught here");
			e.printStackTrace();
			// System.out.println(e.getMessage());
		}

		System.out.println("Program terminated successfully");
	}
}
```

---

## `throw` and `throws` Keywords

- `throw` is used to explicitly throw an exception object.
- `throws` is used with method signature to indicate that a method may throw the given list of exceptions.

```java
void myMethod1() throws IOException {
	// throw IOException which is not getting handled here
}
```

myMethod1() is saying "I may generate and throw IOException so whoever is calling me please handle this exception at your end".

---

## Checked and Unchecked Exceptions

- **Checked Exceptions:** Compiler forces us to handle them, otherwise code will not compile.  
  _Examples: IOException, FileNotFoundException_
- **Unchecked Exceptions:** Compiler does not force us to handle them.  
  _Examples: NullPointerException, ArithmeticException_

---

## Defining Custom Exception Classes

To create our own exception classes, extend:
- `Exception` for checked exception classes
- `RuntimeException` for unchecked exception classes

