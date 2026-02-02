from bs4 import BeautifulSoup
from database import Database
import json


def read_db_config():
    config = None
    with open('./config.json', 'r') as file:
        config = json.load(file)['db']

    print(config)
    return config


def read_data_from_file(file_name):
    data = ''
    with open(file_name, 'r') as file:
        data = file.read()

    return data


def function1():
    # create db connection
    db = Database(read_db_config())

    # create the soup
    data = read_data_from_file("test-page3.html")
    soup = BeautifulSoup(data, 'html.parser')

    # find the div element having class page-column-1
    div_page_column_1 = soup.find("div", {"class": "page-column-1"})
    # print(div_page_column_1)

    # find out the div element with class daily-wrapper
    divs_daily_wrapper = div_page_column_1.find_all('div', {"class": "daily-wrapper"})
    for div_daily_wrapper in divs_daily_wrapper:
        # find the day of the week
        tag_span_dow = div_daily_wrapper.find('span', {'class': 'dow'})
        print(tag_span_dow.text)

        # find the date
        tag_span_date = div_daily_wrapper.find('span', {'class': 'sub'})
        print(tag_span_date.text)

        # find the max temperature
        tag_span_max_temp = div_daily_wrapper.find('span', {'class': 'high'})
        max_temp = tag_span_max_temp.text.replace("°", "")
        print(max_temp)

        # find the min temperature
        tag_span_min_temp = div_daily_wrapper.find('span', {'class': 'low'})
        min_temp = tag_span_min_temp.text.replace("°", "")
        min_temp = min_temp.replace("/", "")
        print(min_temp)

        # find the precipitation
        tag_div_precip = div_daily_wrapper.find('div', {'class': 'precip'})
        # strip: used to remove the spaces in the beginning and ending
        precip = tag_div_precip.text.strip().replace('%', '')
        print(precip)

        # insert the data into database
        statement = f"insert into weather " \
                    f"(dayOfWeek, date, highTemperature, lowTemperature, precipitation) " \
                    f"values" \
                    f"('{tag_span_dow.text}', '{tag_span_date.text}', '{max_temp}', '{min_temp}', '{precip}')"

        print(statement)
        db.execute_dml_query(statement)


function1()
