# broadcast operations
# - performing operation with every member of an array

import numpy as np


def function1():
    # maths operations
    a1 = np.array([10, 20, 30, 40, 50])

    # add operation
    print(f"a1 + 100 = {a1 + 100}")

    # subtract operation
    print(f"a1 - 100 = {a1 - 100}")

    # multiply operation
    print(f"a1 * 100 = {a1 * 100}")

    # true divide operation
    print(f"a1 / 100 = {a1 / 100}")

    # floor divide operation
    print(f"a1 // 100 = {a1 // 100}")

    # power of operation
    print(f"a1 ** 2 = {a1 ** 2}")

    # mod operation
    print(f"a1 % 100 = {a1 % 100}")


# function1()


def function2():
    # maths operations
    a1 = np.array([10, 20, 30, 40, 50])
    a2 = np.array([60, 70, 80, 90, 100])

    # add operation
    print(f"a1 + a2 = {a1 + a2}")

    # subtract operation
    print(f"a1 - a2 = {a1 - a2}")

    # multiply operation
    print(f"a1 * a2 = {a1 * a2}")

    # true divide operation
    print(f"a1 / a2 = {a1 / a2}")

    # floor divide operation
    print(f"a1 // a2 = {a1 // a2}")

    # mod operation
    print(f"a1 % a2 = {a1 % a2}")


# function2()


def function3():
    # comparison operations
    a1 = np.array([10, 20, 30, 40, 50])

    print(f"a1 > 30 = {a1 > 30}")
    print(f"a1 < 30 = {a1 < 30}")
    print(f"a1 >= 30 = {a1 >= 30}")
    print(f"a1 <= 30 = {a1 <= 30}")
    print(f"a1 == 30 = {a1 == 30}")
    print(f"a1 != 30 = {a1 != 30}")


# function3()


def function4():
    # logical operations
    a1 = np.array([True, False, False, True, False])

    print(np.array(list(map(lambda a: a and True, a1))))


function4()
