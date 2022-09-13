import pandas as pd
from tabulate import tabulate

d = {'col1': [1, 2], 'col2': [3, 4]}
df = pd.DataFrame(data=d)

tab_df = tabulate(df, headers='keys', tablefmt='psql')

print(f"this is a pandas dataframe:\n{tab_df}")