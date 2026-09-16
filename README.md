# B2B Sales Pipeline Analysis

## SQL + Power BI | Sales Performance | Business Insights

## Can high opportunity volume actually translate into higher sales?

This project analyses a fictional B2B technology company's sales pipeline using SQL and Power BI to identify performance differences across regions, sales agents, products and time periods - and translate those findings into actionable business questions and recommendations.

## Key Findings at a Glance

- Regional Performance: The East region recorded the lowest sales and opportunity volume, but the highest average won deal value.
- Sales Agents: Darcel Schlecht was a significant outlier in opportunity and won-deal volume, with an average won deal value well above the agent average.
- Products: Product win rates were relatively similar, while deal value and opportunity volume appeared to drive differences in sales.
- Time & Pipeline: Higher opportunity volume did not always translate into higher sales - July had more opportunities than June but generated substantially less     sales.

## Tools

- MySQL
- SQL
- Power BI
- DAX

## Project Scenario

Business Background
A fictional B2B technology company sells computer hardware products to business customers through a team of sales agents operating across multiple regional offices.

The company records information about its sales opportunities, including the customer account, product, sales agent, opportunity stage, engagement date, close date and deal value. Additional information is available about customer accounts, products and
the sales team. 

Management wants to better understand the company's sales pipeline and determine where there may be opportunities to improve sales performance.

## Business Objective

The objective of this analysis is to evaluate sales pipeline performance and provide data-driven insights and recommendations to support management decision-making.

The analysis focuses on four key areas:

• Regional Performance - How does sales performance differ between regional
offices?
• Sales Agent Performance - Which agents are generating strong sales and
opportunity volumes, and what might contribute to their performance?
• Product Performance - Which products are driving sales, and what factors
explain differences in product performance?
• Time & Pipeline Performance - How does sales performance change over time,
and does a high volume of opportunities consistently result in higher sales?

## Key Business Questions
Management would like answers to the following questions:
1. Which regional offices are generating the highest sales and opportunity volumes, and where may there be
opportunities for improvement?
2. Which sales agents are generating the greatest sales and opportunity volumes?
3. Are differences in product sales driven primarily by opportunity volume, win rates
or deal values?
4. Are there periods where a high number of opportunities does not translate into
high sales?
5. What practical actions could the business investigate based on the findings?

## Analytical Approach
To address these questions, the sales data was:
1. Checked and validated data using SQL
2. Explored to identify trends and differences in performance
3. Analysed across different regions, sales agents, time periods and products
4. Used to calculate key performance measures such as sales, won deals,
opportunities, win rates and average won deal values
5. Presented through an interactive Power BI dashboard
6. Used to develop business insights and recommendations
   
## Project Outputs

This project consists of:
1. SQL analysis – Data validation, standardization and exploratory analysis
2. Power BI dashboard – Interactive analysis of sales pipeline performance
3. Business insights and recommendations – Key findings identified from the
analysis
4. Supporting project document – Explanation of the business scenario and
analytical approach.

## Key Findings

### Regional Performance

#### Insight:
East Regional Office has the lowest sales ($3.09M) and opportunities (1858), but has the highest average won deal value ($2639.28).

#### Recommendation:
Investigate opportunities to increase the volume of sales opportunities in the east, while maintaining a relatively high won deal value.

### Sales Agent Performance

#### Insight:
Darcel Schlecht is a significant outlier in opportunity and won deal volume among sales agents. His average won deal value ($3304) is well above the agent average ($2361).

#### Recommendation:
Investigate the factors behind Darcel Schlecht's performance, and identify practices that could be used by other agents.

### Product Performance

#### Insight:
Products have similar win rates (60-65%), suggesting sales differences are driven by deal value and opportunity volume. GTXPro leads sales ($3.5M) while MG special generates least sales ($43.7k), despite having 1.2k opportunities, possibly due to low average won deal value ($55).

#### Recommendation:
Investigate large differences in average deal value between products, and assess opportunities to increase revenue per sale.


### Time & Pipeline Performance

#### Insight:
Sales fluctuate throughout the year, with recurring quarter-end peaks.
Opportunity volume doesn't always translate into higher sales: July had highest opportunity volume (796), but $700k sales, whereas June had 681 opportunities and $1.34M.

#### Recommendation:
Investigate months with lower win rates, and identify opportunities to improve high opportunity volume into sales.


## Dataset

The project uses a fictional B2B sales pipeline dataset.

The dataset is not currently included in this repository. The original dataset source will be referenced here.

## Disclaimer

This is a portfolio project using fictional business data. The business scenario, analysis and recommendations are for demonstration purposes.
