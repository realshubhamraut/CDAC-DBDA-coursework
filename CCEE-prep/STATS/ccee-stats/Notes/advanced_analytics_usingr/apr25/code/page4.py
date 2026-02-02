import numpy as np
import pandas as pd


def function1():
    # read the data
    df = pd.read_csv('./data/Salary_Data.csv')

    # get all the values from the column
    # print(df['Salary'])

    # get multiple columns at a time
    # similar to the projection in case of database
    # select Salary, YearsExperience from Salary_Data
    # print(df[['Salary', 'YearsExperience']])
    # print(df.columns)

    # filtering: get required rows
    # print(df['Salary'][0])

    # get the salaries from 0, 1, 2, and 3 row
    # print(df['Salary'][[0, 1, 2, 3]])


# function1()


def function2():
    # read the data
    df = pd.read_csv('./data/Salary_Data.csv')

    # getting both projection and filtering together
    # get the required columns
    # iloc: ith location
    # - first one is the row's index
    # - second one is the column's index

    # get only first row and first column
    # print(df.iloc[0, 0])

    # get the first row with both the columns
    # print(df.iloc[0, 0:2])
    # print(df.iloc[0, :])

    # get all the rows with Salary column
    # print(df.iloc[:, 1])

    # get all the rows with all columns
    # print(df.iloc[:, :])


# function2()
