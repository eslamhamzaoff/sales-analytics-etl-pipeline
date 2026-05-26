import pandas as pd
from sqlalchemy import create_engine

USERNAME = 'postgres'
PASSWORD = 'postgres123'

HOST = 'localhost'
PORT = '5432'

DATABASE = 'sales_analytics_db'

DATABASE_URL = (
    f"postgresql+psycopg2://{USERNAME}:{PASSWORD}"f"@{HOST}:{PORT}/{DATABASE}"
)

engine = create_engine(DATABASE_URL)

df = pd.read_csv("data/processed/cleaned_superstore.csv")

df["order_date"] = pd.to_datetime(df['order_date'])
df["ship_date"] = pd.to_datetime(df["ship_date"])

print("Loading data from csv into staging table in db...")

df.to_sql(
    name="stg_orders",
    con=engine,
    if_exists='append',
    index=False
)

print('Data loaded successfully')