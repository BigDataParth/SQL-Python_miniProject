# SQL-Python_miniProject

# Data Engineering Mini Project: Kaggle Dataset to MS SQL Server

## 📌 Project Overview
This project demonstrates the end-to-end process of fetching a dataset from Kaggle, processing it using Pandas in Jupyter Notebook, and loading it into MS SQL Server for analysis. The project follows the following steps:

1. **Fetch dataset from Kaggle API**
2. **Load dataset into the system**
3. **Use Pandas to clean and process the CSV file in Jupyter Notebook**
4. **Load processed data into MS SQL Server using SQLAlchemy and pyodbc**
5. **Perform SQL queries to analyze and extract useful insights**

## 📂 Project Structure
```
📁 Kaggle-to-SQL-Analysis
│── 📄 README.md          # Project documentation
│── 📄 main.ipynb     # Jupyter Notebook with data processing steps
│── 📄 orders.csv        # Sample dataset (optional)
│── 📄 sql_queries.sql    # SQL queries for analysis
```

## 🛠️ Tools & Technologies Used
- **Python**
- **Jupyter Notebook**
- **Pandas**
- **Kaggle API**
- **SQLAlchemy & pyodbc** (for connecting to MS SQL Server)
- **Microsoft SQL Server** (for storing and analyzing data)

## 🔧 Installation & Setup

### 1 Set Up Kaggle API
- Create an account on [Kaggle](https://www.kaggle.com/)
- Get your Kaggle API key from `Account Settings`
- Place `kaggle.json` in the `~/.kaggle/` directory

### 4️⃣ Run Jupyter Notebook
```bash
jupyter notebook
```
Open `notebook.ipynb` and execute the cells step by step.

### 5️⃣ Set Up MS SQL Server Connection
Modify the connection string in the notebook to match your SQL Server details:
```python
from sqlalchemy import create_engine
import pyodbc

server = 'PARTH\SQLEXPRESS'
database = 'master'
username = 'parth'
password = 'your_password'

driver = '{ODBC Driver 17 for SQL Server}'
engine = create_engine(f'mssql+pyodbc://{username}:{password}@{server}/{database}?driver={driver}')
```

### 6️⃣ Load Data into SQL Server
Run the script in the notebook to write the DataFrame to SQL Server:
```python
df.to_sql('df_orders', con=engine, if_exists='replace', index=False)
```

## 📊 SQL Analysis
After loading the data into MS SQL Server, execute the queries in `sql_queries.sql` to analyze the dataset. Some example queries include:
-- For each category ,highest sale month

with cte as (
select category,format(order_date,'yyyyMM') as order_year_month
, sum(sale_pricee) as sales 
from df_orders
group by category,format(order_date,'yyyyMM')
--order by category,format(order_date,'yyyyMM')
)
select * from (
select *,
row_number() over(partition by category order by sales desc) as rn
from cte
) a
where rn=1


## 🚀 Outcomes & Insights
- Successfully fetched and processed data from Kaggle
- Cleaned and transformed the dataset using Pandas
- Stored data in MS SQL Server using SQLAlchemy and pyodbc
- Performed SQL queries to extract insights from the data

## 📢 Contributing
Feel free to raise issues or contribute by submitting pull requests!

## 🏆 Author
- **Your Name**
- **LinkedIn:** [Parth Bhavthankar](www.linkedin.com/in/parthbhavthankar)
- **GitHub:** [BigDataParth](https://github.com/BigDataParth)

---
### ⭐ If you found this project useful, don't forget to give it a star! ⭐

