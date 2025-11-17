x = 2+3
str(x)                                      # default data type = numeric ~ float(python)

x1 = 9L                                     # explicitly store as int
str(x1)

                                            # int = 4 bytes
                                            # numeric = 8 bytes

x2 = "shubham"                            
x3 = "payal's laptop"
x4 = 'payal\'s laptop'

x1 = TRUE
x2 = FALSE
str(x1)


x6 = readline("enter your name ")              # same as python input()
x6

x7 = as.numeric(readline('enter your age '))
str(x7)

x8 = scan()                                    # values are stored in vector, just like python list
x8                                             # because indexing starts with 1, instead of 0
str(x8)                                        # num [1:4]   -> basically vector



x9 = scan(what = character())                 # basically explicitly specify the types of input, because we can't really store heterogenious values like python
x9                                            # boolean, character, numeric

x10 = c(1,2,3,4,1)                            # creating a basic vector
str(10)
length(x10)


x11 = c(34,'Shubham', 21)                     # if we try to pass different data types in vectors, they get converted to string
x11


x12 = c(x10,x9)                               # combining two vectors
x12


x10 = append(x10, 10)
x10



x10[7] = 3.4                                  # inserting at specific index, 
x10


x10 = append(x10, 6.1,2)                      # assign at specific index [reference, value, index]
x10

x10 = x10[-2]                                 # removing from specific index
x10


x12 = c(4,8,7,6,9)
sum(x12)
min(x12)
max(x12)
prod(x12)
cumsum(x12)                                  # gives value upto the last index adding previous element
cumsum(x12)[4]                               # first n

cummin(x12)                                  # gives min [4,4,4,4,4]
cummax(x12)                                  # gives max [4,8,8,8,9]

log(x12)                                     # logs for each n in x12
2.718 ** log(x12)                            # converted in exponentials from logs (approx vals)

x13 = log(x12, 5)                            # custom log (here 5) instead of default 10
5 ** x13
