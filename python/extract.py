import pandas as pd
from pathlib import Path 

RAW_DATA_PATH = Path("data/raw/Superstore.csv") 
PROCESSED_DATA_PATH = Path("data/processed/cleaned_superstore.csv")

PROCESSED_DATA_PATH.parent.mkdir(parents= True , exist_ok = True)

print("Reading dataset...")

df = pd.read_csv(RAW_DATA_PATH, encoding='latin1')

print(df.head())
print(df.info())

print('Missing Vales: ')
print(df.isnull().sum())

df = df.drop_duplicates()
df.columns = [col.lower().replace(" ", "_") for col in df.columns]

df.to_csv(PROCESSED_DATA_PATH, index = False)

print("Cleaned dataset saved successfully") 

