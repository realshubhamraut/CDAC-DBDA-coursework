# comprehension

def function1():
    # list
    a1 = [1, 2, 3, 4, 5]

    # get square of every number
    squares = []
    for value in a1:
        squares.append(value ** 2)

    print(squares)


# function1()


def function2():
    # list
    a1 = [1, 2, 3, 4, 5]

    # get the square of every value
    squares = list(map(lambda x: x ** 2, a1))
    print(squares)


# function2()


def function3():
    # list comprehension as a map
    a1 = [1, 2, 3, 4, 5]

    # get square of every value in a1
    squares = [value ** 2 for value in a1]
    print(f"squares = {squares}")

    # get cube of every value in a1
    cubes = [value ** 3 for value in a1]
    print(f"cubes = {cubes}")

    # temperatures
    temperatures_f = [92, 96, 97, 91, 95, 93, 94]
    temperatures_c = [(temperature - 32) * (5/9) for temperature in temperatures_f]
    print(f"temperatures_c = {temperatures_c}")


# function3()


def function4():
    # list comprehension as a map
    a1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # find out all even numbers
    even_numbers = list(filter(lambda x: x % 2 == 0, a1))
    print(even_numbers)


# function4()


def function5():
    # list comprehension as a filter
    a1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # find the even numbers
    even_numbers = [value for value in a1 if value % 2 == 0]
    print(even_numbers)

    # find the odd numbers
    odd_numbers = [value for value in a1 if value % 2 != 0]
    print(odd_numbers)


# function5()


def function6():
    # list comprehension as a map and filter
    a1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # square of even numbers
    # [4, 16, 36, 64, 100]
    squares_even_numbers = [value ** 2 for value in a1 if value % 2 == 0]
    print(squares_even_numbers)


# function6()


def function7():
    a1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # square of even numbers using map and filter
    # [4, 16, 36, 64, 100]

    # find out the even numbers using filter
    even_numbers = filter(lambda x: x % 2 == 0, a1)

    # find our the square of each even numbers using map
    squares_even_numbers = list(map(lambda x: x ** 2, even_numbers))
    print(squares_even_numbers)

    print(list(map(lambda x: x ** 2, filter(lambda x: x % 2 == 0, a1))))


function7()
