# SQL Queries (Slide 13)

SELECT *
FROM products
LIMIT 100;

# Unique Category Names (Slide 14)

SELECT DISTINCT category_name 
FROM products
LIMIT 10;

# Unique Category Names NO NULLS (Slide 16)

SELECT DISTINCT category_name
FROM products
WHERE category_name is not null
LIMIT 10;

# Unique Category Names (order by) 

SELECT DISTINCT category_name
FROM products
WHERE category_name is not null
ORDER BY category_name DESC
LIMIT 10;


# WE DO EX (Questions from slide 21)

#1 Which items come in packs larger than 12?

	# EXPLORE PRODUCTS TABLE
	SELECT *
	FROM products
	LIMIT 5;

SELECT DISTINCT pack, item_description
FROM products
WHERE pack > 12
LIMIT 10;

	# ADD ORDER BY
	SELECT DISTINCT pack, item_description
	FROM products
	WHERE pack > 12
	ORDER BY pack DESC;

# 2 Which items have a case cost of less than $70?

	# EXPLORE PRODUCTS TABLE
	SELECT *
	FROM products
	LIMIT 5;

SELECT case_cost, item_description
FROM products
WHERE case_cost < 70;

	# ORDER BY CASE_COST AND TAKE OUT 0
	SELECT case_cost, item_description
	FROM products
	WHERE case_cost < 70 and case_cost != 0
	ORDER BY case_cost;

# 3 Which items come in packs larger than 12 AND have a case_cost of less than $70?

SELECT pack, item_description, case_cost
FROM products
WHERE pack > 12 and case_cost <70;

# 4 Which categories have a proof of 85 or more?

# WRONG QUERY!!!!
SELECT DISTINCT proof, category_name
FROM products
WHERE proof > 85;

	# EXPLORE TABLE
	SELECT *
	FROM products
	LIMIT 5;

# CORRECT QUERY!!!!
SELECT DISTINCT category_name, cast(proof as integer)
FROM products
WHERE cast(proof as integer) >= 85 and category_name is not null;

# 5 Which items are in a whiskey (or whiskies) category or are over 85 proof?

	# EXPLORE DATA
	SELECT DISTINCT category_name
	FROM products
	ORDER BY category_name;

SELECT DISTINCT item_description, category_name, cast(proof as numeric)
FROM products
WHERE cast(proof as numeric) > 85 AND category_name like '%WHISK%';




# YOU DO EX (Questions from Slide 26)

#1 Which items are over 90 proof?
SELECT DISTINCT item_description, category_name
FROM products
WHERE cast(proof as integer) > 90
ORDER BY 1;

#2 Which items have a case cost of less than $60?
SELECT item_description, case_cost
FROM products
WHERE case_cost < 60
ORDER BY 2 DESC;

#3 Which items are in either Single Malt Scotches or Canadian Whiskies categories?
SELECT DISTINCT item_description, category_name
FROM products
WHERE category_name = 'SINGLE MALT SCOTCHES' or category_name = 'CANADIAN WHISKIES';

#alternative method
SELECT DISTINCT item_description, category_name
FROM products
WHERE category_name like '%SINGLE%' or category_name like '%CANADIAN%';


#4 Which items are in the whiskey (or whiskies) category?
SELECT DISTINCT item_description, category_name
FROM products
WHERE category_name like '%WHISK%';

# 5 What is the most expensive purchase of Svedka?

	# EXPLORE SALES TABLE
	SELECT *
	FROM SALES
	limit 5;

# QUERY
SELECT description, total
FROM sales
WHERE description like '%Svedka%'
ORDER BY total DESC
LIMIT 1;

# RENAME COLUMN NAMES (Slide 30)
SELECT description as PriceySvedka, total as TotalSales
FROM sales
WHERE description like '%Svedka%'
ORDER BY total DESC
LIMIT 1;

# Which distinct items in whiskey category have a proof over or equal to 70? 
# Rename item_description to product. (Slide 30-31)

SELECT DISTINCT item_description as product, category_name, cast(proof as integer)
FROM products
WHERE cast(proof as integer) >= 70 and category_name like '%WHISK%'



# How we usually explore the tables. Notice the # of rows on the bottom left corner of our screen.
# There's another way to find # of rows, particularly for larger tables like the sales table.

SELECT *
FROM PRODUCTS;

# COUNT (Slide 34)

SELECT COUNT(*)
FROM PRODUCTS;

SELECT count(*)
FROM sales;

# How would I find out how many products are available per vendor name? (Slide 36)
SELECT vendor_name, COUNT(*)
FROM products
GROUP BY vendor_name;

#alternative method
SELECT vendor_name, COUNT(item_description) 
FROM products
GROUP BY 1
ORDER BY 1;

# Let's work together to get the average proof of item_description D'aristi Xtabentun. (Sliide 38-40)

SELECT item_description, avg(cast(proof as numeric))
FROM products
WHERE item_description = 'D''aristi Xtabentun'
GROUP BY 1;

# HAVING CLAUSE (Slide 41-44)

#WRONG QUERY!!!!
SELECT category_name, avg(cast(proof as numeric))
FROM products
WHERE AVG(CAST(proof as numeric)) > 75
GROUP BY category_name;

#CORRECT QUERY!!!!
SELECT category_name, avg(cast(proof as numeric))
FROM products
GROUP BY 1
HAVING avg(cast(proof as numeric)) > 75;


# YOU DO INDEPENDENT PRACTICE (Questions from slide 46)


# 1 How many items does each category have? 
SELECT category_name, COUNT(item_no) 
FROM products 
WHERE category_name is not null 
GROUP BY category_name;

# 2 Which categories have more than 100 items? 
SELECT category_name, COUNT(item_no) 
FROM products 
WHERE category_name is not null 
GROUP BY category_name 
HAVING COUNT(item_no) > 100;


# 3 What is the average bottle size per category of whiskey?
SELECT category_name, avg(bottle_size)
FROM products
WHERE category_name like '%WHISK%'
GROUP BY 1;


# 4 What is the average state_btl_cost per vendor? Only want avg(state_btl_cost) over 10.
SELECT vendor, avg(cast(state_btl_cost as numeric))
FROM sales
GROUP BY 1
HAVING avg(cast(state_btl_cost as numeric)) > 10
ORDER BY 2;


# MATH OPS
# PER BOTTLE PRICE FOR EACH ITEM (Slide 51)

SELECT description, total / bottle_qty as PerBtlPrice
FROM sales
LIMIT 100;

# Add a column named “DIFF” to the products table that calculates the difference between shelf price
# and bottle price for each product. (Slide 53)

SELECT *, (shelf_price - (cast(bottle_price as numeric))) as diff
FROM products;


# CASE STATEMENTS (Slides 59 - 60)

SELECT county, population,
	CASE 
		WHEN population >= 200000 THEN 'large'
		WHEN population >= 40000 THEN 'medium'
		ELSE 'small'
	END AS PopulationSize
FROM counties
ORDER BY population;

# SUBQUERIES (Slides 64 - 65)

SELECT PopulationSize, count(county)
FROM (
	SELECT county, population,
		CASE 
			WHEN population >= 200000 THEN 'large'
			WHEN population >= 40000 THEN 'medium'
			ELSE 'small'
		END AS PopulationSize
	FROM counties
	) as temp
GROUP BY 1;


# JOINS, TOP 5 STORE SALES WITH STORE NAME (Slides 72 - 73)

# EXPLORE THE TABLES FIRST!

SELECT * 
FROM SALES
LIMIT 5;

SELECT *
FROM STORES
LIMIT 5;

# JOIN QUERY

SELECT stores.name, sum(sales.total)
FROM sales
	LEFT JOIN stores
	ON sales.store = stores.store
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;