!pip install psycopg2-binary sqlalchemy
from sqlalchemy import create_engine, text
connection_string = "postgresql://postgres.qsaroowuntaedtumrjef:pass@aws-0-ap-southeast-2.pooler.supabase.com:5432/postgres"
engine = create_engine(connection_string)
import pandas as pd
df = pd.read_csv("Online Sales Data-m.csv")
print(df.head())
print(df.info())
print(df.describe())
cols_check = [col for col in df.columns if col not in ["Transaction ID"]]
print(df.duplicated(subset=cols_check).sum())
df.to_sql('raw_sales' , engine , if_exists='replace' , index=False)