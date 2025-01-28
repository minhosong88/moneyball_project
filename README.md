# Moneyball Project: Data Science and Machine Learning with R

This project is part of the **"Data Science and Machine Learning Bootcamp with R"** on Udemy. It applies data science techniques to solve a classic problem inspired by the movie _Moneyball_: finding cost-effective replacements for baseball players using performance metrics and salary constraints.

## Objective

The goal of this project is to identify **three players** to replace key lost players (`giambja01`, `damonjo01`, `saenzol01`) from the 2001 season, under the following conditions:

1. The total combined salary of the replacements is less than $15M.
2. The combined **At-Bats (AB)** of the replacements is greater than or equal to the combined AB of the lost players (1469).
3. The average **On-Base Percentage (OBP)** of the replacements is greater than or equal to the lost players' average OBP (0.3638).

## Data

Two datasets are used:

1. **Batting Data**: Contains historical player performance metrics such as hits, at-bats, and home runs.
2. **Salary Data**: Contains player salary information.

## Tools and Libraries

The following R libraries were used:

- **dplyr**: For data manipulation and filtering.
- **ggplot2**: For data visualization.
- **plotly**: To create interactive plots.
- **scales**: For custom axis labeling in plots.

## Feature Engineering

New metrics were calculated to assess player performance:

1. **Batting Average (BA)**: `H / AB`
2. **On-Base Percentage (OBP)**: `(H + BB + HBP) / (AB + BB + HBP + SF)`
3. **Slugging Percentage (SLG)**: `((1B) + (2*2B) + (3*3B) + (4*HR)) / AB`

These metrics provide a deeper understanding of a player's contribution to the game beyond basic stats.

## Analysis Process

1. **Data Preprocessing**:

   - Removed data before 1985 to match the salary dataset.
   - Merged the Batting and Salary datasets by `yearID` and `playerID`.

2. **Analyzing Lost Players**:

   - Filtered the data to identify the three lost players in 2001.
   - Calculated their combined AB and average OBP.

3. **Finding Replacement Players**:

   - Narrowed down candidates using heuristic filtering:
     - Salary < $8M.
     - AB between 450 and 500.
     - OBP between 0.2 and 0.5.
   - Sorted the remaining players by descending OBP.
   - Selected the top three players:
     - **martied01**: OBP 0.423, Salary $5.5M, AB 470
     - **catalfr01**: OBP 0.391, Salary $0.85M, AB 463
     - **gracema01**: OBP 0.386, Salary $3M, AB 476

4. **Visualization**:
   - Created a scatter plot using `ggplot2` with:
     - **OBP** on the x-axis and **salary** on the y-axis.
     - Points colored by **AB**.
   - Highlighted the selected players in red.
   - Enhanced interactivity using `ggplotly`.

## Results

The visualization clearly shows the selected replacement players and their respective OBP, salary, and AB. The selection adheres to the given constraints while optimizing OBP.

### Scatter Plot

The scatter plot includes:

- **All players**: Shown as gray points.
- **Selected players**: Highlighted in red.
- **Axis scaling**:
  - Salary shown in millions using the `scales` package.
  - OBP limited to the range [0.2, 0.5].

## Conclusion

This project demonstrates how to use R for feature engineering, data visualization, and decision-making in a real-world context. The solution adheres to constraints and provides optimal replacements for the lost players. The interactive plot allows for detailed exploration of player data, making the analysis intuitive and user-friendly.
