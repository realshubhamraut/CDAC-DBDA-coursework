# import the mysql connector
import mysql.connector

host = "localhost"
user = "root"
password = "root"
database = "py_db"
port = 3306


def create_record():
    # step1: create a connection
    connection = mysql.connector.connect(
        host=host, user=user, password=password,
        database=database, port=port)

    # step2: prepare the sql statement
    first_name = input("enter your first name: ")
    last_name = input("enter your last name: ")
    age = int(input("enter your age: "))
    address = input("enter your address: ")
    sql_statement = f"insert into person (firstName, lastName, age, address) values ('{first_name}', '{last_name}', {age}, '{address}');"

    # step3: execute the sql statement
    # mediator between the application and the database
    cursor = connection.cursor()
    cursor.execute(sql_statement)

    # step4: commit the changes (in case of insert, delete and update)
    connection.commit()

    # step5: close the resources
    cursor.close()
    connection.close()


# create_record()


def read_records():
    # step1: create a connection
    connection = mysql.connector.connect(
        host=host, user=user, password=password,
        database=database, port=port)

    # step2: prepare sql statement
    statement = "select id, firstName, lastName, age, address from person"

    # step3: execute the statement
    cursor = connection.cursor()
    cursor.execute(statement)

    # step4: process the result (in case of select)
    data = cursor.fetchall()
    print(data)
    # print all the records field by field
    for (id, first_name, last_name, age, address) in data:
        print(f"id: {id}")
        print(f"first name: {first_name}")
        print(f"last name: {last_name}")
        print(f"age: {age}")
        print(f"address: {address}")
        print()

    # step 5: close the resources
    cursor.close()
    connection.close()


# read_records()


def update_record():
    # step1: create a connection
    connection = mysql.connector.connect(
        host=host, user=user, password=password,
        database=database, port=port)

    # step2: prepare the sql statement
    id = int(input("enter id of record you want to update: "))
    first_name = input("enter your first name: ")
    last_name = input("enter your last name: ")
    age = int(input("enter your age: "))
    address = input("enter your address: ")
    sql_statement = f"update person " \
                    f"set" \
                    f" firstName = '{first_name}', " \
                    f" lastName = '{last_name}', " \
                    f" age = {age}, " \
                    f" address = '{address}'" \
                    f"where id = {id};"

    # step3: execute the sql statement
    # mediator between the application and the database
    cursor = connection.cursor()
    cursor.execute(sql_statement)

    # step4: commit the changes (in case of insert, delete and update)
    connection.commit()

    # step5: close the resources
    cursor.close()
    connection.close()


# update_record()


def delete_record():
    # step1: create a connection
    connection = mysql.connector.connect(
        host=host, user=user, password=password,
        database=database, port=port)

    # step2: prepare the sql statement
    id = int(input("enter id of record you want to update: "))
    sql_statement = f"delete from person " \
                    f"where id = {id};"

    # step3: execute the sql statement
    # mediator between the application and the database
    cursor = connection.cursor()
    cursor.execute(sql_statement)

    # step4: commit the changes (in case of insert, delete and update)
    connection.commit()

    # step5: close the resources
    cursor.close()
    connection.close()


delete_record()
