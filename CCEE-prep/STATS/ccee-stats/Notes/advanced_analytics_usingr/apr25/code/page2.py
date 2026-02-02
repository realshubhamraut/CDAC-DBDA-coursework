import pandas as pd
import numpy as np


def function1():
    # reading data from a file
    df = pd.read_csv('./data/Salary_Data.csv')
    # print(df)

    # similar to the head() in R
    # get the first 5 rows from the data
    # print(df.head())

    # get the first 10 rows from the data frame
    # print(df.head(10))

    # similar to tail() in R
    # get last 5 records
    # print(df.tail())

    # get last 10 records
    # print(df.tail(10))

    # get the information about the df
    # similar to str() in R
    # print(df.info())

    # get statistical information about the df
    # similar to summary() in R
    # print(df.describe())


# function1()


def function2():
    df = pd.read_csv('./data/titanic.csv')

    # get info
    # print(df.info())

    # check if df has any NaN values
    # NaN in R are known as NA values
    # isna:
    # - can be called at df level
    # - True  -> data is missing
    # - False -> data is not missing
    # print(df.isna())

    # get the data of a column
    # print(df.age)
    # print(df['age'])

    # check if the column has any missing data
    # print(df['age'].isna())

    # get the number of rows missing from a column
    # print(df['age'].isna().sum())

    # get the number of rows missing per column
    # print(df.isna().sum())


# function2()


def function3():
    # deal with the missing data
    df = pd.read_csv('./data/titanic.csv')
    # print(df)

    # check the number of values missing in age column
    # print(df['age'].isna().sum())
    # print(df.isna().sum())

    # get the mean of age column
    # by skipping the NA records
    # print(df['age'].mean())

    # if the NA records are considered then the answer will
    # always be NaN
    # print(df['age'].mean(skipna=False))

    # get all the columns of a data frame
    print(df.columns)
    print(df.shape)

    # to fix the missing values
    # - solution1: remove the column(s) which has the missing values
    # - the column having NA records will be removed and new df object
    # will be returned
    # df2 = df.dropna(axis=1)

    # get all the columns of a data frame after deleting the columns
    # with no data or having NA records
    # print(df2.columns)


# function3()


def function4():
    # deal with the missing data
    df = pd.read_csv('./data/titanic.csv')
    # print(df)

    # - solution2:
    # - remove the rows when there is at least on NA value
    # df3 = df.dropna(axis=0)

    # since the rows got deleted, the number of columns remained same
    # print(df3.columns)
    # print(df3.shape)
    # print(df3)


# function4()


def function5():
    # deal with the missing data
    df = pd.read_csv('./data/titanic.csv')
    # print(df)

    # check the number of values missing in age column
    print(f"no of records missing in age column = {df['age'].isna().sum()}")

    # get the mean value of age
    print(f"mean of age = {df['age'].mean()}")

    print()

    # replace the missing values with some constant values (0)
    # df['age'] = df['age'].fillna(0)

    # check the number of values missing in age column
    # print(f"after replacing NA with 0, no of records missing in age column = {df['age'].isna().sum()}")

    # check the mean of age column after filling the NA records with zero
    # because of filling the NA records with 0, the mean values changes which
    # is not acceptable solution
    # print(f"mean of age = {df['age'].mean()}")

    print()

    # calculate the mean value of age by skipping the NA records
    age_mean = df['age'].mean()

    # replace the missing values with mean of age column
    # for numeric data: use mean / median value
    # for textual data: use mode value
    df['age'] = df['age'].fillna(age_mean)

    # check the number of values missing in age column
    print(f"after replacing NA with mean, no of records missing in age column = {df['age'].isna().sum()}")

    # check the mean of age column after filling the NA records with mean
    print(f"mean of age = {df['age'].mean()}")


# function5()

# guidelines to deal with missing values
# - if > 60 % values are missing in a column then its better to delete the columns
# - if > 40 % of rows with missing values then its better to delete the rows
# - if < 30 % of data is missing then its better to replace them with mean / median / mode

# please note:
# - the above are only the GUIDELINES AND NOT THE RULES
# - the above guidelines may vary from dataset to dataset
# - the above guidelines are also dependent on the problem statement
#   and the dependent and independent variables

