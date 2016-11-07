# WE DO!

#1 Which products come in packs larger than 12?
select distinct item_description from products where pack > 12;
# what about nulls?
select distinct item_description from products where pack > 12 and item_description is not null;

#2 Which items have a case cost of less than $70?
select distinct item_description from products where case_cost < 70;
# okay but I want case_cost too
select distinct item_description, case_cost from products where case_cost < 70;
# great, can i order this by case_cost? (desc, asc)
select distinct item_description, case_cost from products where case_cost < 70 order by case_cost;
# i want to take out those that are 0
select distinct item_description, case_cost from products where case_cost < 70 and case_cost != 0 order by case_cost;

#3 Which items come in packs larger than 12 AND have a case_cost of less than $70?
select distinct item_description from products where case_cost < 70 and pack > 12;
# okay, let's add pack and case_cost to the query 
select distinct item_description from products where case_cost < 70 and pack > 12;


#4 Which categories have a proof of 85 or more?
select distinct category_name from products where proof > 85;
# woah what's going on here? let's trouble shoot by doing the following
select * from products limit 10
#proof is considered text, not integer. agh! time to convert this bad boy to an integer or numeric.
select distinct category_name from products where cast(proof as integer) > 85;
#awesome, let's take out the nulls and add proof to select statement
select distinct category_name, proof from products where cast(proof as integer) > 85 and cast(proof as integer) is not null;

#5 Which items have a category name of scotch whiskies OR are over 85 proof?
select distinct item_description, category_name from products where cast(proof as integer) > 65 OR category_name = 'SCOTCH WHISKIES';
#what if we wanted category name of any kind of whiskey?
select distinct item_description, category_name from products where cast(proof as integer) > 65 OR category_name like '%WHISK%';

#######

# YOU DO
#1 Which items are over 90 proof? 
select distinct item_description from products where cast(proof as integer) > 90;

#2 Which items have a case cost of less than $60?
select distinct item_description, case_cost from products where case_cost < 60;

#3 Which items are either Single Malt Scotches or Canadian Whiskies?
select distinct item_description, category_name from products where category_name = 'SINGLE MALT SCOTCH' OR category_name = 'CANADIAN WHISKIES';

#4 Which items are in the whiskey (or whiskies) category?
select distinct item_description, category_name from products where category_name like '%WHISK%';

#5
select distinct description, total from sales where description like '%Svedka%' order by total desc limit 1;
# rename attributes!
select distinct description as alcohol, total from sales where description like '%Svedka%' order by total desc;

#####

# Example
select * from sales limit 10
select description as VodkaProduct, total as sales from sales where description like '%Vodka%' limit 10;

# Which distinct whiskey products have a proof over or equal to 70? Rename item_description to product.
select distinct item_description as product, cast(proof as integer) from products where cast(proof as integer) >= 70 and category_name like '%WHISK%';

#####

# Complex Conditions in WHERE Clause

# Let's get average proof of item_description D'aristi Xtabentun
select item_description, avg(cast(proof as numeric)) from products where item_description = 'D''aristi Xtabentun' group by item_description;


##### YOU DO

#1 How many items does each category have?
select category_name, count(item_no) from products where category_name is not null group by category_name;

#2 Which categories have more than 100 items? Remove nulls.
select category_name, count(item_no) from products where category_name is not null group by category_name having count(item_no) > 100;

#3 What is the average bottle size per category of whiskey?
select category_name, avg(bottle_size) from products where category_name like '%WHISK%' group by category_name;

#4 What is the average bottle size per vendor of whiskey?
select vendor_name, avg(bottle_size) from products where category_name like '%WHISK%' group by vendor_name;
select vendor_name, avg(bottle_size) from products where item_description like '%Whisk%' group by vendor_name;

#5 What is the average state_btl_cost per vendor? 
select vendor, avg(cast(state_btl_cost as numeric)) from sales where vendor is not null group by vendor having avg(cast(state_btl_cost as numeric)) > 10


#### YOU DO MATHEMATICAL OPERATIONS

#1 Which products have null cast_costs?
select category_name, item_description, vendor_name from products where case_cost is null;

#2 Calculate the difference between shelf price and bottle price for each product
select *, (shelf_price - (cast(bottle_price as numeric))) as diff from products;

#3 Which 5 products cost the most per mL (bottle_size)?
select vendor_name, item_description, category_name, bottle_price / bottle_size as price_per_ml from products where bottle_price is not null and bottle_size is not null and bottle_size != 0 order by price_per_ml desc limit 5;

#4 What are the top 20 most marked up products based on the difference? Do not include nulls in your answer and make sure to only return 5 rows.
select *, (shelf_price - (cast(bottle_price as numeric))) as diff from products where case_cost is not null order by diff desc limit 20;

#### CASE

SELECT county, population,
	CASE
		WHEN population >= 200000 THEN 'large'
		WHEN population >= 40000  THEN 'medium'
		ELSE 'small'
	END AS county_size
FROM counties;

##### SUBQUERY

SELECT county_size, count(*) as NumberOfCounties
FROM (
SELECT county, population,
		CASE
			WHEN population >= 200000 THEN 'large'
			WHEN population >= 40000  THEN 'medium'
			ELSE 'small'
		END AS county_size
	FROM counties
) AS temp
GROUP BY county_size;

