# Generics in Java

Generics (parameterized types) allow the same logic to be applied to different data types. Generics work only with objects, not primitives.

---

## Example: Generic Class

```java
class MyGen <T>
{
    T data;

    MyGen(T data)
    {
        this.data = data;
    }

    T getData()
    {
        return data;
    }
}
```

---

## Example: Using Generics

```java
class Student
{
    int roll;
    String name;

    Student(int roll, String name)
    {
        this.roll = roll;
        this.name = name;
    }

    public String toString()
    {
        return "Student[roll = " + roll + ", name = " + name + "]";
    }
}

class MyGenDemo
{
    public static void main(String args[])
    {
        MyGen <Integer> mg1 = new MyGen<Integer>(100);
        int ival = mg1.getData();
        System.out.println(ival);

        MyGen <String> mg2 = new MyGen<String>("Hello");
        String sval = mg2.getData();
        System.out.println(sval);

        Student s = new Student(1,"Mohit");

        MyGen <Student> mg3 = new MyGen<Student>(s);
        Student stud = mg3.getData();
        System.out.println(stud);
    }
}
```

**Output:**
```
100
Hello
Student[roll = 1, name = Mohit]
```

---

## Non-generic Implementation

- Requires explicit casting
- No type safety

---

## Type Erasure

Type parameter is removed after compilation (type erasure).

---

## Multiple Type Parameters

```java
class MyGen <T1,T2>
{
    T1 data1;
    T2 data2;

    MyGen(T1 data1, T2 data2)
    {
        this.data1 = data1;
        this.data2 = data2;
    }

    T1 getData1() { return data1; }
    T2 getData2() { return data2; }
}
```

---

## Bounded Type Parameters

```java
class MyGen <T extends Number>
{
}
```

---

## Method Level Type Parameter

```java
<T1 extends Number> void show(T1 ob)
{
    System.out.println(ob);
}
```

---

## Wildcards

- `MyGen<?>` — any type
- `MyGen<? extends Number>` — Number or its subclasses
- `MyGen<? super First>` — any parent class of First

---

## Generic Interface

```java
interface MyInterface <T>
{
    void myFun(T data);
}
```

---

## Inheriting Generic Class

```java
class MyClass1 <T> { }
class MyClass2 extends MyClass1 <Integer> { }
class MyClass2<T> extends MyClass1 <T> { }
```

---

> **Note:** `MyGen<Integer>` is not a child of `MyGen<Number>`.
