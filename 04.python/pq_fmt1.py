#!/usr/bin/env python3
"""Replace 200 Python Q&A cells with bullet-point formatted answers using <br> in table cells."""
import json, uuid
NB = "python.ipynb"
def md(s): return {"cell_type":"markdown","id":str(uuid.uuid4())[:8],"metadata":{},"source":s}

# Build all 8 replacement cells
cells = []

# ─── Section A: Q1-25 ───
cells.append(md([
"\n","---\n","\n",
"### 200 Most Asked Python Theoretical Interview Questions\n",
"\n",
"Comprehensive Q&A covering every Python concept. Answers are broken into key points for quick revision.\n",
"\n","---\n","\n",
"#### Section A: Core Python & Data Types (Q1–25)\n",
"\n",
"| # | Question | Keywords | Answer |\n",
"|---|----------|----------|--------|\n",
"| 1 | What is Python? | Python, interpreted | • High-level, interpreted, dynamically-typed language<br>• Emphasizes readability with significant indentation<br>• Supports procedural, OOP, and functional paradigms<br>• Large standard library and ecosystem (PyPI)<br>• Used for web, data science, ML, automation |\n",
"| 2 | Python 2 vs Python 3? | Python 2, Python 3 | • `print()` is a function, not a statement<br>• `/` does true division (not floor division)<br>• All strings are Unicode by default<br>• `range()` returns an iterator, not a list<br>• `input()` always returns a string<br>• Python 2 reached EOL January 2020 |\n",
"| 3 | Key features of Python? | Features, dynamic | • Easy to learn syntax<br>• Interpreted (no compilation step)<br>• Dynamically typed<br>• Garbage collected (automatic memory)<br>• Multi-paradigm (OOP, functional, procedural)<br>• Cross-platform<br>• Extensive third-party packages |\n",
"| 4 | What is PEP 8? | PEP 8, style guide | • Official Python style guide<br>• 4-space indentation, max 79-char lines<br>• `snake_case` for functions/variables<br>• `PascalCase` for classes<br>• `UPPER_CASE` for constants<br>• Tools: `black`, `flake8`, `pylint` |\n",
"| 5 | What is PEP 20? | Zen of Python | • Python's design philosophy<br>• Beautiful > ugly, Explicit > implicit<br>• Simple > complex, Flat > nested<br>• Readability counts<br>• Errors should never pass silently<br>• Access with `import this` |\n",
"| 6 | Built-in data types? | Data types, int, str | • **Numeric**: `int`, `float`, `complex`<br>• **Sequence**: `str`, `list`, `tuple`, `range`<br>• **Set**: `set`, `frozenset`<br>• **Mapping**: `dict`<br>• **Boolean**: `bool` (subclass of int)<br>• **Binary**: `bytes`, `bytearray`<br>• **None**: `NoneType` |\n",
"| 7 | List vs Tuple? | List, tuple, mutable | • List: **mutable**, uses `[]`<br>• Tuple: **immutable**, uses `()`<br>• Tuples are faster and hashable<br>• Tuples can be dict keys; lists cannot<br>• Use lists for changing collections<br>• Use tuples for fixed records |\n",
"| 8 | List vs Set? | List, set, unique | • List: ordered, allows duplicates, indexable<br>• Set: unordered, unique elements only, no indexing<br>• `in` check: set = O(1), list = O(n)<br>• Sets support union, intersection, difference<br>• Use sets for uniqueness and fast lookups |\n",
"| 9 | What is a dictionary? | Dictionary, key-value | • Stores key-value pairs using `{}`<br>• Keys must be hashable (immutable)<br>• O(1) average lookup, insert, delete<br>• Maintains insertion order (Python 3.7+)<br>• Methods: `.get()`, `.keys()`, `.values()`, `.items()`<br>• `.pop()`, `.update()`, `.setdefault()` |\n",
"| 10 | Mutable vs Immutable? | Mutable, immutable | • **Immutable**: `int`, `float`, `str`, `tuple`, `frozenset`, `bytes`<br>• **Mutable**: `list`, `dict`, `set`, `bytearray`<br>• Immutable objects are hashable and thread-safe<br>• 'Modifying' an immutable creates a new object<br>• Mutable objects can be changed in-place |\n",
"| 11 | What is None? | None, NoneType, null | • Python's null — sole instance of `NoneType`<br>• Represents absence of a value<br>• Functions without return → return None<br>• Check with `is None` (not `== None`)<br>• `None` is falsy: `bool(None) == False` |\n",
"| 12 | What is type casting? | Type casting, int() | • Converting one type to another<br>• Implicit: `3 + 4.0 → 7.0`<br>• Explicit: `int('42')`, `float('3.14')`, `str(100)`<br>• `list('abc') → ['a','b','c']`<br>• `set([1,1,2]) → {1,2}`<br>• `bool(0) → False`, `bool(1) → True` |\n",
"| 13 | What is duck typing? | Duck typing, protocol | • 'If it quacks like a duck, it's a duck'<br>• Python checks behavior, not type<br>• Any object with `__iter__` works in `for` loops<br>• Any object with `__len__` works with `len()`<br>• Enables polymorphism without inheritance |\n",
"| 14 | `is` vs `==`? | is, ==, identity | • `==` checks **value equality** (calls `__eq__`)<br>• `is` checks **identity** (same memory address)<br>• `a is b` means `id(a) == id(b)`<br>• Use `is` for None checks: `x is None`<br>• Small integers (-5 to 256) are cached — don't rely on `is` for comparisons |\n",
"| 15 | What is string interning? | String interning, cache | • Python caches small strings and ints (-5 to 256)<br>• Interned strings share same memory address<br>• `'hello' is 'hello'` → True (interned)<br>• `'hello world!' is 'hello world!'` → may be False<br>• Never rely on `is` for string comparison |\n",
"| 16 | What are f-strings? | f-string, Python 3.6 | • Embed expressions in strings: `f\"Hello {name}\"`<br>• Support formatting: `f\"{price:.2f}\"`<br>• Debugging: `f\"{x=}\"` prints `x=42`<br>• Faster than `.format()` and `%` formatting<br>• Available since Python 3.6 |\n",
"| 17 | What is string slicing? | Slicing, str, index | • Syntax: `s[start:stop:step]`<br>• `s[1:4]` → chars at index 1,2,3<br>• `s[:3]` → first 3, `s[-3:]` → last 3<br>• `s[::-1]` → reversed string<br>• Never raises IndexError on out-of-range<br>• Works on lists and tuples too |\n",
"| 18 | `str` vs `bytes`? | str, bytes, encoding | • `str`: Unicode text (characters)<br>• `bytes`: raw binary data (0-255 integers)<br>• `str.encode('utf-8')` → bytes<br>• `bytes.decode('utf-8')` → str<br>• Networks/files use bytes; code uses str<br>• Always specify encoding explicitly |\n",
"| 19 | What is a frozenset? | Frozenset, immutable | • Immutable version of `set`<br>• Cannot be modified after creation<br>• Hashable — can be dict key or set element<br>• `frozenset([1, 2, 3])`<br>• Supports union, intersection, difference |\n",
"| 20 | `append()` vs `extend()`? | append, extend, list | • `append(x)` adds x as single element<br>  → `[1,2].append([3,4])` = `[1,2,[3,4]]`<br>• `extend(iter)` adds each element<br>  → `[1,2].extend([3,4])` = `[1,2,3,4]`<br>• `append` O(1); `extend` O(k) |\n",
"| 21 | What is list comprehension? | List comprehension | • Concise list creation: `[expr for x in iter if cond]`<br>• `[x**2 for x in range(10) if x%2==0]`<br>• Dict comp: `{k:v for k,v in pairs}`<br>• Set comp: `{x for x in items}`<br>• Generator expr: `(x for x in items)`<br>• Faster than equivalent for loops |\n",
"| 22 | `sort()` vs `sorted()`? | sort, sorted, in-place | • `.sort()` — in-place, modifies original, returns None<br>• `sorted()` — returns new list, original unchanged<br>• Both accept `key=` and `reverse=` params<br>• `sorted()` works on any iterable<br>• Python uses TimSort: O(n log n), stable |\n",
"| 23 | What is `range()`? | range, lazy, sequence | • `range(start, stop, step)` — lazy integer sequence<br>• `range(5)` → 0,1,2,3,4<br>• Doesn't create list in memory<br>• Supports `in`, indexing, `len()`<br>• `list(range(5))` to materialize |\n",
"| 24 | What is unpacking? | Unpacking, *, ** | • `a, b, c = [1, 2, 3]`<br>• Star: `first, *rest = [1,2,3,4]` → rest=[2,3,4]<br>• Dict merge: `{**d1, **d2}`<br>• Function: `func(*args, **kwargs)`<br>• Swap: `a, b = b, a` |\n",
"| 25 | What is the walrus operator? | Walrus, := | • Assignment expression (Python 3.8+)<br>• `if (n := len(data)) > 10: print(n)`<br>• While: `while (line := f.readline()): …`<br>• Comps: `[y for x in data if (y := f(x)) > 0]`<br>• Saves repeated computation |\n",
]))

# ─── Section B: Q26-50 ───
cells.append(md([
"---\n","\n",
"#### Section B: Functions & Scope (Q26–50)\n",
"\n",
"| # | Question | Keywords | Answer |\n",
"|---|----------|----------|--------|\n",
"| 26 | What is a function? | Function, def, return | • Reusable block defined with `def name(params):`<br>• Can accept params, return values<br>• First-class objects — passed as args, returned<br>• Assigned to variables, stored in structures |\n",
"| 27 | `*args` and `**kwargs`? | *args, **kwargs | • `*args` → extra positional args as tuple<br>• `**kwargs` → extra keyword args as dict<br>• `def func(a, *args, **kwargs)`<br>• Unpack: `func(*list)`, `func(**dict)` |\n",
"| 28 | Positional vs keyword args? | Positional, keyword | • Positional: matched by position `func(1, 2)`<br>• Keyword: matched by name `func(x=1, y=2)`<br>• Keyword-only (after `*`): `def f(*, key)`<br>• Positional-only (before `/`): `def f(pos, /)` |\n",
"| 29 | What is lambda? | Lambda, anonymous | • Anonymous single-expression function<br>• `square = lambda x: x**2`<br>• Used in `sorted(key=lambda x: x[1])`<br>• No statements, single expression only<br>• Prefer `def` for anything complex |\n",
"| 30 | `map()`, `filter()`, `reduce()`? | map, filter, reduce | • `map(fn, iter)` → applies fn to each element<br>• `filter(fn, iter)` → keeps elements where fn=True<br>• `reduce(fn, iter)` → cumulative (from functools)<br>• List comp often replaces map/filter |\n",
"| 31 | What is a closure? | Closure, free variable | • Inner function remembers enclosing scope vars<br>• Even after outer function finishes<br>• Used for data encapsulation, factories<br>• `nonlocal` keyword modifies enclosing vars<br>• Powers the decorator pattern |\n",
"| 32 | What is a decorator? | Decorator, @, wrapper | • Function that wraps another function<br>• `@decorator` syntax above function<br>• Template: `def deco(fn): def wrap(*a,**k): …return fn(*a,**k); return wrap`<br>• Use `@functools.wraps(fn)` to preserve metadata<br>• Used for logging, timing, auth, caching |\n",
"| 33 | `@staticmethod` vs `@classmethod`? | staticmethod, classmethod | • `@staticmethod` — no `self` or `cls`, utility function<br>• `@classmethod` — receives `cls`, factory method<br>• `Date.from_string('2024-01-01')` ← classmethod<br>• classmethod works with inheritance (returns subclass) |\n",
"| 34 | What is a generator? | Generator, yield, lazy | • Function with `yield` instead of `return`<br>• Produces values lazily (one at a time)<br>• State preserved between `next()` calls<br>• Generator expr: `(x**2 for x in range(10))`<br>• Saves memory for large datasets |\n",
"| 35 | `yield` vs `return`? | yield, return | • `return` terminates function, sends value<br>• `yield` pauses function, sends value, remembers state<br>• Function resumes on next `next()` call<br>• Function with yield → generator object |\n",
"| 36 | Generator expr vs list comp? | Generator, memory | • List comp `[x for x in …]` → entire list in memory<br>• Gen expr `(x for x in …)` → lazy, O(1) memory<br>• Use generators for large data<br>• Use lists when you need indexing or multiple passes |\n",
"| 37 | Variable scope (LEGB)? | Scope, LEGB, local | • **L**ocal — inside current function<br>• **E**nclosing — outer function<br>• **G**lobal — module level<br>• **B**uilt-in — Python builtins<br>• Looked up in this order |\n",
"| 38 | `global` keyword? | global, scope | • Declares variable refers to module-level one<br>• `global count; count += 1`<br>• Without it, assignment creates local variable<br>• Avoid excessive use (test/debug harder) |\n",
"| 39 | `nonlocal` keyword? | nonlocal, closure | • References enclosing function's variable<br>• Used in closures to modify outer variable<br>• `def outer(): x=0; def inner(): nonlocal x; x+=1` |\n",
"| 40 | What is recursion? | Recursion, base case | • Function calls itself<br>• Needs base case (termination) + recursive case<br>• `def fact(n): return 1 if n<=1 else n*fact(n-1)`<br>• Python limit: ~1000 calls (`sys.setrecursionlimit`) |\n",
"| 41 | What is memoization? | Memoization, lru_cache | • Caches function results to avoid recomputation<br>• `@functools.lru_cache(maxsize=128)`<br>• Fibonacci: O(2ⁿ) → O(n)<br>• Only works with hashable arguments<br>• Python 3.9+: `@cache` for unlimited |\n",
"| 42 | Higher-order functions? | Higher-order, first-class | • Takes function as argument OR returns function<br>• Examples: `map()`, `filter()`, `sorted(key=…)`<br>• Decorators are higher-order functions<br>• Possible because functions are first-class objects |\n",
"| 43 | `functools.partial`? | partial, currying | • Creates new function with pre-filled args<br>• `double = partial(multiply, 2)`<br>• Similar to currying<br>• Useful for callbacks and adapters |\n",
"| 44 | `pass` vs `continue` vs `break`? | pass, continue, break | • `pass` — does nothing (placeholder)<br>• `continue` — skip to next iteration<br>• `break` — exit loop entirely<br>• `else` on loop: runs if no `break` |\n",
"| 45 | `enumerate()`? | enumerate, index | • Returns (index, value) pairs<br>• `for i, val in enumerate(items):`<br>• Better than `range(len(…))`<br>• `start=1` offsets index |\n",
"| 46 | `zip()`? | zip, parallel | • Pairs elements: `zip([1,2], ['a','b'])` → `[(1,'a'),(2,'b')]`<br>• Stops at shortest iterable<br>• `zip_longest()` pads with None<br>• Unzip: `zip(*zipped)` |\n",
"| 47 | `any()` and `all()`? | any, all, boolean | • `any(iter)` → True if ANY element is truthy<br>• `all(iter)` → True if ALL are truthy<br>• Both short-circuit<br>• `any([]) → False`, `all([]) → True` |\n",
"| 48 | `==` vs `__eq__`? | ==, __eq__, dunder | • `==` calls the `__eq__` method<br>• Override `__eq__` for custom equality<br>• Default `__eq__` compares by identity<br>• Must also define `__hash__` for dict/set use |\n",
"| 49 | What is a docstring? | Docstring, documentation | • String literal as first statement of func/class<br>• Triple-quoted: `\"\"\"Description.\"\"\"`<br>• Accessible via `func.__doc__` and `help(func)`<br>• Conventions: Google, NumPy, or Sphinx style |\n",
"| 50 | What is type hinting? | Type hints, mypy | • PEP 484 (Python 3.5+): `def greet(name: str) -> str`<br>• NOT enforced at runtime — use `mypy` to check<br>• `List[int]`, `Optional[str]`, `Union[int, str]`<br>• Python 3.10+: `int \\| str` syntax |\n",
]))

# ─── Section C: Q51-75 ───
cells.append(md([
"---\n","\n",
"#### Section C: Object-Oriented Programming (Q51–75)\n",
"\n",
"| # | Question | Keywords | Answer |\n",
"|---|----------|----------|--------|\n",
"| 51 | What is OOP? | OOP, class, object | • Organizes code into objects (data + behavior)<br>• Four pillars: Encapsulation, Inheritance, Polymorphism, Abstraction<br>• Python supports OOP fully |\n",
"| 52 | Class vs Object? | Class, object, instance | • Class — blueprint/template<br>• Object — specific instance of a class<br>• `class Dog: pass` → blueprint<br>• `my_dog = Dog()` → instance<br>• Each object has own attribute values |\n",
"| 53 | What is `self`? | self, instance | • First param of instance methods<br>• Refers to the specific object calling the method<br>• Passed automatically: `obj.method()` = `Class.method(obj)`<br>• Convention, not a keyword |\n",
"| 54 | What is `__init__`? | __init__, constructor | • Constructor called when creating object<br>• Initializes instance attributes<br>• `def __init__(self, name): self.name = name`<br>• Not the true constructor (`__new__` is)<br>• Initializes already-created object |\n",
"| 55 | `__init__` vs `__new__`? | __init__, __new__ | • `__new__` — creates instance (allocates memory), receives class<br>• `__init__` — initializes already-created instance, receives self<br>• Override `__new__` for immutable types, singletons, metaclasses |\n",
"| 56 | What is inheritance? | Inheritance, super | • Child class reuses parent code<br>• `class Dog(Animal):`<br>• Inherits all attributes and methods<br>• Can override or extend them<br>• `super()` calls parent methods |\n",
"| 57 | Multiple inheritance? | Multiple inheritance, MRO | • `class C(A, B):` — inherits from both<br>• Diamond problem resolved by MRO<br>• Uses C3 linearization algorithm<br>• Check with `ClassName.__mro__` |\n",
"| 58 | What is MRO? | MRO, C3, method lookup | • Method Resolution Order — search order for methods<br>• C3 linearization: left-to-right, depth-first<br>• For `class D(B,C)`: D → B → C → A<br>• `super()` follows MRO, not just parent |\n",
"| 59 | What is polymorphism? | Polymorphism, override | • Same method name, different behavior<br>• Method overriding (child redefines parent)<br>• Duck typing (any object with right methods)<br>• Operator overloading (`__add__`, `__str__`) |\n",
"| 60 | What is encapsulation? | Encapsulation, private | • Bundle data + methods, restrict access<br>• `public` — no prefix<br>• `_protected` — convention only<br>• `__private` — name mangled to `_Class__private`<br>• Python has no true private (all convention) |\n",
"| 61 | What is abstraction? | Abstraction, ABC | • Hide complex details behind simple interfaces<br>• `from abc import ABC, abstractmethod`<br>• Abstract classes can't be instantiated<br>• Subclasses must implement `@abstractmethod`s |\n",
"| 62 | What is name mangling? | Name mangling, __ | • `__attr` → transformed to `_ClassName__attr`<br>• Prevents accidental access from subclasses<br>• NOT for security — for name conflict avoidance<br>• Still accessible: `obj._ClassName__attr` |\n",
"| 63 | Magic/dunder methods? | Dunder, __str__, __len__ | • `__str__` → `print()`, `str()`<br>• `__repr__` → REPL, `repr()`<br>• `__len__` → `len(obj)`<br>• `__add__` → `+` operator<br>• `__eq__` → `==`<br>• `__getitem__` → `obj[key]`<br>• `__iter__` → for loops<br>• `__call__` → `obj()` |\n",
"| 64 | `__str__` vs `__repr__`? | __str__, __repr__ | • `__str__` — human-readable (for users)<br>• `__repr__` — unambiguous (for developers)<br>• `repr()` calls `__repr__`; `print()` calls `__str__`<br>• If only one: implement `__repr__` (fallback for `__str__`) |\n",
"| 65 | Operator overloading? | Operator overloading | • `__add__` for `+`, `__sub__` for `-`<br>• `__mul__` for `*`, `__eq__` for `==`<br>• `__lt__` for `<`, `__contains__` for `in`<br>• Return `NotImplemented` if operation invalid |\n",
"| 66 | `@property` decorator? | property, getter, setter | • Turn method into read-only attribute<br>• `@property def name(self): return self._name`<br>• Setter: `@name.setter def name(self, val)`<br>• Clean syntax: `obj.name` instead of `obj.get_name()` |\n",
"| 67 | What are `__slots__`? | __slots__, memory | • Replaces `__dict__` with fixed attrs<br>• `__slots__ = ['name', 'age']`<br>• 20-30% less memory per instance<br>• Slightly faster attribute access<br>• Can't add dynamic attributes |\n",
"| 68 | What is a metaclass? | Metaclass, type | • 'Class of a class' — controls class creation<br>• Default metaclass is `type`<br>• `class Meta(type): def __new__(cls,...)`<br>• For frameworks (Django ORM, SQLAlchemy)<br>• Prefer `__init_subclass__` for simpler cases |\n",
"| 69 | `__init_subclass__`? | __init_subclass__, hook | • Called when a class is subclassed (Python 3.6+)<br>• Simpler than metaclasses<br>• Used for registering subclasses, validation<br>• `def __init_subclass__(cls, **kw): registry.append(cls)` |\n",
"| 70 | Composition vs Inheritance? | Composition, has-a | • Inheritance: 'is-a' (Dog IS Animal)<br>• Composition: 'has-a' (Car HAS Engine)<br>• Composition is more flexible, less coupled<br>• Store related objects as attributes<br>• **Favor composition** over inheritance |\n",
"| 71 | `super()` function? | super, parent, MRO | • Proxy object delegating to parent in MRO order<br>• `super().__init__()` calls parent constructor<br>• In multiple inheritance, follows MRO<br>• Always use `super()` instead of `Parent.method(self)` |\n",
"| 72 | Class method vs instance method? | classmethod, self, cls | • Instance method: receives `self`, operates on instance<br>• `@classmethod`: receives `cls`, operates on class<br>• Used for factory/alternative constructors<br>• `MyClass.from_string('…')` |\n",
"| 73 | What is a static method? | staticmethod, utility | • No `self` or `cls` — regular function in class<br>• Utility function logically related to class<br>• `@staticmethod def validate_email(email):` |\n",
"| 74 | Descriptor protocol? | Descriptor, __get__ | • Objects with `__get__`, `__set__`, `__delete__`<br>• Powers `@property`, `@classmethod`, `@staticmethod`<br>• Data descriptor (has `__set__`) > instance dict<br>• Non-data descriptor < instance dict |\n",
"| 75 | What are dataclasses? | Dataclass, Python 3.7 | • `@dataclass` auto-generates `__init__`, `__repr__`, `__eq__`<br>• `@dataclass class Point: x: float; y: float`<br>• `frozen=True` → immutable, `slots=True` (3.10+)<br>• `field(default_factory=list)` for mutable defaults |\n",
]))

# ─── Section D: Q76-100 ───
cells.append(md([
"---\n","\n",
"#### Section D: Errors, Iterators & File I/O (Q76–100)\n",
"\n",
"| # | Question | Keywords | Answer |\n",
"|---|----------|----------|--------|\n",
"| 76 | Exception handling? | try, except, finally | • `try` → run code<br>• `except Error as e` → catch specific error<br>• `else` → runs if NO exception<br>• `finally` → ALWAYS runs (cleanup)<br>• Never use bare `except:` |\n",
"| 77 | `Exception` vs `BaseException`? | Exception, BaseException | • `BaseException` — root of all exceptions<br>• `Exception` — inherits from BaseException<br>• `SystemExit`, `KeyboardInterrupt` → BaseException directly<br>• Always catch `Exception`, not `BaseException` |\n",
"| 78 | Custom exceptions? | Custom exception, raise | • Inherit from `Exception`<br>• `class InsufficientFunds(Exception): def __init__(self, bal): super().__init__(f'Balance: {bal}')`<br>• Raise: `raise InsufficientFunds(100)` |\n",
"| 79 | `else` in try/except? | try, else | • Runs ONLY if no exception in `try`<br>• Keeps `try` block minimal<br>• Code that should run only on success |\n",
"| 80 | `finally` clause? | finally, cleanup | • ALWAYS executes (even with `return`)<br>• Used for cleanup: close files, release locks<br>• `with` statement usually replaces `try/finally` |\n",
"| 81 | `raise` statement? | raise, exception | • `raise ExceptionType('msg')` throws exception<br>• `raise` alone re-raises current exception<br>• `raise New() from original` chains exceptions |\n",
"| 82 | What is an iterator? | Iterator, __next__ | • Object with `__iter__()` + `__next__()`<br>• Raises `StopIteration` when exhausted<br>• Lazy — produces one value at a time<br>• `iter(iterable)` to get an iterator |\n",
"| 83 | Iterable vs Iterator? | Iterable, iterator | • **Iterable**: has `__iter__()` (list, str, dict)<br>• **Iterator**: has `__iter__()` + `__next__()`<br>• Iterables → iterate multiple times<br>• Iterators → consumed once |\n",
"| 84 | `itertools` module? | itertools, chain | • `chain(*iters)` — concatenate iterables<br>• `product(A,B)` — cartesian product<br>• `combinations(A,r)`, `permutations(A,r)`<br>• `groupby(data, key)` — group consecutive<br>• `islice(iter, start, stop)` |\n",
"| 85 | Context manager? | Context manager, with | • Setup/cleanup with `with` statement<br>• Implement `__enter__()` and `__exit__()`<br>• Or `@contextlib.contextmanager` with yield<br>• Files, DB connections, locks |\n",
"| 86 | `with` statement? | with, resource | • Ensures proper resource management<br>• `with open('f') as f: data=f.read()` → auto-close<br>• Multiple: `with open('a') as f1, open('b') as f2:`<br>• Works with any context manager |\n",
"| 87 | `open()` modes? | open, r, w, a, b | • `'r'` read (default), `'w'` write (overwrites)<br>• `'a'` append, `'x'` exclusive create<br>• `'b'` binary, `'t'` text (default)<br>• `'rb'` read binary, `'w+'` read+write<br>• Always specify `encoding='utf-8'` |\n",
"| 88 | Shallow vs deep copy? | Shallow, deep, copy | • **Shallow** `copy.copy()` → new object, same nested refs<br>• **Deep** `copy.deepcopy()` → recursively copies everything<br>• Shallow issue: modifying nested list affects original<br>• Also: `list.copy()`, `list[:]` — shallow only |\n",
"| 89 | `collections` module? | Counter, defaultdict, deque | • `Counter` — count occurrences<br>• `defaultdict` — dict with default factory<br>• `deque` — O(1) append/pop both ends<br>• `namedtuple` — immutable named fields<br>• `ChainMap` — merge multiple dicts |\n",
"| 90 | `collections.Counter`? | Counter, most_common | • `Counter('abracadabra')` → `{'a':5,'b':2,…}`<br>• `.most_common(n)` — top N frequent<br>• Arithmetic: `c1 + c2`, `c1 - c2`<br>• Useful for frequency, anagrams |\n",
"| 91 | `collections.defaultdict`? | defaultdict, factory | • Default value for missing keys (no KeyError)<br>• `d = defaultdict(list); d['k'].append(1)`<br>• Factories: `int` (counting), `list` (grouping), `set` (unique grouping) |\n",
"| 92 | What is `namedtuple`? | namedtuple, fields | • `Point = namedtuple('Point', ['x','y']); p.x → 1`<br>• Tuple with attribute access<br>• Immutable, hashable, memory-efficient<br>• Python 3.6+: `typing.NamedTuple` with types |\n",
"| 93 | `collections.deque`? | deque, double-ended | • O(1) `appendleft()`, `popleft()` (list is O(n))<br>• `rotate(n)`, `maxlen` for fixed-size<br>• Use for queues, BFS, sliding windows |\n",
"| 94 | What is pickling? | Pickle, serialize | • Serializes Python objects to bytes<br>• `pickle.dump(obj, file)`, `pickle.load(file)`<br>• ⚠️ **Never unpickle untrusted data**<br>• Alternatives: JSON (safe), shelve |\n",
"| 95 | JSON handling? | JSON, dumps, loads | • `json.dumps(obj)` → JSON string<br>• `json.loads(s)` → Python object<br>• `json.dump(obj, file)` / `json.load(file)`<br>• dict↔object, list↔array, None↔null<br>• Custom: provide `default=` function |\n",
"| 96 | `os` vs `pathlib`? | os, pathlib, file | • `os`: `os.path.join()`, `listdir()`, `makedirs()`<br>• `pathlib` (preferred): `Path('dir') / 'file.txt'`<br>• `path.exists()`, `.read_text()`, `.glob('*.py')`<br>• pathlib is more readable and OOP |\n",
"| 97 | What is the GIL? | GIL, threading, CPython | • Global Interpreter Lock in CPython<br>• Only one thread executes bytecode at a time<br>• CPU-bound threads don't run in parallel<br>• I/O-bound threads DO benefit<br>• Fix: `multiprocessing` or C extensions |\n",
"| 98 | Threading vs Multiprocessing? | Threading, multiprocessing | • **Threading**: shared memory, limited by GIL, good for I/O<br>• **Multiprocessing**: separate memory, true parallelism, good for CPU<br>• `concurrent.futures.ThreadPoolExecutor` / `ProcessPoolExecutor` |\n",
"| 99 | `async`/`await`? | async, await, asyncio | • `async def` defines coroutine<br>• `await` pauses until operation completes<br>• `asyncio.run(main())` runs event loop<br>• Efficient for I/O-bound tasks<br>• Single-threaded, cooperative |\n",
"| 100 | Concurrency vs Parallelism? | Concurrency, parallelism | • **Concurrency**: tasks make progress (switching)<br>• **Parallelism**: tasks run simultaneously (multi-core)<br>• Threading = concurrency (GIL limits)<br>• Multiprocessing = parallelism<br>• asyncio = concurrency (single-threaded) |\n",
]))

# ─── Now write to notebook ───
with open(NB,"r") as f: nb=json.load(f)
# Remove old cells 362-369
nb["cells"] = nb["cells"][:362] + cells
# Continue with part 2
with open(NB,"w") as f: json.dump(nb,f,indent=1,ensure_ascii=False)
print(f"Replaced cells 362-369 with {len(cells)} new cells (Q1-100). Total: {len(nb['cells'])}")
