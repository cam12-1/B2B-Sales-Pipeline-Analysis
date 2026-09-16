CREATE DATABASE pipeline_sales;

CREATE TABLE accounts LIKE accounts_raw;

INSERT INTO accounts
SELECT *
FROM accounts_raw;

CREATE TABLE sales_pipeline LIKE sales_pipeline;

INSERT INTO sales_pipeline_copy
SELECT *
FROM sales_pipeline;

RENAME TABLE products TO products_raw;



SELECT *
FROM sales_pipeline;

SELECT *
FROM sales_pipeline_copy;

-- Cleaning Data
-- checking datatypes
DESCRIBE sales_pipeline;

SELECT engage_date
FROM sales_pipeline
LIMIT 10;

SELECT *
FROM sales_pipeline
WHERE engage_date = ''
   OR close_date = '';

SELECT *
FROM accounts;

DESCRIBE sales_pipeline;

-- Changing engage_date and close_date columns to DATE
ALTER TABLE sales_pipeline
MODIFY engage_date DATE,
MODIFY close_date DATE; 

DESCRIBE sales_teams;

SELECT opportunity_id, COUNT(*)
FROM sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-------------------------------------------------------
-- Checking for duplicates
-- for sales_teams
SELECT sales_agent, COUNT(*) duplicate_count
FROM sales_teams
GROUP BY sales_agent
HAVING COUNT(*) > 1;

-- for accounts
SELECT account, COUNT(*) duplicate_count
FROM accounts
GROUP BY account
HAVING COUNT(*) > 1;

-- for products
SELECT product, COUNT(*) duplicate_count
FROM products
GROUP BY product
HAVING COUNT(*) > 1;

-- for sales_pipeline
SELECT opportunity_id, COUNT(*) duplicate_count
FROM sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- for accounts rows
SELECT account, sector, year_established, revenue, employees, office_location, subsidiary_of, COUNT(*) duplicate_count
FROM accounts
GROUP BY account, sector, year_established, revenue, employees, office_location, subsidiary_of
HAVING COUNT(*) > 1;

-- for sales_pipeline rows
SELECT opportunity_id, sales_agent, product, account, deal_stage, engage_date, close_date, close_value, COUNT(*) AS duplicate_count
FROM sales_pipeline
GROUP BY opportunity_id, sales_agent, product, account, deal_stage, engage_date, close_date, close_value
HAVING COUNT(*) > 1;

-- for sales_team rows
SELECT sales_agent, manager, regional_office, COUNT(*) AS duplicate_count
FROM sales_teams
GROUP BY sales_agent, manager, regional_office
HAVING COUNT(*) > 1;

-- for products rows
SELECT product, series, sales_price, COUNT(*) AS duplicate_count
FROM products
GROUP BY product, series, sales_price
HAVING COUNT(*) > 1;

-----------------------------------------------
-- Checking for missing values
-- for sales pipeline
SELECT *
FROM sales_pipeline;

SELECT *
FROM sales_pipeline
WHERE opportunity_id IS NULL OR opportunity_id = '' 
	OR sales_agent IS NULL OR sales_agent = ''
    OR product IS NULL OR product = ''
    OR account IS NULL OR account = ''
    OR deal_stage IS NULL OR deal_stage = ''
    OR engage_date IS NULL
    OR close_date IS NULL
    OR close_value IS NULL OR close_value = ''
    ;
-- nothing missing



-- for accounts
SELECT *
FROM accounts
WHERE account IS NULL OR account = '' 
	OR sector IS NULL OR sector = ''
    OR year_established IS NULL OR year_established = ''
    OR revenue IS NULL OR revenue = ''
    OR employees IS NULL OR employees = ''
    OR office_location IS NULL OR office_location = ''
    OR subsidiary_of IS NULL OR subsidiary_of;


SELECT COUNT(*) AS blank_subsidiary_of
FROM accounts
WHERE subsidiary_of IS NULL
   OR TRIM(subsidiary_of) = '';


-- for products
SELECT *
FROM products;
-- products we can visually see theres no missing values

-- for sales teams
SELECT *
FROM sales_teams;
-- sales_teams we can visually see theres no missing values
SELECT *
FROM sales_teams
WHERE manager = 'Melvin Marxen';


-- Standardizing
-- accounts

SELECT account
FROM sales_pipeline
WHERE account = 'Dambase';

SELECT DISTINCT account
FROM accounts
ORDER BY account;


SELECT *
FROM sales_pipeline;

SELECT *
FROM sales_pipeline
WHERE engage_date >= close_date;
-- engage date is always before the close date

SELECT *
FROM sales_pipeline 
WHERE close_value < 0;
-- no negative close values

SELECT *
FROM accounts
WHERE year_established <= 0;

SELECT year_established
FROM accounts
ORDER BY year_established;

-- all years established are reasonable values as they are greater than 0

-- analyzing the data
-- Overall Performance
-- Total Sales:
SELECT SUM(close_value) Total_Sales
FROM sales_pipeline;
-- The total sales / total revenue was $10005534 from November 2016 to December 2017.

-- Total number of opportunities
SELECT COUNT(*)
FROM sales_pipeline;
-- There were a total of 6711 opportunities

-- Number of won opportunities
SELECT COUNT(*) won_opportunties
FROM sales_pipeline
WHERE deal_stage = 'Won';
-- The number of opportunities won were 4238 from November 2016 to December 2017.

-- Number of lost opportunities
SELECT COUNT(*)
FROM sales_pipeline
WHERE deal_stage = 'Lost';
-- The number of opportunities lost were 2473 from November 2016 to December 2017.


-- Win Rate
SELECT SUM(IF(deal_stage = "Won", 1, 0))/ COUNT(*) Win_Rate
FROM sales_pipeline;
-- The win rate is 0.63 to two decimal places.

-- Loss Rate
SELECT SUM(IF(deal_stage = "Lost", 1, 0))/ COUNT(*) Loss_Rate
FROM sales_pipeline;
-- The loss rate is 0.37 to two decimal places

-- Average Deal Value for those that won
SELECT ROUND(AVG(close_value), 2) average_deal_value
FROM sales_pipeline
WHERE deal_stage = 'Won';
-- The average deal value for opportunities that won is 2360.91 to 2 decimal places.


----------
SELECT *
FROM sales_pipeline;
-- Sales Performance

-- Total revenue made from each agent
SELECT sales_agent, SUM(close_value) total_revenue
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY sales_agent
ORDER BY total_revenue DESC;

-- Number of sales won by agent
SELECT sales_agent, COUNT(*) number_of_opportunities, SUM(IF(deal_stage = "Won", 1, 0)) number_of_won_deals,
SUM(IF(deal_stage = "Won", 1, 0))/ COUNT(*) Win_Rate_per_Agent
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY Win_Rate_per_Agent DESC;

-- Average deal value by agent
SELECT sales_agent, ROUND(AVG(close_value), 2) average_deal_value
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY average_deal_value DESC;




-- Product Performance
-- Number of Opportunities by Product
SELECT product, COUNT(*) number_of_opportunities
FROM sales_pipeline
GROUP BY product
ORDER BY number_of_opportunities DESC;

-- Total Revenue by Product
SELECT product, SUM(close_value) Total_Revenue
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY product
ORDER BY Total_Revenue DESC;

-- Win Rate by Product
SELECT product, SUM(IF(deal_stage = "Won", 1, 0))/ COUNT(*) Win_Rate
FROM sales_pipeline
GROUP BY product
ORDER BY Win_Rate DESC;

-- Average deal by Product 
SELECT product, ROUND(AVG(close_value), 2) average_deal_value
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY product
ORDER BY average_deal_value DESC;

SELECT product, close_value
FROM sales_pipeline
WHERE product = 'GTK 500';


-- Customer/Account Analysis
-- Sales by Sector (number of sales and total revenue)
SELECT ac.sector, COUNT(*) number_of_opportunities,
	SUM(IF(sp.deal_stage = 'Won', 1, 0)) AS won_deals,
    ROUND(SUM(IF(sp.deal_stage = 'Won', sp.close_value, 0)), 2) AS total_sales
FROM sales_pipeline sp
JOIN accounts ac
    ON sp.account = ac.account
GROUP BY ac.sector
ORDER BY total_sales DESC;

SELECT *
FROM sales_teams;
-- Sales by region
SELECT st.regional_office, SUM(sp.close_value) total_sales
FROM sales_pipeline sp
JOIN sales_teams st
	ON sp.sales_agent = st.sales_agent
WHERE deal_stage = "Won"
GROUP BY st.regional_office
ORDER BY total_sales DESC;

-- Top ten accounts with biggest deals
SELECT account, product, sales_agent, close_value
FROM sales_pipeline
WHERE deal_stage = "Won"
ORDER BY close_value DESC
LIMIT 10;

-- Average deal size by sector
SELECT sector, ROUND(AVG(close_value),2) average_deal_size
FROM sales_pipeline sp
JOIN accounts ac
	ON sp.account = ac.account
WHERE sp.deal_stage = "Won"
GROUP BY sector
ORDER BY average_deal_size DESC;


-- Time/Trend Analysis
SELECT *
FROM sales_pipeline;

-- 	Total of opportunities successfully closed each month
SELECT DATE_FORMAT(close_date, '%Y-%m') AS month, SUM(close_value) Total_Sales
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month ASC;

-- Oportunities Engaged Over Time
SELECT DATE_FORMAT(engage_date, '%Y-%m') AS month, COUNT(*)
FROM sales_pipeline
GROUP BY DATE_FORMAT(engage_date, '%Y-%m')
ORDER BY month ASC;

-- Oportunities Closed Over Time
SELECT DATE_FORMAT(close_date, '%Y-%m') AS month, COUNT(*)
FROM sales_pipeline
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month ASC;

-- Win Rate Over Time
SELECT DATE_FORMAT(close_date, '%Y-%m') AS month, SUM(IF(deal_stage = "Won", 1, 0)) / COUNT(*) Win_Rate
FROM sales_pipeline
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month ASC;


-- Average Deal Value That Was Won Over Time
SELECT DATE_FORMAT(close_date, '%Y-%m') AS month, ROUND(AVG(close_value), 2) average_deal_value
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month ASC;

-- Average sales cycles by agent
SELECT sales_agent, ROUND(AVG(DATEDIFF(close_date, engage_date)), 2) avg_sales_cycle_days
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY sales_agent
ORDER BY avg_sales_cycle_days ASC;

-- Top accounts by sales
SELECT account, COUNT(*) Won_Deals,
ROUND(SUM(close_value), 2) total_sales
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY account
ORDER BY total_sales DESC;
