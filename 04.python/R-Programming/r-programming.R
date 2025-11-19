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
2.718 ** log(x12)                            # converted in exponential from logs (approx vals)

x13 = log(x12, 5)                            # custom log (here 5) instead of default 10
5 ** x13


x14 = c(3,4,7,2)
x15 = c(8,3,6,5,12,14)
x16 = x14+x15                               # while length(x14) is in multiple of(x15)
                                            # we can add each value for each other opposite value on from the different vector,
                                            # the adding starts from first element once again if one of the vector goes out or elements (for each next equivalent element)
                                            # if uneven length then only partial cycling

x17 = c(4,2,1)                              # here in the second occurrence the last [1] will be left out
x18 = c(7,6,4,1,5) 
x19 = x17 + x18
x19

x14-5                                       # essentially we are performing action on each element of the vector
x15
x20 = c(12,44,12,13,15,51,64)
x21 = x20[c(1,3,5)]
x21


x22 = x20[c(2,5,7)] = c(13,18,14)
x22

x23 = x20[c(1,3,5,6)] = c(12,14)
x23 =


x20
x20 = x20[-c(1,4)]                          # deleting multiple values from an vector, choose particular indexes
x20


x1 = c(11,12,13)
x1


                                            # seq command
x1 = seq(14,39,2)                           # seq (start,end,step)
x1

x1 = seq(40,2,-2)                           # works with reverse as well
x1

x1 = seq(10,70,length.out=20)               # equal 20 gapped partitions between 10,70
x1                                          # so (70-10)/20 = gap value

                                            # rep command
x2 = rep(c(x1),3)                           # repeating n times 
x3 = rep(c(x1), each = 3)                   # each repeats stored close to same number ex = [10,10,10]
x3
x1
x4 = rep(c(x1),times = c(3,4,1))            # we need same number of elements in the times as x1 to run, otherwise won't run
a1 = TRUE
a2 = FALSE

a1 ^ a2
a3 = a1 & a2                                # true and false = true

a3 = a1 | a2                                # true and false = true
a3

!a1                                         # negate


x1 = c(9,4,2,3,6,7,1)

# suppose:
  
# what are the indices where the value is >=4
# what are the values in x1 which are >=4 
# how many values are >=4


t1 = which(x1>=4)
# input to the which command is a condition/s which are needed to be checked (note - indexes are returned)
# output of the which command are the indices where the condition/s are found to be true

x1[t1]                                    # this returns the elements from those indices stored in t1


m1 = matrix(1:24, nrow=4)                    # this equally divides and creates matrix
m2 = matrix(1:24, nrow=5)                    # this will make the elements recycle again until the all 5
m1
m2

m3 = matrix(1:24,ncol=6, nrow=5)
m3

m4 = matrix(1:24,ncol=6,byrow=T)
m4

x1 = c(3,12,5,11)
x2 = c(12,1,5,1)
x3 = c(14,5,1,3)

x4 = rbind(x1,x2,x3)                         # row bind
x4


x5 = cbind(x1,x2,x3)                               # column bind
x5
str(m1[1,5])                                           # extracting the value from the matrix is by giving [row, col] number
x5 = c(m1[3,2], m1[4,3])
x5

x5[,1]
x5[2,]
m1
m1 = rbind(m1,c(1,2,4,9,8),c(1,4,1,5,3))
m1

m1=c(m1[,1],m1[2,])
m1


m1[c(1,3)]

m5 = matrix(1:24, nrow =6)
m5
m5 = cbind(m5, c('a','b','h','t','4','e'))                                         # if we bind more values which are char then entire matrix gets converted into the char
m5

# default data type for matrix = int, and dataframe = num
# extracting column from dataframe gives the vector


# creating a table/data.frame

stu_df = data.frame(Name=c('yash','shubh','prem'), Marks = c(12,15,12))             # creating the dataframe
stu_df
stu_df[2,2] + 10
mark_ext = stu_df[,2]                      
mark_ext
stu_df$Marks            # works only in the dataframe extracting the values refering directly column



x = c(6,4,7,4,8,6,5,9,5,8)
weeknd = which(x>=7)
weeknd
weeknd[x]
y = 1000

paid_every_day = c(x*y)
paid_every_day


getwd()
setwd("/Users/proxim/Desktop")









# INR 1000 per hour for classes on weekdays and INR 2000 per hour for classes on weekends
# I start my classes on Monday and continue for consecutive 10 days
# 6,4,7,4,8,6,5,9,5,8 ---> number of hours on each day
# what is my final payment

  
a = c(6,4,7,4,8,6,5,9,5,8)
b = c(rep(1000 * 5), 2000,2000)
c = a * b
c
total_payment = cumsum(c)[length(c-1)]
total_payment

weekday = which(c>7500)
weekday

#==================== read excel data ========================

df = read_excel('ui.xlsx', sheet = 'aug 25')
df
marks = df$marks
marks
marks_abv = which(marks>=60)
ppl = df$student_name[marks_abv]
ppl

v1 = df[which(df$marks>60 & df$location=="MUM")]
v1
df

# global variables = we can refer directly in our function and we can use it

myfunc = function(a,b){
  c = 2*a+b
  print(c)    
}

p1 = 3.14
myfucn = function(a,m=2,b){
  c = m*a+b+pi
}

myfucn(12,,2)


myfunc = function(a,b){
  c = 2 *a+b
  print(c)
}
myfunc(12,11)

# remove specific element

val = c(9,3,1,4,3,1,6)
func1 = function(val, a){
  i = which(val==a)
  val = val[-i[1]]
  print(val)
}

func1(val,1)

# conditional statements

caltax = function(sal){
  if (sal<=20000){
  tax = sal * 0.05
  } else {
    if (sal<=50000){
      tax = 0.10*sal
    } else {
      tax = 0.15 * sal
    }
  }
  print(tax)
}
caltax(100000)

vect1 = c(4,3,5,6,0,7,2)
for (ctr in vect1) {
  print(ctr**2)
}

# with inputs

{
num = as.numeric(readline("how many numbers you wish to enter"))
vect1 = c()
for (ctr in 1:num){
  n2 = as.numeric(readline("enter the value"))
  vect1 = append(vect1,n2)
  
}
  print(vect1)

}


{
  vect1=c()
  num = 7
  while (num!=0){
    num = as.numeric(readline("Enter the value: "))
    vect1 = append(vect1,num)
  }
  print(vect1)
}

{
  for (ctr in vect1){
    
    if (ctr != 1 & ctr != 0){
      print(ctr**2)
    }
  }
}

for (ctr1 in 2:4){
  for (ctr2 in 2:5){
    if (ctr2==4){
      break
    }
    print(ctr1*ctr2)
  }
}

df = data.frame(Students = c('A','B','C'), marks_java = c(40,60,70))
df
marks_R = c(90,30,80)

# adding new column created as individual vector
df = cbind(df,marks_R)

df$Final_marks = df$marks_java + df$marks_R


head(mtcars)


# adding the new column by calculating something
mtcars$Ratio = round(mtcars$mpg / mtcars$wt,2)


df1 = mtcars
head(df1)
nrow(df1)
ncol(df1)
df1$ratio = df1$mpg/df1$wt
ncol(df1)


# calculate car name with the max ratio
rownames(df1)
rownames(df1)[which(df1$ratio == max(df1$ratio))]


# categories the ratio's in ('A','B','C')

{
  category = c()
  for (i in df1$ratio) {
    if (i <=12){
      category = append(category, 'A')
    } else {
      if(i <=15){
        category = append(category, 'B')  
      } else {
        category = append(category, 'C')
      }
    }
  }
}
   
df1 = cbind(df1, category=category)

library(readxl)
setwd("/Users/proxim/Desktop")

df = read_excel('CDAC_DataBook.xlsx', sheet= 'EmpInfo')
df = "CDAC_DataBook.xlsx"
df


# dealing with missing values, dealing with duplicate values
df1 = df[which(is.na(df$Deptt)),c(1,2)]
df2 = df[which(!is.na(df$Deptt)),]

df1
df2

df3 = df[which(is.na(df$EmpID & df$Deptt)),]
df3 = df[which(is.na(df$EmpID) & is.na(df$Deptt)),]

which(complete.cases(df))

x1 = c(4,6,3,2,7,6,8,5)
x2 = c(1,4,7)
which(x1 %in% x2)
x1[c(1,5)]


t1 = which(duplicated(df$Passport))

d1 = unique(df$Passport[t1])

which(!df$Passport %in% d1)

df0 = airquality
head(df0)
df2= df[which(is.na(df0$Ozone & df0$Solar.R)),]
df2
length(which(is.na(df0$Ozone) | is.na(df0$Solar.R)))

length(which(is.na(df0$Temp>65) | is.na(df0$Solar.R)))
l

       