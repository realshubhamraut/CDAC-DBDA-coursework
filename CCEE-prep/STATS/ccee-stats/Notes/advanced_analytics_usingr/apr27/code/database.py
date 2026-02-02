# this module is used to perform all the database operations
import mysql.connector


class Database():
    def __init__(self, config):
        # create db connection
        self.__connection = mysql.connector.connect(
            user=config['user'],
            host=config['host'],
            password=config['password'],
            database=config['database'],
            port=config['port']
        )
        print(self.__connection)

    def __del__(self):
        print("-- closing the connection")

        # close the connection
        self.__connection.close()

    def execute_dml_query(self, query):
        # create a cursor to perform operations
        self.__cursor = self.__connection.cursor()

        # execute the query
        self.__cursor.execute(query)

        # commit the changes
        self.__connection.commit()

        # close the cursor
        self.__cursor.close()

    def execute_select_query(self, query):
        # create a cursor to perform operations
        self.__cursor = self.__connection.cursor()

        # execute the query
        self.__cursor.execute(query)

        # return the result
        return self.__cursor.fetchall()
