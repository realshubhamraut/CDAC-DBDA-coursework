import pandas as pd
import numpy as np


def function1():
    s1 = pd.Series([10, 20, 30, 40, 50])

    # positive indexing
    # the indexing works only when the said index exists in the series index array
    print(s1.index)
    print(s1[0])
    print(s1[1])

    # negative indexing
    # it may or may not work depending on the index being present in the index array
    # in case of s1 it wont work as -1 does not exist in the index array of s1
    # print(s1[-1])


# function1()


def function2():
    # filtering a series using broadcast operators
    s1 = pd.Series([10, 20, 30, 40, 50])

    # get multiple values from series
    print(s1[[2, 3]])

    # get multiple values from series
    print(s1[[False, False, True, True, False]])

    # returns a series object
    print(s1[s1 > 30])


function2()
