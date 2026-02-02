import numpy as np
import pandas as pd


def function1():
    # read data from csv file
    df = pd.read_csv('./data/titanic.csv')

    # get all the columns from the dataframe
    print(df.columns)

    # unwanted columns:
    # - name, ticket, fare, cabin, embarked, boat, body, home.dest

    # solution:

    # remove those columns one by one
    # df2 = df.drop('name', axis=1)
    # df2 = df2.drop('ticket', axis=1)

    # remove all those unwanted columns at once
    # create a new copy (?: pandas optimizes the memory)
    # of df by removing these columns and store it with
    # new reference of df2
    df2 = df.drop(['name', 'ticket', 'fare', 'cabin', 'embarked', 'boat', 'body', 'home.dest'], axis=1)
    print(df2.columns)

    # remove all those unwanted columns at once
    # instead of creating new copy, modify the existing one (inplace=True)
    # df.drop(
    #     ['name', 'ticket', 'fare', 'cabin', 'embarked', 'boat', 'body', 'home.dest'],
    #     axis=1, inplace=True)
    # print(df.columns)

    # save the changes to the disk
    # df2.to_csv('./data/titanic_updated.csv')
    # df2.to_json('./data/titanic_updated.json')


# function1()


def function2():
    # read data from csv file
    df = pd.read_csv('./data/Salary_Data.csv')

    # add new column
    df["Bonus"] = df['Salary'] * 0.1
    df["NewSalary"] = df['Salary'] + df['Bonus']
    print(df)
    df.to_csv("./data/new_salary_data.csv")


# function2()


def function3():
    df = pd.read_csv('./data/titanic.csv')

    # replacing the NA values with mean
    df['age'] = df['age'].fillna(df['age'].mean())

    # add a new column based on the age value
    df['VotingEligible'] = df['age'] >= 18

    # replace True with 1 and False with 0
    df['VotingEligible'] = df['VotingEligible'].replace(True, 1)
    df['VotingEligible'] = df['VotingEligible'].replace(False, 0)

    print(df['VotingEligible'])

    df.to_csv("./data/titanic_with_voting_eligibility.csv")


# function3()


def function4():
    # read the data
    df = pd.read_csv('./data/nba.csv')
    # print(df)
    # print(df.info())

    # fill the missing Salary values with mean
    df['Salary'] = df['Salary'].fillna(df['Salary'].mean())
    # print(df['Salary'].isna().sum())

    # remove Number column
    df.drop('Number', axis=1, inplace=True)
    # print(df.columns)

    # add bonus column based on salary * 10
    df['Bonus'] = df['Salary'] * 0.10

    # add newSalary column = salary + bonus
    df['NewSalary'] = df['Salary'] + df['Bonus']

    # fill the missing College values with mode
    mode = df['College'].mode()
    df['College'] = df['College'].fillna(mode[0])
    # print(df['College'].isna().sum())

    # save the changes to a file named new_nba.csv
    # df.to_csv('./data/new_nba.csv')


# function4()


def function5():
    # read the data
    df = pd.read_csv('./data/nba.csv')

    # get these operations performed on each of the columns
    # print(df.sum())
    # print(df.mean())
    # print(df.min())
    # print(df.max())
    # print(df.count())

    # function which is applicable only for numeric columns
    # print(df['Salary'].sum())
    # print(df['Salary'].mean())
    # print(df['Salary'].max())
    # print(df['Salary'].min())
    # print(df['Salary'].count())


# function5()
