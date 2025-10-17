## Table of Contents
1. [Python Basics - Day 1](#day-1)
2. [Control Flow & Strings - Day 2](#day-2)
3. [Data Structures - Day 3](#day-3)
4. [Functions - Day 4](#day-4)
5. [File Handling - Day 5](#day-5)
6. [Object-Oriented Programming - Day 6](#day-6)
7. [Data Structures Implementation - Day 7](#day-7)
8. [Trees and Graphs - Day 8](#day-8)
9. [Regular Expressions & Web Scraping - Day 9](#day-9)

---

<a id="day-1"></a>
## Day 1: Python Basics

### Understanding Variables and Data Types

```python
# Basic variable assignment
a = 10
b = 20
c = 30
d = a + b + c
print(d)
```

```python
# Python's dynamic typing system
# Data type is decided by the value assigned
# Main data types: int, float, str, bool, complex

# Check data type using type()
x = 10
print(type(x))  # <class 'int'>

y = 3.14
print(type(y))  # <class 'float'>

z = "Hello"
print(type(z))  # <class 'str'>

flag = True
print(type(flag))  # <class 'bool'>
```

### Important Concepts: Comments

```python
# Single line comment

'''
Multi-line comment
Line 2
Line 3
'''

"""
Another way for
multi-line comments
"""
```

### Variable Assignment Patterns

```python
# 1. Chained Assignment - all variables get same value
a = b = c = 10
print(a, b, c)  # Output: 10 10 10

# 2. Multiple Assignment - assign different values at once
x, y, z = 10, 3.14, "amar"
print(x, y, z)  # Output: 10 3.14 amar
```

### Memory Management in Python

```python
# id() function returns memory reference
a = 10
print(f"Value: {a}, Memory Reference: {id(a)}")

# Python creates new memory location when value changes
a = a - 5
print(f"Value: {a}, Memory Reference: {id(a)}")
# Note: The memory reference will be different
```

### Print Statement Variations

```python
# Different ways to print
print("message")
print('message')
print('''message''')
print("""message""")

# Printing variables
a = 10
print(a, "is a")           # Simple print
print("a is", a)           # Variables with text
print(f"{a} is a")         # f-string (recommended)
print(f"a is {a}")         # f-string with variable
```

### Taking User Input

```python
# input() always returns string
name = input("Enter your name: ")
print(f"{name} is of type {type(name)}")

# Type casting for numeric input
age = int(input("Enter age: "))
print(f"{age} is of type {type(age)}")

price = float(input("Enter price: "))
print(f"{price} is of type {type(price)}")
```

### Arithmetic Operators

```python
# Basic operators
print(5 + 2)   # Addition: 7
print(5 - 2)   # Subtraction: 3
print(5 * 2)   # Multiplication: 10
print(5 / 2)   # Division: 2.5 (float result)

# Special operators
print(5 // 2)  # Floor division: 2 (integer result)
print(5 % 2)   # Modulus (remainder): 1
print(5 ** 2)  # Exponentiation: 25

# Practical uses
print(29 // 10)  # Get first digit: 2
print(29 % 10)   # Get last digit: 9
```

### Practice: Basic Programs

```python
# Program 1: Currency Converter (INR to USD)
amount_inr = float(input("Enter amount in INR: "))
amount_usd = amount_inr / 90
print(f"{amount_inr} INR is {amount_usd} USD")
```

### Conditional Statements - if, elif, else

```python
# Simple if-else
name = input("Enter name: ")
age = int(input("Enter age: "))

if age < 18:
    print(f"{name}, at age {age} you cannot vote")
else:
    print(f"{name}, at age {age} you can vote")
```

```python
# if-elif-else for multiple conditions
number = int(input("Enter number: "))

if number > 0:
    print(f"{number} is positive")
elif number < 0:
    print(f"{number} is negative")
else:
    print(f"{number} is ZERO")
```

```python
# Grading system example
percentage = float(input("Enter your percentage: "))

if percentage >= 60:
    print(f"{percentage}% - First Class")
elif percentage >= 50:
    print(f"{percentage}% - Second Class")
elif percentage >= 40:
    print(f"{percentage}% - Third Class")
else:
    print(f"{percentage}% - Better luck next time")
```

### Important Python Technique: Swapping Variables

```python
# Python's elegant swap (no temporary variable needed)
a, b = 10, 20
print(f"Before swap - a: {a}, b: {b}")

a, b = b, a
print(f"After swap - a: {a}, b: {b}")
```

### Multiple Inputs in One Line

```python
# Using map() to convert multiple inputs
a, b, c = map(int, input("Enter 3 numbers separated by commas: ").split(','))
print(a, b, c)

# Date input example
dd, mm, yyyy = map(int, input("Enter date in dd/mm/yyyy format: ").split('/'))
print(f"Day: {dd}\nMonth: {mm}\nYear: {yyyy}")
```

### Practice: Quadratic Equation Solver

```python
# Solve ax² + bx + c = 0
a, b, c = map(float, input("Enter a, b, c: ").split(","))
d = (b**2) - (4*a*c)  # Discriminant

if d < 0:
    print("Imaginary roots")
else:
    root1 = (-b + (d)**0.5) / (2*a)
    root2 = (-b - (d)**0.5) / (2*a)
    print(f"Root 1: {root1}, Root 2: {root2}")
```

### While Loop - Condition Based Iteration

```python
# Basic while loop
i = 1
while i <= 5:
    print(i)
    i += 1

# Countdown
i = 5
while i > 0:
    print(i)
    i -= 1

# Float increments
i = 1.0
while i <= 5:
    print(i)
    i += 0.5
```

```python
# Infinite loop with break
while True:
    data = input("Enter data (press Enter to quit): ")
    if data == "":
        print("Blank given, stopping")
        break
    print(f"You entered: {data}")
```

**⚠️ Warning: Common While Loop Mistake**
```python
# DANGER: Infinite loop if you forget to update variable
i = 1
while i <= 5:
    print(i)
    # FORGOT: i += 1  ← This causes infinite loop!
```

### For Loop with range()

```python
# range(start, end, step)
# Note: 'end' is EXCLUSIVE (not included)

# range(5) → 0, 1, 2, 3, 4
for i in range(5):
    print(i)

# range(1, 6) → 1, 2, 3, 4, 5
for i in range(1, 6):
    print(i)

# range(0, 10, 2) → 0, 2, 4, 6, 8
for i in range(0, 10, 2):
    print(i)

# range(5, 0, -1) → 5, 4, 3, 2, 1
for i in range(5, 0, -1):
    print(i)
```

### Practice: For Loop Programs

```python
# Program 1: Print numbers divisible by 3
for i in range(1, 51):
    if i % 3 == 0:
        print(i, end=", ")
```

```python
# Program 2: Factorial of a number
product = 1
n = int(input("Enter n: "))
for i in range(1, n + 1):
    product *= i
print(f"{n}! = {product}")
```

```python
# Program 3: Multiplication table
n = int(input("Enter number: "))
for i in range(1, 11):
    print(f"{n} × {i} = {n * i}")
```

### Pattern Printing

```python
# Pattern 1: Right triangle
# X
# XX
# XXX
# XXXX
# XXXXX
for i in range(1, 6):
    print("X" * i)
```

```python
# Pattern 2: Pyramid
#      X
#     X X
#    X X X
#   X X X X
#  X X X X X
for i in range(1, 6):
    print(" " * (5 - i), "X " * i)
```

```python
# Pattern 3: Diamond
for i in range(1, 7):
    print(" " * (6 - i), "X " * i)
for i in range(5, 0, -1):
    print(" " * (6 - i), "X " * i)
```

### Break and Continue

```python
# continue - skip current iteration
for i in range(1, 11):
    if i == 5:
        continue  # Skip 5
    print(i)
print("Code ends")

# break - exit loop completely
for i in range(1, 11):
    if i == 5:
        break  # Stop at 5
    print(i)
print("Code ends")
```

---

<a id="day-2"></a>
## Day 2: Strings and Advanced Control Flow

### Number Manipulation Tricks

```python
# Extract last digit
number = 123
last_digit = number % 10  # Result: 3

# Remove last digit
number = 123
remaining = number // 10  # Result: 12
```

### Practice: Number Programs

```python
# Program 1: Sum of digits
number = int(input("Enter a number: "))
sum_digits = 0
while number > 0:
    digit = number % 10
    sum_digits += digit
    number = number // 10
print(f"Sum of digits: {sum_digits}")
```

```python
# Program 2: Reverse a number
number = int(input("Enter a number: "))
reverse_no = 0
while number > 0:
    digit = number % 10
    reverse_no = reverse_no * 10 + digit
    number = number // 10
print(f"Reversed number: {reverse_no}")
```

```python
# Program 3: Check palindrome
number = int(input("Enter a number: "))
temp = number
reverse_no = 0
while temp > 0:
    digit = temp % 10
    reverse_no = reverse_no * 10 + digit
    temp = temp // 10

if number == reverse_no:
    print(f"{number} is palindrome")
else:
    print(f"{number} is not palindrome")
```

```python
# Program 4: Armstrong number (153 = 1³ + 5³ + 3³)
number = int(input("Enter a number: "))
temp = number
sum_cubes = 0
while temp > 0:
    digit = temp % 10
    sum_cubes = sum_cubes + digit ** 3
    temp = temp // 10

if number == sum_cubes:
    print(f"{number} is Armstrong number")
else:
    print(f"{number} is not Armstrong number")
```

```python
# Program 5: Find all Armstrong numbers 100-1000
for number in range(100, 1000):
    temp = number
    sum_cubes = 0
    while temp > 0:
        digit = temp % 10
        sum_cubes = sum_cubes + digit ** 3
        temp = temp // 10
    if number == sum_cubes:
        print(number, end=" ")
```

```python
# Program 6: Check prime number
number = int(input("Enter a number: "))
is_prime = True
for i in range(2, number):
    if number % i == 0:
        is_prime = False
        break

if is_prime:
    print(f"{number} is prime")
else:
    print(f"{number} is not prime")
```

```python
# Program 7: Perfect number (6 = 1 + 2 + 3)
number = int(input("Enter a number: "))
sum_divisors = 0
for i in range(1, number):
    if number % i == 0:
        sum_divisors += i

if sum_divisors == number:
    print(f"{number} is a perfect number")
else:
    print(f"{number} is not a perfect number")
```

### Menu-Driven Program

```python
# Simple restaurant billing system
tea_cost, coffee_cost = 10.00, 40.00
water_cost, bm_cost = 20.00, 100.00
tea_qty = coffee_qty = water_qty = bm_qty = 0

while True:
    print("\n===== Apna Tea Stall =====")
    print("1. Tea")
    print("2. Coffee")
    print("3. Water")
    print("4. Bun Maska")
    print("0. Exit")
    print("===========================")
    
    choice = int(input("Enter choice: "))
    
    if choice == 1:
        tea_qty += int(input("Enter tea quantity: "))
    elif choice == 2:
        coffee_qty += int(input("Enter coffee quantity: "))
    elif choice == 3:
        water_qty += int(input("Enter water quantity: "))
    elif choice == 4:
        bm_qty += int(input("Enter bun maska quantity: "))
    elif choice == 0:
        print("Generating bill...")
        break
    else:
        print("Invalid option!")

# Print bill
print("\n========== BILL ==========")
print("Item       Qty  Cost  Total")
print("--------------------------")
if tea_qty > 0:
    print(f"Tea        {tea_qty:3}  {tea_cost:4.0f}  {tea_qty * tea_cost:5.0f}")
if coffee_qty > 0:
    print(f"Coffee     {coffee_qty:3}  {coffee_cost:4.0f}  {coffee_qty * coffee_cost:5.0f}")
if water_qty > 0:
    print(f"Water      {water_qty:3}  {water_cost:4.0f}  {water_qty * water_cost:5.0f}")
if bm_qty > 0:
    print(f"Bun Maska  {bm_qty:3}  {bm_cost:4.0f}  {bm_qty * bm_cost:5.0f}")
print("--------------------------")
total = (tea_qty * tea_cost + coffee_qty * coffee_cost + 
         water_qty * water_cost + bm_qty * bm_cost)
print(f"Total Amount: ₹{total:.2f}")
```

### String Operations

```python
# String basics
s = "python"

# Concatenation
print("amar" + "panchal")  # amarpanchal

# Repetition
print("amar" * 3)  # amaramaramar

# Length
print(len(s))  # 6

# Iteration - auto iterate
for character in s:
    print(character)

# Iteration - index based
for index in range(len(s)):
    print(f"at [{index}] we have {s[index]}")
```

### String Slicing [start:end:step]

```python
s = "ABCDEFGH"

# Basic slicing
print(s[0:4])    # ABCD (0 to 3)
print(s[::2])    # ACEG (every 2nd character)
print(s[::-1])   # HGFEDCBA (reverse)

# Growing pyramid
s = "python"
for i in range(1, len(s) + 1):
    print(s[0:i])
# Output:
# p
# py
# pyt
# pyth
# pytho
# python
```

```python
# Reverse pyramid
word = input("Enter word: ").upper()
for i in range(len(word), 0, -1):
    print(word[0:i])
```

### String Methods

```python
s = "ThIS Is A tEST"

# Case conversion
print(s.lower())       # this is a test
print(s.upper())       # THIS IS A TEST
print(s.capitalize())  # This is a test
print(s.title())       # This Is A Test

# Search methods
s = "imagination"
print(s.index('i'))    # 0 (first occurrence)
print(s.rindex('i'))   # 8 (last occurrence)

# Count occurrences
s = "this is it"
print(s.count("is"))   # 2
```

```python
# Count vowels
line = input("Enter a line: ").lower()
count = 0
for vowel in "aeiou":
    count += line.count(vowel)
print(f"Total vowels: {count}")
```

### String Alignment and Padding

```python
s = "word"
print(s.center(10, "-"))  # ---word---
print(s.ljust(10, "$"))   # word$$$$$$
print(s.rjust(10, "@"))   # @@@@@@word

# Pattern using padding
for space in range(1, 6):
    print("X".rjust(space, "-"))
```

### String Replacement

```python
line = "he came by taxi"
print(line.replace("taxi", "cab"))  # he came by cab

# Convert to past tense
line = "this is done by him"
print(line.replace(" is", " was"))  # this was done by him
```

### String Splitting and Joining

```python
line = "This is a test line for splitting"
words = line.split()  # Split by whitespace
print(words)

# Iterate over words
for word in words:
    print(word)

# Join words back
print(" ".join(words))
```

### String Reversal Methods

```python
# Method 1: Slicing (fastest)
word = "python"
print(word[::-1])  # nohtyp

# Method 2: Loop
word = input("Enter word: ")
reverse = ""
for i in range(len(word) - 1, -1, -1):
    reverse += word[i]
print(reverse)

# Check palindrome
word = input("Enter word: ")
print(f"{word} is palindrome: {word == word[::-1]}")
```

### ASCII Conversion

```python
# Character to ASCII
print(ord('a'))   # 97
print(ord('A'))   # 65

# ASCII to Character
print(chr(97))    # a
print(chr(65))    # A
```

### Practice: Advanced String Programs

```python
# Program 1: Word count
sentence = input("Enter a sentence: ")
word_count = len(sentence.split())
print(f"Total words: {word_count}")
```

```python
# Program 2: Remove spaces
word = input("Enter text: ")
no_spaces = ""
for char in word:
    if char != ' ':
        no_spaces += char
print(no_spaces)
```

```python
# Program 3: Caesar Cipher Encryption
line = input("Enter message: ")
shift = int(input("Enter shift value: "))
encrypted = ""

for char in line:
    if 'a' <= char <= 'z':
        encrypted_value = (ord(char) - ord('a') + shift) % 26 + ord('a')
        encrypted += chr(encrypted_value)
    else:
        encrypted += char  # Keep spaces and other characters

print(f"Encrypted message: {encrypted}")
```

```python
# Program 4: String compression (Run Length Encoding)
line = "aaaabbbaaaaabbbbbb"
compressed = ""
i = 0

while i < len(line):
    char = line[i]
    j = i + 1
    # Count consecutive characters
    while j < len(line) and line[j] == char:
        j += 1
    compressed += char + str(j - i)
    i = j

print(f"Compressed: {compressed}")  # a4b3a5b6
```

---

<a id="day-3"></a>
## Day 3: Data Structures (List, Tuple, Set, Dict)

### Introduction to Data Structures

Python has 4 built-in data structures:
- **List** `[]` - ordered, mutable, allows duplicates, indexed
- **Tuple** `()` - ordered, immutable, allows duplicates, indexed
- **Set** `{}` - unordered, mutable, no duplicates, not indexed
- **Dict** `{key:value}` - unordered, mutable, unique keys, key-accessed

```python
# Creating empty data structures
d1 = []           # Empty list
d2 = ()           # Empty tuple
d3 = set()        # Empty set (must use set())
d4 = {}           # Empty dict

print(type(d1), type(d2), type(d3), type(d4))

# Alternative creation
d1 = list()
d2 = tuple()
d3 = set()
d4 = dict()
```

### Common Functions for All Data Structures

```python
# These work on all data structures
len(collection)      # Number of elements
max(collection)      # Maximum value (same type only)
min(collection)      # Minimum value (same type only)
sum(collection)      # Sum (numbers only)
sorted(collection)   # Returns sorted list
```

### Lists - Dynamic, Indexed, Mutable

```python
# Creating and modifying lists
data_list = []
data_list.append(10)
data_list.append(50)
data_list.append(5)
data_list.append(15)

print(f"List has {len(data_list)} elements: {data_list}")
print(f"Min: {min(data_list)}, Max: {max(data_list)}, Sum: {sum(data_list)}")

# Indexing (0-based and negative indexing)
print(data_list[0])   # First element
print(data_list[-1])  # Last element
print(data_list[-2])  # Second last element
```

### List Methods

```python
# Important list methods
data_list = [10, 50, 5, 15]

# Sorting
print(sorted(data_list))  # Returns sorted copy, original unchanged
data_list.sort()          # In-place sorting, modifies original

# Inserting
data_list.insert(2, 100)  # Insert 100 at index 2

# Extending
data_list.extend([11, 22, 33])  # Add multiple elements

# Removing
data_list.remove(33)      # Remove specific value
popped = data_list.pop()  # Remove and return last element
popped = data_list.pop(3) # Remove and return element at index 3

print(data_list)
```

### List Iteration

```python
data = [11, 22, 33, 44, 55]

# Auto iterate
for item in data:
    print(item)

# Manual iterate with index
for index in range(len(data)):
    print(f"at {index} we have {data[index]}")
```

### Practice: List Programs

```python
# Program 1: Input until blank, calculate average
data_list = []
while True:
    data = input("Enter number (blank to stop): ")
    if data == "":
        print("Stopping...")
        break
    data_list.append(int(data))

print(f"Total: {len(data_list)}, Data: {data_list}")
average = sum(data_list) / len(data_list)
print(f"Average: {average}")

# Print elements less than average
print("Elements less than average:")
for item in data_list:
    if item < average:
        print(item, end=", ")

print("\nElements greater than or equal to average:")
for item in data_list:
    if item >= average:
        print(item, end=", ")
```

```python
# Program 2: Take comma-separated input
data_list = list(map(int, input("Enter values (comma-separated): ").split(",")))
print(f"You entered: {data_list}")

# Find second largest
data_list.sort()
print(f"Second largest: {data_list[-2]}")
```

```python
# Program 3: Left rotation
data = [11, 22, 33, 44, 55]
n = int(input("Enter rotations: "))
while n > 0:
    element = data.pop(0)    # Remove first
    data.append(element)      # Add to end
    print(data)
    n -= 1
```

```python
# Program 4: Right rotation
data = [11, 22, 33, 44, 55]
n = int(input("Enter rotations: "))
while n > 0:
    element = data.pop()      # Remove last
    data.insert(0, element)   # Add to beginning
    print(data)
    n -= 1
```

### Tuple - Immutable List

```python
# Tuples are immutable (cannot be changed after creation)
data = (12, 34, 66, 22, 44, 11, 12)

# Attempting to modify raises error
# data[0] = 100  # TypeError!

# But you can recreate
data = (120, 123)  # New tuple

# List inside tuple is still mutable
data = (1, 2, 3, [10, 20, 30], True)
data[3].append("amar")  # This works!
print(data)

# Iteration works same as list
for index in range(len(data)):
    print(f"at {index}: {data[index]}")

for item in data:
    print(item)
```

### Set - Unique Elements Only

```python
# Sets automatically remove duplicates
all_employees = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
singers = {1, 5, 9, 10}
dancers = {1, 2, 7, 9}

# Set operations
print(singers & dancers)              # Intersection (both)
print(singers | dancers)              # Union (all)
print(all_employees - singers - dancers)  # Difference

# Remove duplicates from list
data = [11, 22, 33, 11, 44, 22, 55, 66, 11, 77, 22, 11]
unique_data = sorted(set(data))
print(unique_data)
```

### Set Methods

```python
# Creating and modifying sets
data_set = set()  # Empty set

# Adding elements
data_set.add(10)
data_set.add(20)
data_set.add(10)  # Duplicate, won't be added
print(data_set)

# Removing elements
data_set.remove(10)           # Raises error if not found
data_set.discard(123)         # No error if not found

# Iteration (no indexing!)
for item in data_set:
    print(item)
```

### Practice: Word Analysis Program

```python
# Find unique words and frequency
line = '''
This is a set of test lines where certain words are repeated
Words are very important to test lines
'''

# Clean and process
line = line.replace(',', '').replace('.', '').replace(';', '')
line = line.lower()
word_list = line.split()
unique_words = sorted(set(word_list))

print(f"Total words: {len(word_list)}")
print(f"Unique words: {len(unique_words)}")

# Count frequency
for word in unique_words:
    print(f"{word}\t\t{word_list.count(word)}")

# Find longest word
longest = ""
for word in unique_words:
    if len(word) > len(longest):
        longest = word
print(f"\nLongest word: {longest} (length: {len(longest)})")
```

### Dictionary - Key-Value Pairs

```python
# Creating dictionary
numbers = {1: "one", 2: "two", 3: "three"}

print(len(numbers))  # 3

# Adding/Updating
numbers[4] = "four"      # Add new
numbers[1] = "EK"        # Update existing
numbers[1.5] = "one and half"

print(numbers)
```

### Dictionary Iteration

```python
numbers = {1: "one", 2: "two", 3: "three"}

# Iterate over keys
for key in numbers:
    print(key)

# Iterate over keys and values
for key in numbers:
    print(f"Key {key} has value: {numbers[key]}")

# Using items() (recommended)
for key, value in numbers.items():
    print(key, value)
```

### Practice: Order Processing

```python
# Process order from string
order = input("Enter order (item quantity pairs): ").lower()
# Example: "tea 10 coffee 2 bunmaska 1"

order_list = order.split()
order_dict = {}

item_idx = 0
qty_idx = 1

while qty_idx < len(order_list):
    order_dict[order_list[item_idx]] = order_list[qty_idx]
    item_idx += 2
    qty_idx += 2

print("Order:", order_dict)
```

### Practice: Numerology Calculator

```python
# Complete numerology system
numerology_data = {
    1: ["The Leader (Sun)", 
        "Leadership, independence, ambition",
        "Egoistic, arrogant, stubborn"],
    2: ["The Peacemaker (Moon)",
        "Cooperation, diplomacy, sensitivity",
        "Overly sensitive, indecisive"],
    # ... (other numbers)
}

# Calculate numerology number
name = input("Enter your name: ")
dob = input("Enter DOB (dd/mm/yyyy): ")

# Sum all digits
sum_digits = 0
for char in dob:
    if '0' <= char <= '9':
        sum_digits += int(char)

# Reduce to single digit
while sum_digits > 9:
    sum_digits = (sum_digits % 10) + (sum_digits // 10)

# Get data
data = numerology_data[sum_digits]

# Print report
print(f"""
NUMEROLOGY REPORT
==================

USER PROFILE
Name: {name}
DOB: {dob}

ANALYSIS
Type: {data[0]}

STRENGTHS
{data[1]}

CHALLENGES
{data[2]}
""")
```

---

<a id="day-4"></a>
## Day 4: Functions

### Introduction to Functions

Functions are reusable blocks of code that perform specific tasks.

```python
# Basic function definition
def add(p1, p2):
    '''Accepts 2 parameters and prints their sum'''
    print(p1, type(p1), p2, type(p2))
    print(p1 + p2)

# Calling the function
add(10, 20)        # 30
add("am", "ar")    # amar
add(12.3, 4.11)    # 16.41
```

### Parameter Passing: By Value vs By Reference

```python
# By Value (basic types: int, float, str, bool, complex)
# Changes are local only
def swap(no1, no2):
    print(f"\tStart in function - no1: {no1}, no2: {no2}")
    no1, no2 = no2, no1
    print(f"\tEnd in function - no1: {no1}, no2: {no2}")

no1, no2 = 100, 200
print(f"Start in main - no1: {no1}, no2: {no2}")
swap(no1, no2)
print(f"End in main - no1: {no1}, no2: {no2}")
# Values unchanged in main!
```

```python
# By Reference (data structures: list, tuple, dict, set)
# Changes are reflected globally
def doubler(numbers):
    print(f"\tStart in function: {numbers}")
    for index in range(len(numbers)):
        numbers[index] *= 2
    print(f"\tEnd in function: {numbers}")

num = [1, 2, 3, 4, 5, 6]
print(f"Start in main: {num}")
doubler(num)
print(f"End in main: {num}")
# Values changed in main!
```

**Why the difference?**
- Basic types are small, so copying is efficient
- Data structures can be large, so passing reference is efficient
- Multiple functions may need to work on same data

### Creating Deep Copy

```python
# To prevent modifying original list
def doubler(numbers2):
    numbers = numbers2.copy()  # Deep copy
    print(f"\tStart: {numbers}")
    for index in range(len(numbers)):
        numbers[index] *= 2
    print(f"\tEnd: {numbers}")
    return numbers

num = [1, 2, 3, 4, 5, 6]
print(f"Original: {num}")
result = doubler(num)
print(f"Original after function: {num}")  # Unchanged
print(f"Returned result: {result}")      # Doubled
```

### Return Statement

```python
# Functions can return values
def minimum(no1, no2):
    if no1 < no2:
        return no1
    else:
        return no2

result = minimum(10, 5)
print(result)  # 5

# Can use return value in expressions
print(minimum(minimum(10, 5), minimum(17, 1)))  # 1
```

### Multiple Return Values

```python
# Python can return multiple values (as tuple)
def ascending(no1, no2):
    if no1 < no2:
        return no1, no2
    else:
        return no2, no1

response = ascending(15, 5)
print(f"Type: {type(response)}, Data: {response}")  # tuple

# Unpacking
min_val, max_val = ascending(150, 50)
print(f"Min: {min_val}, Max: {max_val}")
```

### Practice: Function Programs

```python
# Program 1: Kth smallest element
def small_k(data_list, k):
    data_list.sort()
    if k <= len(data_list):
        return data_list[k - 1]
    else:
        return -1

result = small_k([22, 11, 66, 44, 88, 99, 33], 3)
print(result)  # 33
```

```python
# Program 2: Initial creator
def initial_creator(full_name):
    words = full_name.split()
    initials = ""
    for word in words:
        initials += word[0] + "."
    return initials.upper()

print(initial_creator("amar mukund panchal"))  # A.M.P.
```

```python
# Program 3: Combined function
def welcome(name):
    print(f"Welcome: {name}")
    initials = initial_creator(name)
    return f"Your initials are {initials}"

print(welcome("amar mukund panchal"))
```

### Parameter Types

```python
# 1. Positional Parameters
def intro(name, native):
    print(f"Hi {name}, so you are from {native}")

intro("amar", "mumbai")  # Order matters

# 2. Keyword Parameters
intro(native="nagpur", name="mrudula")  # Order doesn't matter

# 3. Default Parameters
def intro(name="human", native="india"):
    print(f"Hi {name}, so you are from {native}")

intro("amar", "mumbai")  # Uses provided values
intro(native="nagpur")    # name uses default
intro()                   # Both use default

# 4. Variable Size Parameters (*args)
def hobbies(*my):  # Receives as tuple
    print(type(my))
    for hobby in my:
        print(f"--> {hobby}")

hobbies("code", "sketch", "write", "travel")
hobbies("eat", "sleep")
```

```python
# Program: Sum and average of n numbers
def evaluator(*data):
    return sum(data), sum(data) / len(data)

total, avg = evaluator(1, 2, 3, 4, 5)
print(f"Total: {total}, Average: {avg}")
```

### Advanced Concepts

**Iterators**
```python
# Iterator - iterates over sequences
data_list = [11, 22, 33, 44, 55, 66]
i = iter(data_list)

print(next(i))  # 11
print(next(i))  # 22
print(next(i))  # 33
```

```python
# Program: Print names with 'a'
indian_names = ["Vihaan", "Aditi", "Arjun", "Sia", "Kunal"]
n = iter(indian_names)
for _ in range(len(indian_names)):
    name = next(n)
    if 'a' in name.lower():
        print(name)
```

**Generators**
```python
# Generator - function that pauses at yield
def returns(amount, rate, year):
    for y in range(1, year + 1):
        amount = amount + amount * 0.08
        yield amount  # Pauses here

i = returns(10000, 8, 10)
print(next(i))  # Year 1
print(next(i))  # Year 2
print(next(i))  # Year 3
```

```python
# Program: Fibonacci generator
def fibo(n):
    f0, f1 = 0, 1
    for i in range(n + 1):
        if i <= 1:
            yield i
        else:
            fn = f0 + f1
            f0, f1 = f1, fn
            yield fn

value = fibo(10)
for _ in range(11):
    print(next(value), end=", ")
```

**Lambda Functions**
```python
# Lambda - throwaway function
square = lambda x: x * x
print(square(10))  # 100

# Used for quick operations
area = lambda r: 3.14 * r * r
print(area(5))  # 78.5
```

**Ternary Operator**
```python
# Conditional expression
def check_even_odd(no):
    return "Even" if no % 2 == 0 else "Odd"

print(check_even_odd(10))  # Even
print(check_even_odd(19))  # Odd

def maximum(no1, no2):
    return no1 if no1 > no2 else no2

print(maximum(10, 5))  # 10
```

### Global vs Local Variables

```python
x = 100  # Global variable

def method1():
    a = 10  # Local variable
    print(f"Local a: {a}")
    print(f"Global x: {x}")  # Can access global
    
    # To modify global, must declare
    global x
    x = 1000
    print(f"Modified global x: {x}")

def method2():
    a = 101  # Different local variable
    print(f"Local a: {a}")
    print(f"Global x: {x}")

method1()
method2()
```

### Practice: Utility Functions

```python
# Program 1: Line reversal
def line_reverse(line):
    word_list = line.split()
    word_list = word_list[::-1]
    return " ".join(word_list)

print(line_reverse("this is india full of wonders"))
```

```python
# Program 2: Data cleaner
def data_cleaner(data):
    return data.replace(",", "")

print(data_cleaner("1,23,45,678"))  # 12345678
```

```python
# Program 3: Leap year checker
def is_leap_year(year):
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)

print(is_leap_year(2024))  # True
print(is_leap_year(2100))  # False
```

```python
# Program 4: Merge sorted lists
def merger(list1, list2):
    return sorted(list1 + list2)

list3 = merger([1, 3, 7], [2, 4, 5])
print(list3)  # [1, 2, 3, 4, 5, 7]
```

---

<a id="day-5"></a>
## Day 5: File Handling

### Basic File Operations

```python
# Writing to file
obj = open("amar.txt", "w")  # 'w' mode - creates or overwrites
line = input("Enter data: ")
obj.write(line)
obj.close()
```

```python
# Appending to file
obj = open("amar2.txt", "a")  # 'a' mode - adds to end
line = input("Enter data: ")
obj.write("\n" + line)  # Add newline before data
obj.close()
```

```python
# Reading entire file
obj = open("amar2.txt", "r")  # 'r' mode - read only
all_data = obj.read()
print(all_data)
obj.close()
```

```python
# Reading line by line
obj = open("amar2.txt", "r")
while True:
    line = obj.readline()
    if line == "":
        print("-----EOF-----")
        break
    print(line)
obj.close()
```

### File Modes Summary

| Mode | Description | Creates if not exists | Truncates if exists |
|------|-------------|----------------------|---------------------|
| 'r'  | Read only   | No (Error)           | No                  |
| 'w'  | Write only  | Yes                  | Yes                 |
| 'a'  | Append only | Yes                  | No                  |
| 'r+' | Read & Write| No (Error)           | No                  |
| 'w+' | Write & Read| Yes                  | Yes                 |
| 'a+' | Append & Read| Yes                 | No                  |

### Practice: Contact Management System

```python
# Contact validator and writer
def validator(name, contact, email):
    # Validate contact number
    is_valid = True
    if len(contact) != 10:
        is_valid = False
    else:
        for digit in contact:
            if not ('0' <= digit <= '9'):
                is_valid = False
                break
    
    if not is_valid:
        contact = ""
    
    # Validate email
    if '@' not in email or '.' not in email:
        email = ""
    
    # Validate name
    if name == "":
        name = ""
    
    return name, contact, email

# Main program
name = input("Enter name: ")
contact = input("Enter contact (10 digits): ")
email = input("Enter email: ")

while True:
    name, contact, email = validator(name, contact, email)
    
    if name != "" and contact != "" and email != "":
        break
    
    if name == "":
        print("---> Name cannot be blank")
        name = input("Enter name: ")
    
    if contact == "":
        print("---> 10 digit numbers only")
        contact = input("Enter contact: ")
    
    if email == "":
        print("---> Valid email needed")
        email = input("Enter email: ")

# Write to file
obj = open(name + ".txt", "a")
obj.write(f"Name: {name}\n")
obj.write(f"Contact: {contact}\n")
obj.write(f"Email: {email}\n")
obj.write("-" * 30 + "\n")
obj.close()
print(f"Contact saved to {name}.txt")
```

### File Merging

```python
# Merge two files alternately
f1 = open("file1.txt", "r")
f2 = open("file2.txt", "r")
f3 = open("file3.txt", "w")

while True:
    line1 = f1.readline()
    f3.write(line1)
    
    line2 = f2.readline()
    f3.write(line2)
    
    if line1 == "" and line2 == "":
        break

f1.close()
f2.close()
f3.close()
print("Files merged successfully!")
```

### Best Practices

```python
# Using 'with' statement (recommended)
# Automatically closes file
with open("test.txt", "w") as file:
    file.write("This is a test\n")
    file.write("File will auto-close\n")
# File is automatically closed here

# Reading file safely
try:
    with open("data.txt", "r") as file:
        content = file.read()
        print(content)
except FileNotFoundError:
    print("File not found!")
except Exception as e:
    print(f"Error: {e}")
```

### Practice: File Statistics

```python
# Analyze text file
def file_stats(filename):
    try:
        with open(filename, 'r') as file:
            content = file.read()
            lines = content.split('\n')
            words = content.split()
            chars = len(content)
            
            print(f"File: {filename}")
            print(f"Lines: {len(lines)}")
            print(f"Words: {len(words)}")
            print(f"Characters: {chars}")
    except FileNotFoundError:
        print(f"File {filename} not found!")

file_stats("amar.txt")
```

---

<a id="day-6"></a>
## Day 6: Object-Oriented Programming (OOP)

### Classes and Objects

```python
# Basic class definition
class Human:
    def birth(self, gender):
        print(f"Object ref: {id(self)}")
        self.gender = gender  # Instance variable
        print(f"Gender: {self.gender}")
    
    def naming(self, name):
        print(f"Object ref: {id(self)}")
        self.name = name
        print(f"Name: {self.name}")

# Creating objects
h1 = Human()
h1.birth("male")
h1.naming("Amar")

# self refers to the object that called the method
print(f"Object h1 ref: {id(h1)}")  # Same as self inside methods
```

### Constructors and Destructors

```python
# Constructor - called automatically when object created
class Human:
    def __init__(self, gender="unknown", name="unnamed"):
        print(f"Object created: {id(self)}")
        self.gender = gender
        self.name = name
    
    def intro(self):
        print(f"Hi, I am {self.name}, a {self.gender}")
    
    # Destructor - called when object is deleted
    def __del__(self):
        print(f"R.I.P {self.name}")

# Using constructor
h1 = Human("male", "Superman")
h1.intro()

h2 = Human()  # Uses default values
h2.intro()

# Destructor called when object is deleted
del h1  # Manual deletion
# Or automatically when program ends
```

### Static Members

```python
# Static/Class variables - shared by all objects
class Student:
    student_no = 202500  # Static variable
    
    def __init__(self, gender="unknown", name="unnamed"):
        self.gender = gender
        self.name = name
        Student.student_no += 1  # Access using class name
        self.roll_no = Student.student_no
        print(f"Student registered: {self.roll_no}")
    
    def __str__(self):
        return f"Name: {self.name}\tGender: {self.gender}\tRoll: {self.roll_no}"

s1 = Student("male", "Rahul")
s2 = Student("female", "Priya")
print(s1)
print(s2)
# Each student gets unique roll number
```

### Complete Student Management System

```python
class Student:
    student_no = 202500
    
    def __init__(self, gender="unknown", name="unnamed"):
        self.gender = gender
        self.name = name
        Student.student_no += 1
        self.roll_no = Student.student_no
    
    def get_roll_no(self):
        return self.roll_no
    
    def update(self):
        print("Old record:", self)
        print("Enter new details (blank to keep old):")
        
        name = input("Name: ")
        if name != "":
            self.name = name
        
        gender = input("Gender: ")
        if gender != "":
            self.gender = gender
        
        print("Updated record:", self)
    
    def __str__(self):
        return f"Name: {self.name}\tGender: {self.gender}\tRoll: {self.roll_no}"

# Menu-driven system
def menu():
    print("\n" + "="*30)
    print("Student Management System")
    print("="*30)
    print("1. Register student")
    print("2. Search student")
    print("3. Update student")
    print("4. Delete student")
    print("5. Print all students")
    print("0. Exit")
    print("="*30)

students = {}  # Dictionary to store students

while True:
    menu()
    choice = int(input("Enter choice: "))
    
    if choice == 1:
        name = input("Enter name: ")
        gender = input("Enter gender: ")
        student = Student(gender, name)
        students[student.get_roll_no()] = student
        print("Student registered successfully!")
    
    elif choice == 2:
        roll = int(input("Enter roll number: "))
        if roll in students:
            print("Record found:")
            print(students[roll])
        else:
            print(f"Roll {roll} not found")
    
    elif choice == 3:
        roll = int(input("Enter roll number: "))
        if roll in students:
            students[roll].update()
        else:
            print(f"Roll {roll} not found")
    
    elif choice == 4:
        roll = int(input("Enter roll number: "))
        if roll in students:
            del students[roll]
            print("Record deleted")
        else:
            print(f"Roll {roll} not found")
    
    elif choice == 5:
        if students:
            for roll in students:
                print(students[roll])
        else:
            print("No students registered")
    
    elif choice == 0:
        print("Exiting... Goodbye!")
        break
    
    else:
        print("Invalid choice!")
```

### Abstraction - Access Modifiers

```python
# Three types of access modifiers
class Person:
    gender = "male"           # Public - accessible everywhere
    _name = "amar"            # Protected - accessible but not recommended
    __number = "9821601163"   # Private - not accessible outside

# Accessing members
print(Person.gender)    # Works
print(Person._name)     # Works but not recommended
# print(Person.__number)  # Error!
```

```python
# Proper use of private members
class Human:
    def __init__(self, gender, name):
        self.__gender = gender  # Private
        self.__name = name      # Private
    
    def intro(self):
        print(f"Hi, I am {self.__name}, a {self.__gender}")

h = Human("male", "Amar")
h.intro()  # Works

# Cannot access directly
# print(h.__name)  # Error!

# Cannot modify directly
# h.__name = "ZZZZ"  # Creates new variable, doesn't modify original
h.intro()  # Original name unchanged
```

### Inheritance - Single Level

```python
# Parent class
class A:
    def public_a(self):
        print("Public of A")
    
    def _private_a(self):
        print("Private of A")
    
    def __strong_private_a(self):
        print("Strong private of A")

# Child class inheriting from A
class B(A):
    def public_b(self):
        print("Public of B")
    
    def _private_b(self):
        print("Private of B")
    
    def __strong_private_b(self):
        print("Strong private of B")

obj = B()
obj.public_b()    # Works
obj.public_a()    # Works (inherited)
obj._private_a()  # Works (inherited)
# obj.__strong_private_a()  # Error! Cannot inherit strong private
```

### Inheritance - Multilevel

```python
class Human:
    def set_human(self, name, gender):
        self.__name = name
        self.__gender = gender
    
    def display_human(self):
        print(f"Name: {self.__name}\nGender: {self.__gender}")

class Education(Human):
    def set_education(self, degree):
        self.__degree = degree
    
    def display_education(self):
        print(f"Degree: {self.__degree}")

class Job(Education):
    def set_job(self, name, gender, degree, salary):
        self.__salary = salary
        self.set_education(degree)
        self.set_human(name, gender)
    
    def display_job(self):
        self.display_human()
        self.display_education()
        print(f"Salary: {self.__salary}")

j = Job()
j.set_job("Amar", "male", "PhD", "100000")
j.display_job()
```

### Inheritance - Multiple

```python
# Multiple inheritance
class A:
    def my_a(self):
        print("My from A")

class B:
    def my_b(self):
        print("My from B")

class C(A, B):  # Inherits from both A and B
    def my_c(self):
        print("My from C")

obj = C()
obj.my_a()  # From A
obj.my_b()  # From B
obj.my_c()  # Own method
```

```python
# Ambiguity in multiple inheritance
class A:
    def my(self):
        print("My from A")

class B:
    def my(self):
        print("My from B")

class C(B, A):  # Order matters!
    def my_c(self):
        print("My from C")

obj = C()
obj.my()  # Calls B's method (first in list)
# Python uses Method Resolution Order (MRO)
```

### Method Overriding

```python
class Parent:
    def language(self):
        print("Parent: Hindi")
    
    def eat(self):
        print("Parent: Bhaji Chapati")

class Child(Parent):
    def eat(self):  # Overriding parent's method
        print("Child: Pizza, Burger, Fast food")

obj = Child()
obj.language()  # Uses parent's method
obj.eat()       # Uses child's overridden method
```

### Practice: OOP Programs

```python
# Program 1: Car class
class Car:
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
    
    def display_info(self):
        print(f"Car: {self.year} {self.make} {self.model}")

c1 = Car("Tata", "Nexon", 2023)
c1.display_info()

c2 = Car("Mahindra", "Thar", 2024)
c2.display_info()
```

```python
# Program 2: Employee with bonus
class Employee:
    def __init__(self, name, age, salary):
        self.__name = name
        self.__age = age
        self.__salary = salary
    
    def calculate_bonus(self):
        return self.__salary * 0.10

e = Employee("Priya", 28, 60000)
print(f"Bonus: {e.calculate_bonus()}")
```

```python
# Program 3: Bank Account
class BankAccount:
    def __init__(self, amount):
        if amount < 3000:
            print("Minimum 3000 needed to open account")
            return
        self.__balance = amount
        print(f"Account created with balance: {self.__balance}")
    
    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
            print(f"Deposited: {amount}")
        else:
            print("Invalid amount")
        print(f"New balance: {self.__balance}")
    
    def withdraw(self, amount):
        if self.__balance - amount < 0:
            print("Insufficient balance")
        else:
            self.__balance -= amount
            if self.__balance < 3000:
                self.__balance -= 500
                print("Charged 500 for low balance")
            print(f"Withdrawn: {amount}")
        print(f"New balance: {self.__balance}")

acc = BankAccount(5000)
acc.deposit(1000)
acc.withdraw(2000)
```

```python
# Program 4: Student with grades
class Student:
    def __init__(self, name, *grades):
        self.__name = name
        self.__grades = grades
    
    def __str__(self):
        return f"Name: {self.__name}, Grades: {self.__grades}"
    
    def calculate_average(self):
        return sum(self.__grades) / len(self.__grades)
    
    def find_highest(self):
        return max(self.__grades)
    
    def find_lowest(self):
        return min(self.__grades)

s = Student("Amar", 90, 80, 50, 80, 88, 66)
print(s)
print(f"Average: {s.calculate_average()}")
print(f"Highest: {s.find_highest()}")
print(f"Lowest: {s.find_lowest()}")
```

---

<a id="day-7"></a>
## Day 7: Data Structures Implementation

### Stack Implementation

```python
class Stack:
    def __init__(self):
        self.stack = []
    
    def push(self, e):
        self.stack.append(e)
    
    def pop(self):
        if not self.is_empty():
            return self.stack.pop()
        return None
    
    def peek(self):
        if not self.is_empty():
            return self.stack[-1]
        return None
    
    def print_stack(self):
        for i in range(len(self.stack) - 1, -1, -1):
            print(self.stack[i])
    
    def is_empty(self):
        return len(self.stack) == 0

# Using stack
s = Stack()
s.push(10)
s.push(20)
s.push(30)
s.print_stack()
print("Popped:", s.pop())
```

### Stack Applications

```python
# 1. Bracket matching
def check_brackets(line):
    s = []
    for char in line:
        if char == '{':
            s.append(char)
        elif char == '}':
            if len(s) != 0:
                s.pop()
            else:
                return False
    return len(s) == 0

print(check_brackets("{{{}}}"))   # True
print(check_brackets("{{{}}"))    # False
```

```python
# 2. Decimal to Binary
def convert_bin(no):
    binary = []
    while no > 0:
        binary.append(str(no % 2))
        no = no // 2
    return "".join(reversed(binary))

print(convert_bin(13))  # 1101
```

### Queue Implementation

```python
class Queue:
    def __init__(self):
        self.queue = []
    
    def enqueue(self, e):
        self.queue.append(e)
    
    def dequeue(self):
        if not self.is_empty():
            return self.queue.pop(0)
        return None
    
    def print_queue(self):
        for item in self.queue:
            print(item, end=" <- ")
        print()
    
    def is_empty(self):
        return len(self.queue) == 0

q = Queue()
q.enqueue(10)
q.enqueue(20)
q.enqueue(30)
q.print_queue()
print("Dequeued:", q.dequeue())
```

### Priority Queue

```python
class PriorityQueue:
    def __init__(self):
        self.queue = []
    
    def enqueue(self, e):
        self.queue.append(e)
        self.queue.sort()  # Keep sorted
    
    def dequeue(self):
        if not self.is_empty():
            return self.queue.pop(0)
        return None
    
    def print_queue(self):
        for item in self.queue:
            print(item, end=" ")
        print()
    
    def is_empty(self):
        return len(self.queue) == 0

pq = PriorityQueue()
pq.enqueue(5)
pq.enqueue(51)
pq.enqueue(15)
pq.print_queue()  # Sorted: 5 15 51
```


### Practice: Trading Strategy (continued)

```python
def best_deal(data):
    """Find best buy and sell days for maximum profit"""
    max_profit = 0
    buy_day = 0
    sell_day = 0
    
    for i in range(len(data)):
        for j in range(i + 1, len(data)):
            profit = data[j] - data[i]
            if profit > max_profit:
                max_profit = profit
                buy_day = i
                sell_day = j
    
    return buy_day, sell_day, max_profit

# Stock prices over days
prices = [7, 1, 5, 3, 6, 4]
buy, sell, profit = best_deal(prices)
print(f"Buy on day {buy}, Sell on day {sell}, Profit: {profit}")
```

### Linked List Implementation

```python
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None
    
    def insert_at_beginning(self, data):
        new_node = Node(data)
        new_node.next = self.head
        self.head = new_node
    
    def insert_at_end(self, data):
        new_node = Node(data)
        if self.head is None:
            self.head = new_node
            return
        
        current = self.head
        while current.next:
            current = current.next
        current.next = new_node
    
    def delete_node(self, key):
        current = self.head
        
        # If head needs to be deleted
        if current and current.data == key:
            self.head = current.next
            return
        
        # Search for the node
        prev = None
        while current and current.data != key:
            prev = current
            current = current.next
        
        # If not found
        if current is None:
            return
        
        # Unlink the node
        prev.next = current.next
    
    def search(self, key):
        current = self.head
        while current:
            if current.data == key:
                return True
            current = current.next
        return False
    
    def print_list(self):
        current = self.head
        while current:
            print(current.data, end=" -> ")
            current = current.next
        print("None")
    
    def reverse(self):
        prev = None
        current = self.head
        while current:
            next_node = current.next
            current.next = prev
            prev = current
            current = next_node
        self.head = prev

# Using linked list
ll = LinkedList()
ll.insert_at_end(10)
ll.insert_at_end(20)
ll.insert_at_end(30)
ll.insert_at_beginning(5)
ll.print_list()  # 5 -> 10 -> 20 -> 30 -> None

print("Search 20:", ll.search(20))  # True
ll.delete_node(20)
ll.print_list()  # 5 -> 10 -> 30 -> None

ll.reverse()
ll.print_list()  # 30 -> 10 -> 5 -> None
```

### Doubly Linked List

```python
class DNode:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None

class DoublyLinkedList:
    def __init__(self):
        self.head = None
    
    def insert_at_end(self, data):
        new_node = DNode(data)
        if self.head is None:
            self.head = new_node
            return
        
        current = self.head
        while current.next:
            current = current.next
        current.next = new_node
        new_node.prev = current
    
    def print_forward(self):
        current = self.head
        while current:
            print(current.data, end=" <-> ")
            current = current.next
        print("None")
    
    def print_backward(self):
        # Go to last node
        current = self.head
        while current and current.next:
            current = current.next
        
        # Print backward
        while current:
            print(current.data, end=" <-> ")
            current = current.prev
        print("None")

dll = DoublyLinkedList()
dll.insert_at_end(10)
dll.insert_at_end(20)
dll.insert_at_end(30)
dll.print_forward()   # 10 <-> 20 <-> 30 <-> None
dll.print_backward()  # 30 <-> 20 <-> 10 <-> None
```

---

<a id="day-8"></a>
## Day 8: Trees and Graphs

### Binary Tree Implementation

```python
class TreeNode:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

class BinaryTree:
    def __init__(self):
        self.root = None
    
    def insert(self, data):
        if self.root is None:
            self.root = TreeNode(data)
        else:
            self._insert_recursive(self.root, data)
    
    def _insert_recursive(self, node, data):
        if data < node.data:
            if node.left is None:
                node.left = TreeNode(data)
            else:
                self._insert_recursive(node.left, data)
        else:
            if node.right is None:
                node.right = TreeNode(data)
            else:
                self._insert_recursive(node.right, data)
    
    # Inorder: Left -> Root -> Right
    def inorder(self, node):
        if node:
            self.inorder(node.left)
            print(node.data, end=" ")
            self.inorder(node.right)
    
    # Preorder: Root -> Left -> Right
    def preorder(self, node):
        if node:
            print(node.data, end=" ")
            self.preorder(node.left)
            self.preorder(node.right)
    
    # Postorder: Left -> Right -> Root
    def postorder(self, node):
        if node:
            self.postorder(node.left)
            self.postorder(node.right)
            print(node.data, end=" ")
    
    def search(self, node, key):
        if node is None or node.data == key:
            return node
        
        if key < node.data:
            return self.search(node.left, key)
        return self.search(node.right, key)
    
    def find_height(self, node):
        if node is None:
            return 0
        left_height = self.find_height(node.left)
        right_height = self.find_height(node.right)
        return max(left_height, right_height) + 1

# Using binary tree
bt = BinaryTree()
bt.insert(50)
bt.insert(30)
bt.insert(70)
bt.insert(20)
bt.insert(40)
bt.insert(60)
bt.insert(80)

print("Inorder traversal:")
bt.inorder(bt.root)  # 20 30 40 50 60 70 80
print("\n\nPreorder traversal:")
bt.preorder(bt.root)  # 50 30 20 40 70 60 80
print("\n\nPostorder traversal:")
bt.postorder(bt.root)  # 20 40 30 60 80 70 50

print(f"\n\nTree height: {bt.find_height(bt.root)}")
print(f"Search 40: {bt.search(bt.root, 40) is not None}")
```

### Graph Implementation

```python
class Graph:
    def __init__(self):
        self.graph = {}
    
    def add_edge(self, u, v):
        if u not in self.graph:
            self.graph[u] = []
        if v not in self.graph:
            self.graph[v] = []
        self.graph[u].append(v)
        self.graph[v].append(u)  # For undirected graph
    
    def print_graph(self):
        for vertex in self.graph:
            print(f"{vertex} -> {self.graph[vertex]}")
    
    # Breadth First Search
    def bfs(self, start):
        visited = set()
        queue = [start]
        visited.add(start)
        
        while queue:
            vertex = queue.pop(0)
            print(vertex, end=" ")
            
            for neighbor in self.graph[vertex]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append(neighbor)
    
    # Depth First Search
    def dfs(self, start, visited=None):
        if visited is None:
            visited = set()
        
        visited.add(start)
        print(start, end=" ")
        
        for neighbor in self.graph[start]:
            if neighbor not in visited:
                self.dfs(neighbor, visited)

# Using graph
g = Graph()
g.add_edge(0, 1)
g.add_edge(0, 2)
g.add_edge(1, 2)
g.add_edge(2, 3)
g.add_edge(3, 4)

print("Graph:")
g.print_graph()

print("\nBFS from vertex 0:")
g.bfs(0)

print("\n\nDFS from vertex 0:")
g.dfs(0)
```

---

<a id="day-9"></a>
## Day 9: Regular Expressions & Web Scraping

### Regular Expressions

```python
import re

# Basic pattern matching
text = "My email is amar@example.com"
pattern = r'\w+@\w+\.\w+'

match = re.search(pattern, text)
if match:
    print(f"Found: {match.group()}")

# Find all matches
text = "Emails: amar@test.com, priya@test.com"
emails = re.findall(r'\w+@\w+\.\w+', text)
print(f"All emails: {emails}")

# Replace pattern
text = "My number is 1234567890"
hidden = re.sub(r'\d', 'X', text)
print(hidden)  # My number is XXXXXXXXXX

# Split by pattern
text = "apple,banana;orange|grape"
fruits = re.split(r'[,;|]', text)
print(fruits)  # ['apple', 'banana', 'orange', 'grape']
```

### Common Regex Patterns

```python
import re

# Phone number validation
def validate_phone(phone):
    pattern = r'^\d{10}$'
    return re.match(pattern, phone) is not None

print(validate_phone("9876543210"))  # True
print(validate_phone("98765"))       # False

# Email validation
def validate_email(email):
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

print(validate_email("user@example.com"))  # True
print(validate_email("invalid.email"))     # False

# URL extraction
text = "Visit https://www.example.com and http://test.org"
urls = re.findall(r'https?://[^\s]+', text)
print(urls)

# Date extraction (DD/MM/YYYY)
text = "Important dates: 25/12/2023, 01/01/2024"
dates = re.findall(r'\d{2}/\d{2}/\d{4}', text)
print(dates)
```

### Web Scraping (Conceptual)

```python
# Note: Install required libraries first
# pip install requests beautifulsoup4

"""
import requests
from bs4 import BeautifulSoup

# Fetch webpage
url = "https://example.com"
response = requests.get(url)

# Parse HTML
soup = BeautifulSoup(response.content, 'html.parser')

# Find elements
titles = soup.find_all('h1')
for title in titles:
    print(title.text)

# Find by class
divs = soup.find_all('div', class_='content')

# Find by id
header = soup.find(id='header')

# Extract links
links = soup.find_all('a')
for link in links:
    print(link.get('href'))
"""
```

---

## Additional Important Concepts

### Exception Handling

```python
# Try-except block
try:
    number = int(input("Enter a number: "))
    result = 100 / number
    print(f"Result: {result}")
except ValueError:
    print("Invalid input! Please enter a number.")
except ZeroDivisionError:
    print("Cannot divide by zero!")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("This always executes")
```

```python
# Custom exceptions
class NegativeNumberError(Exception):
    pass

def calculate_square_root(n):
    if n < 0:
        raise NegativeNumberError("Cannot calculate square root of negative number")
    return n ** 0.5

try:
    result = calculate_square_root(-4)
except NegativeNumberError as e:
    print(e)
```

### List Comprehensions

```python
# Basic list comprehension
squares = [x**2 for x in range(10)]
print(squares)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# With condition
evens = [x for x in range(20) if x % 2 == 0]
print(evens)  # [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

# Nested comprehension
matrix = [[i*j for j in range(3)] for i in range(3)]
print(matrix)  # [[0, 0, 0], [0, 1, 2], [0, 2, 4]]

# Dictionary comprehension
squares_dict = {x: x**2 for x in range(5)}
print(squares_dict)  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}

# Set comprehension
unique_chars = {char for char in "hello"}
print(unique_chars)  # {'h', 'e', 'l', 'o'}
```

### Important Built-in Functions

```python
# enumerate() - get index and value
fruits = ['apple', 'banana', 'cherry']
for idx, fruit in enumerate(fruits, start=1):
    print(f"{idx}. {fruit}")

# zip() - combine iterables
names = ['Alice', 'Bob', 'Charlie']
ages = [25, 30, 35]
for name, age in zip(names, ages):
    print(f"{name} is {age} years old")

# map() - apply function to all elements
numbers = [1, 2, 3, 4, 5]
doubled = list(map(lambda x: x*2, numbers))
print(doubled)  # [2, 4, 6, 8, 10]

# filter() - filter elements
evens = list(filter(lambda x: x%2==0, numbers))
print(evens)  # [2, 4]

# reduce() - reduce to single value
from functools import reduce
product = reduce(lambda x, y: x*y, numbers)
print(product)  # 120

# any() and all()
print(any([False, False, True]))   # True
print(all([True, True, True]))     # True
```

### Working with JSON

```python
import json

# Python dict to JSON
data = {
    "name": "Amar",
    "age": 25,
    "skills": ["Python", "Java", "SQL"]
}

# Convert to JSON string
json_string = json.dumps(data, indent=2)
print(json_string)

# Write to file
with open('data.json', 'w') as f:
    json.dump(data, f, indent=2)

# Read from file
with open('data.json', 'r') as f:
    loaded_data = json.load(f)
print(loaded_data)

# JSON string to Python dict
json_str = '{"name": "Priya", "age": 28}'
person = json.loads(json_str)
print(person['name'])  # Priya
```

### Date and Time

```python
from datetime import datetime, timedelta

# Current date and time
now = datetime.now()
print(f"Current: {now}")

# Formatting
formatted = now.strftime("%d/%m/%Y %H:%M:%S")
print(f"Formatted: {formatted}")

# Parsing
date_str = "25/12/2023"
date_obj = datetime.strptime(date_str, "%d/%m/%Y")
print(date_obj)

# Date arithmetic
tomorrow = now + timedelta(days=1)
print(f"Tomorrow: {tomorrow}")

week_ago = now - timedelta(weeks=1)
print(f"Week ago: {week_ago}")

# Calculate age
birth_date = datetime(1999, 12, 31)
age = (now - birth_date).days // 365
print(f"Age: {age} years")
```

---

## Practice Problems & Solutions

### Problem Set 1: Basics

```python
# 1. FizzBuzz
for i in range(1, 101):
    if i % 15 == 0:
        print("FizzBuzz")
    elif i % 3 == 0:
        print("Fizz")
    elif i % 5 == 0:
        print("Buzz")
    else:
        print(i)

# 2. Find duplicates in list
def find_duplicates(lst):
    seen = set()
    duplicates = set()
    for item in lst:
        if item in seen:
            duplicates.add(item)
        seen.add(item)
    return list(duplicates)

print(find_duplicates([1, 2, 3, 2, 4, 5, 1]))  # [1, 2]

# 3. Two sum problem
def two_sum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []

print(two_sum([2, 7, 11, 15], 9))  # [0, 1]
```

---

## Tips for Success

1. **Practice regularly** - Code every day, even if just for 30 minutes
2. **Read error messages** - They tell you exactly what's wrong
3. **Use print statements** - Debug by printing intermediate values
4. **Comment your code** - Explain complex logic
5. **Write functions** - Break problems into smaller pieces
6. **Test edge cases** - Empty lists, zero values, negative numbers
7. **Learn from mistakes** - Every error is a learning opportunity
8. **Use descriptive names** - `user_age` is better than `x`
9. **Follow PEP 8** - Python style guide for clean code
10. **Build projects** - Apply concepts to real problems

---

## Conclusion

This notebook covers fundamental to advanced Python concepts. Keep practicing, building projects, and exploring new libraries. Python's true power comes from its vast ecosystem of packages for data science, web development, automation, and more.

**Next Steps:**
- Learn pandas and numpy for data analysis
- Explore Django/Flask for web development
- Study matplotlib/seaborn for data visualization
- Practice on platforms like LeetCode, HackerRank
- Build personal projects to solidify learning

Happy Coding! 🐍

Similar code found with 2 license types
