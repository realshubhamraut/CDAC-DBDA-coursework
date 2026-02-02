# beautiful soup
# - used to scrape the information from html structure

from bs4 import BeautifulSoup


def read_data_from_file(file_name):
    data = ''
    with open(file_name, 'r') as file:
        data = file.read()

    return data


def function1():
    # read html data from a html file
    data = read_data_from_file('test-page1.html')
    # print(data)

    # create the html parser
    # - the object soup here is an object of parser
    # - parser:
    #   - entity which understands the structure and helps you
    #     to extract the information you are looking for
    #   - types: json parser, excel parser, xml parser, html parser
    #   - every parser is dependent on the file structure
    soup = BeautifulSoup(data, 'html.parser')

    # parse the html using the parser
    # print(soup)

    # find the content within the title tag
    # tag_title = soup.find('title')
    # print(tag_title.text)

    # find the content within h1 tag
    # tag_h1 = soup.find('h1')
    # print(tag_h1.text)

    # find the content with the first div tag
    # tag_div = soup.find('div')
    # print(tag_div.text)

    # find the contents within every div
    # it returns an array of div tags
    # tags_div = soup.find_all('div')
    # print(tags_div)
    # for tag_div in tags_div:
    #     print(tag_div.text)

    # find the ul structure and then extract the li content
    # find the ul tag
    tag_ul = soup.find('ul')

    # find all li tags within the ul
    tags_li = tag_ul.find_all('li')
    for tag_li in tags_li:
        print(tag_li.text)


# function1()


def function2():
    # create the soup to parse test-page2.html
    data = read_data_from_file('test-page2.html')
    # print(data)
    soup = BeautifulSoup(data, "html.parser")

    # find the contents of a div having class test-class-1
    tag_div_test_class_1 = soup.find("div", {"class": "test-class-1"})
    print(f"contents of tag_div_test_class_1 = {tag_div_test_class_1.text}")

    # find the contents of a div having class test-class-2
    tag_div_test_class_2 = soup.find("div", {"class": "test-class-2"})
    print(f"contents of tag_div_test_class_2 = {tag_div_test_class_2.text}")

    # find out all the modules
    modules = []
    tag_ul_modules = soup.find("ul", {"id": "modules"})
    tag_li_modules = tag_ul_modules.find_all('li')
    for tag_li in tag_li_modules:
        modules.append(tag_li.text)
    print(modules)

    # find our all the cars
    cars = []
    tag_ul_cars = soup.find("ul", {"id": "cars"})
    tag_li_cars = tag_ul_cars.find_all('li')
    for tag_li in tag_li_cars:
        cars.append(tag_li.text)
    print(cars)


function2()

