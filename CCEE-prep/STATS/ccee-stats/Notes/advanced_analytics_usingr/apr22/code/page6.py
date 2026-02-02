import pandas as pd
import numpy as np


def function1():
    # list
    list1 = [
        [10, 20, 30, 40, 50],
        [60, 70, 80, 90, 100]
    ]
    print(list1)
    print(f"type = {type(list1)}")

    print()

    # array
    array1 = np.array([
        [10, 20, 30, 40, 50],
        [60, 70, 80, 90, 100]
    ])
    print(array1)
    print(f"type = {type(array1)}")

    # data frame
    df = pd.DataFrame([
        [10, 20, 30, 40, 50],
        [60, 70, 80, 90, 100]
    ])
    print(df)


# function1()


def print_df_properties(df):
    print(df)
    print(f"data types = ")
    print(df.dtypes)
    print(f"dimensions = {df.ndim}")
    print(f"shape = {df.shape}")
    print(f"size = {df.size}")

    # similar to the summary function in R
    # prints all the statistical information of numerical columns
    print(df.describe())

    print()

    # similar to str() in R
    # prints all the details of all the columns
    df.info()
    print('-' * 80)


def function2():
    # df1 = pd.DataFrame([
    #     [10, 20, 30, 40, 50],
    #     [60, 70, 80, 90, 100]
    # ])
    # print_df_properties(df1)

    df2 = pd.DataFrame([
        [10, 20],
        [30, 40],
        [50, 60],
        [70, 80],
        [90, 100]
    ])
    print_df_properties(df2)

    # creating a data frame using list of dictionaries
    df3 = pd.DataFrame([
        {"name": "person1", "address": "pune", "phone": "+911234234", "email": "p1@test.com"},
        {"name": "person2", "address": "mumbai", "phone": "+911234235", "email": "p2@test.com"},
        {"name": "person3", "address": "satara", "phone": "+911234236", "email": "p3@test.com"},
        {"name": "person4", "address": "karad", "email": "p4@test.com"},
        {"name": "person5", "address": "mumbai", "phone": "+911234238"},
        {"name": "person6", "address": "pune", "phone": "+911234239", "email": "p6@test.com"}
    ])
    print_df_properties(df3)


# function2()


def function3():
    # read the data from a csv file and convert it into a data frame
    # is similar to read.csv(...) in R
    df = pd.read_csv('50_Startups.csv')
    print_df_properties(df)


function3()