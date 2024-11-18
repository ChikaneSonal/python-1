import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress

# Import data
df = pd.read_csv("epa-sea-level.csv")

# Draw Plot
def draw_plot():
    # Create scatter plot
    plt.figure(figsize=(10, 6))
    plt.scatter(df['Year'], df['CSIRO Adjusted Sea Level'], color='blue', label="Data")

    # Create first line of best fit (1880-2050)
    slope, intercept, r_value, p_value, std_err = linregress(
        df['Year'], df['CSIRO Adjusted Sea Level']
    )
    x_pred = pd.Series(range(1880, 2051))
    y_pred = intercept + slope * x_pred
    plt.plot(x_pred, y_pred, 'r', label='Best Fit Line (All Data)')

    # Create second line of best fit (2000-2050)
    df_recent = df[df['Year'] >= 2000]
    slope_recent, intercept_recent, r_value_recent, p_value_recent, std_err_recent = linregress(
        df_recent['Year'], df_recent['CSIRO Adjusted Sea Level']
    )
    x_pred_recent = pd.Series(range(2000, 2051))
    y_pred_recent = intercept_recent + slope_recent * x_pred_recent
    plt.plot(x_pred_recent, y_pred_recent, 'green', label='Best Fit Line (2000-Present)')

    # Add labels, title, and legend
    plt.title("Rise in Sea Level")
    plt.xlabel("Year")
    plt.ylabel("Sea Level (inches)")
    plt.legend()

    # Save plot and return figure
    plt.savefig('sea_level_plot.png')
    return plt.gca()
