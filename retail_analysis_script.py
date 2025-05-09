
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load the dataset
df = pd.read_csv("retail_sales_data.csv", parse_dates=['Order_Date', 'Ship_Date'])

# Basic cleanup
df.dropna(subset=['Sales', 'Profit', 'Inventory_Turnover_Days'], inplace=True)

# Calculate Profit Margin
df['Profit_Margin'] = df['Profit'] / df['Sales']

# Correlation analysis
corr = df[['Profit_Margin', 'Inventory_Turnover_Days']].corr()
print("Correlation Matrix:\n", corr)

# Plot: Profit Margin vs. Inventory Turnover Days
plt.figure(figsize=(8, 6))
sns.scatterplot(data=df, x='Inventory_Turnover_Days', y='Profit_Margin', hue='Category')
plt.title("Profit Margin vs Inventory Turnover Days")
plt.xlabel("Inventory Turnover Days")
plt.ylabel("Profit Margin")
plt.tight_layout()
plt.show()

# Boxplot: Seasonal Profitability by Category
plt.figure(figsize=(10, 6))
sns.boxplot(data=df, x='Season', y='Profit_Margin', hue='Category')
plt.title("Seasonal Profitability by Category")
plt.tight_layout()
plt.show()

# Save correlation to CSV
corr.to_csv("correlation_analysis.csv")
