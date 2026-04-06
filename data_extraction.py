import kagglehub

path = kagglehub.dataset_download("olistbr/brazilian-ecommerce")

print("Path to dataset files:", path)


import pandas as pd
import os

# Use the path variable from before
csv_file_path = os.path.join(path, "olist_customers_dataset.csv")

# Load the data
df = pd.read_csv(csv_file_path)

# See the first few rows
print(df.head(10))