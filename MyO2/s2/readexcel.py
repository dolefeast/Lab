import pandas as pd

data = pd.read_excel(r'myosesion2.xlsx')
df = pd.DataFrame(data, colums=['log(A)'])
