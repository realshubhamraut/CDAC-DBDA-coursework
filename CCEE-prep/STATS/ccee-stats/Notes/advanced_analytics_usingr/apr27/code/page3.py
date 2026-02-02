from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from database import Database


def function1():
    # open the driver to control the browser
    browser = webdriver.Chrome()

    # go to the google.com
    browser.get("https://google.co.in")

    # wait for 5 seconds
    time.sleep(5)

    # close the browser
    browser.close()


# function1()


def function2():
    # url of data source
    url = "https://www.accuweather.com/en/in/pune/204848/daily-weather-forecast/204848"

    # start the driver
    browser = webdriver.Chrome(r"C:\Users\SHUBHAM\PycharmProjects\babysteps\chromedriver.exe")

    # open the website
    browser.get(url)

    # wait for two seconds
    time.sleep(2)

    # start parsing the structure and extract the data
    div_page_column_1 = browser.find_element(By.CLASS_NAME, "page-column-1")
    # print(div_page_column_1)

    # find out the div element with class daily-wrapper
    divs_daily_wrapper = div_page_column_1.find_elements(By.CLASS_NAME, "daily-wrapper")
    # print(divs_daily_wrapper)

    # collect all the rows
    rows = 'day,date,high_temp,low_temp,precipitation\n'

    for div_daily_wrapper in divs_daily_wrapper:
        # find the day of the week
        tag_span_dow = div_daily_wrapper.find_element(By.CLASS_NAME, 'dow')
        day = tag_span_dow.text

        # find the date
        tag_span_date = div_daily_wrapper.find_element(By.CLASS_NAME, 'sub')
        date = tag_span_date.text

        # find the max temperature
        tag_span_max_temp = div_daily_wrapper.find_element(By.CLASS_NAME, 'high')
        max_temp = tag_span_max_temp.text.replace("°", "")

        # find the min temperature
        tag_span_min_temp = div_daily_wrapper.find_element(By.CLASS_NAME, 'low')
        min_temp = tag_span_min_temp.text.replace("°", "")
        min_temp = min_temp.replace("/", "")

        # find the precipitation
        tag_div_precip = div_daily_wrapper.find_element(By.CLASS_NAME, 'precip')
        # strip: used to remove the spaces in the beginning and ending
        precip = tag_div_precip.text.strip().replace('%', '')

        # add the current day info to the rows
        rows += f"{day},{date},{max_temp},{min_temp},{precip}\n"

    print(rows)

    # dump the data into a csv file
    with open('weather.csv', 'w') as file:
        file.write(rows)


function2()