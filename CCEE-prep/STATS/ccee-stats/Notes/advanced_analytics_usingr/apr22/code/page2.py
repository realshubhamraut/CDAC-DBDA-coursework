# indexing

import numpy as np


def function1():
    # positive indexing
    a1 = np.array([10, 20, 30, 40, 50])

    print(f"a1[0] = {a1[0]}")
    print(f"a1[1] = {a1[1]}")
    print(f"a1[2] = {a1[2]}")
    print(f"a1[3] = {a1[3]}")
    print(f"a1[4] = {a1[4]}")

    print()

    # for..each loop
    for value in a1:
        print(f"value = {value}")

    print()

    # traditional approach
    for index in np.arange(a1.size):
        print(f"value = {a1[index]}")


# function1()


def function2():
    # negative indexing
    # it always returns only one value [at the required index]
    a1 = np.array([10, 20, 30, 40, 50])

    print(f"a1[-1] = {a1[-1]}")
    print(f"a1[-2] = {a1[-2]}")
    print(f"a1[-3] = {a1[-3]}")
    print(f"a1[-4] = {a1[-4]}")
    print(f"a1[-5] = {a1[-5]}")

    a1.any()

    print()

    # traditional approach with negative indexing
    for index in np.arange(-1, -5):
        print(f"value = {a1[index]}")


# function2()


def function3():
    # get multiple positions from the array
    # pass multiple positions to the array subscript
    a1 = np.array([10, 20, 30, 40, 50])

    # [10, 30, 40]
    print(f"a1[[0, 2, 3]] = {a1[[0, 2, 3]]}")

    # [30, 50]
    print(f"a1[[2, 4]] = {a1[[2, 4]]}")


# function3()


def function4():
    # get multiple positions from the array
    a1 = np.array([10, 20, 30, 40, 50])

    # [30, 50]
    print(f"a1[[False, False, True, False, True]] = {a1[[False, False, True, False, True]]}")

    # [10, 20, 50]
    print(f"a1[[True, True, False, False, True]] = {a1[[True, True, False, False, True]]}")

    # list of positions
    required_positions = [True, False, True, True, False]
    print(f"a1[required_positions] = {a1[required_positions]}")


# function4()


def function5():
    a1 = np.array([10, 20, 30, 40, 50])

    # [30, 40, 50]
    print(f"a1[[False, False, True, True, True]] = {a1[[False, False, True, True, True]]}")

    # this broadcast operation is returning an array with all boolean values
    print(f"a1 > 20 = {a1 > 20}")

    # [30, 40, 50]
    # filtering the array
    print(f"a1[a1 > 20] = {a1[a1 > 20]}")


# function5()


def function6():
    # array filtering
    workers = np.array([20, 35, 42, 30, 41, 35, 39])

    # find the workers having salary > 35
    print(f"workers[workers > 35] = {workers[workers > 35]}")


function6()
