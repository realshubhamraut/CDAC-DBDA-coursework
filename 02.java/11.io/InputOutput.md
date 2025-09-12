# Input/Output in Java

Java provides various classes for input and output (I/O) through the `java.io` and `java.nio` packages.

## Key Concepts

- **Streams:** Sequence of data. Input streams read data, output streams write data.
	- `InputStream`, `OutputStream` (for byte streams)
	- `Reader`, `Writer` (for character streams)
- **File I/O:** Reading from and writing to files using classes like `FileInputStream`, `FileOutputStream`, `FileReader`, `FileWriter`.
- **Buffered Streams:** Improve efficiency by reducing the number of I/O operations (e.g., `BufferedReader`, `BufferedWriter`).
- **Serialization:** Saving objects to a stream using `ObjectOutputStream` and reading them back with `ObjectInputStream`.

## Example: Reading a File

```java
import java.io.*;

public class ReadFileExample {
	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader("input.txt"));
		String line;
		while ((line = br.readLine()) != null) {
			System.out.println(line);
		}
		br.close();
	}
}
```

## Example: Writing to a File

```java
import java.io.*;

public class WriteFileExample {
	public static void main(String[] args) throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter("output.txt"));
		bw.write("Hello, world!\n");
		bw.close();
	}
}
```

---

> **Note:** Always close streams after use to free system resources. Use try-with-resources for automatic closing.

