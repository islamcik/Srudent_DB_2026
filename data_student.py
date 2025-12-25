import pandas as pd
from sqlalchemy import create_engine

# Load CSV
data = pd.read_csv("Student_Performance_Dataset.csv")

# Check missing values and data info
print(data.isna().sum())
print(data.info())

# Create MySQL connection
engine = create_engine(
    "mysql+pymysql://islam:****@localhost:3306/Student"
)

# Write DataFrame to MySQL table
data.to_sql(
    name="student_performance",
    con=engine,
    if_exists="replace",
    index=False
)

