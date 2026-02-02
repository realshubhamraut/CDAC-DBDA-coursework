import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def function1():
    df = pd.read_csv("weather.csv")
    # print(df)

    x_values = np.arange(df['high_temp'].size)
    plt.scatter(x_values, df['high_temp'], color="red", label="High Temperature")
    plt.plot(x_values, df['high_temp'], color="red")

    plt.scatter(x_values, df['low_temp'], color="green", label="Low Temperature")
    plt.plot(x_values, df['low_temp'], color="green")

    plt.scatter(x_values, df['precipitation'], color="blue", label="Precipitation")
    plt.plot(x_values, df['precipitation'], color="blue")

    plt.legend()

    plt.title("Weather")
    plt.tight_layout()
    plt.show()


function1()
