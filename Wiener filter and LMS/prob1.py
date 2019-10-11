from pandas import Series
import numpy as np
import random
import matplotlib.pyplot as plt
series = [random.gauss(0,1) for i in range(1000)]
series = Series(series)
#print(series.describe())
series.plot()
plt.show()