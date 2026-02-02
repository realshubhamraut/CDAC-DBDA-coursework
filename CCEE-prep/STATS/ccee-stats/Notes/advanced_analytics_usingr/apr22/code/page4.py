import numpy as np
import pandas as pd


def function1():
    # list
    list1 = [10, 20, 30, 40, 50]
    print(f"list1 = {list1}, data type = {type(list1)}")
    print()

    # array
    a1 = np.array([10, 20, 30, 40, 50])
    print(f"a1 = {a1}, data type = {type(a1)}")
    print()

    # series
    s1 = pd.Series([10, 20, 30, 40, 50])
    print(f"data type = {type(s1)}")
    print(s1)


# function1()


def print_series_details(series):
    print(series)
    print(f"type = {type(series)}")
    print(f"dtype = {series.dtype}")
    print(f"dimension = {series.ndim}")
    print(f"shape = {series.shape}")
    print(f"total memory size = {series.nbytes}")
    print(f"index in series: {series.index}")
    print(f"values in series: {series.values}")
    print("-" * 80)


def function2():
    # series created using a list
    s1 = pd.Series([10, 20, 30, 40, 50])
    print_series_details(s1)

    # series created using a tuple
    s2 = pd.Series((10, 20, 30, 40, 50))
    print_series_details(s2)

    # series can not be created using set
    # as the set is not ordered collection
    # s3 = pd.Series({10, 20, 30, 40, 50})
    # print_series_details(s3)

    # series created using a dictionary
    s4 = pd.Series({"name": "person1", "address": "pune", "email": "person1@test.com"})
    print_series_details(s4)


# function2()


def function3():
    # implementation without series
    cars = ["i20", "i10", "carens", "seltos", "xuv700"]
    averages = [17, 18, 20, 19, 16]

    i20_index = cars.index("i20")
    print(f"average of i20 = {averages[i20_index]}")

    seltos_index = cars.index("seltos")
    print(f"average of seltos = {averages[seltos_index]}")

    print()

    # implementation with series
    # series object getting created with custom indexes
    series = pd.Series(averages, index=cars)
    print_series_details(series)
    print(f"average of i20 = {series['i20']}")
    print(f"average of seltos = {series['seltos']}")

    print()

    series1 = pd.Series(cars, index=averages)
    print_series_details(series1)
    print(f"20 is an average of {series1[20]}")
    print(f"17 is an average of {series1[17]}")

    print()

    series2 = pd.Series(["xuv700", "innova", "carens"], index=["mahindra", "toyota", "kia"])
    print_series_details(series2)
    print(f"mahindra's model = {series2['mahindra']}")
    print(f"toyota's model = {series2['toyota']}")

    print()

    series3 = pd.Series(["mahindra", "toyota", "kia"], index=["xuv700", "innova", "carens"])
    print_series_details(series3)
    print(f"carens's company = {series3['carens']}")


# function3()


def function4():
    series1 = pd.Series(["xuv700", "innova", "carens", "seltos"], index=["mahindra", "toyota", "kia", "kia"])
    print_series_details(series1)
    print(series1['kia'])
    

function4()