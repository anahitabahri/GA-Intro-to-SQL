# Which items are not from vendor ‘Jim Beam Brands’?
SELECT item_description, vendor_name
FROM products
WHERE vendor_name != 'Jim Beam Brands';


# Which items are over 90 proof?

SELECT item_description, cast(proof as numeric)
FROM products
WHERE cast(proof as numeric) > 90
ORDER BY 2 asc;


# Which items aren’t in a Whiskey category?

SELECT item_description, category_name
FROM products
WHERE category_name not like '%WHISK%'

# Which items have a shelf_price of between $4 and $10?

SELECT item_description, shelf_price
FROM products
WHERE shelf_price between 4 AND 10;

# Which items have a case cost of more than $100?

SELECT item_description, case_cost
FROM products
WHERE case_cost > 100;

# Which tequilas have a case cost of more than $100?

SELECT item_description, category_name, case_cost
FROM products
WHERE case_cost > 100 and category_name LIKE '%TEQUILA%';

# Which tequilas or scotch whiskies have a case cost of more than $100?
SELECT item_description, category_name, case_cost
FROM products 
WHERE case_cost > 100 and category_name = 'TEQUILA' or category_name = 'SCOTCH WHISKIES';


# Which tequilas or scotch whiskies have a cast cost between $100 and $120?
SELECT item_description, category_name, case_cost
FROM products 
WHERE case_cost between 100 and 120 and category_name = 'TEQUILA' or category_name = 'SCOTCH WHISKIES'
order by case_cost;

# Which whiskies of any kind cost more than $100?

SELECT item_description, category_name, case_cost
FROM products
WHERE case_cost > 100 and category_name like '%WHISK%';

# Which whiskies of any kind cost between $100 and $150?

SELECT item_description, category_name, case_cost
FROM products
WHERE case_cost between 100 and 150 and category_name like '%WHISK%';


# Which items except tequilas cost between $100 and $120?

SELECT item_description, category_name, case_cost
FROM products
WHERE case_cost between 100 and 120 and category_name != 'TEQUILA';



# INTERMEDIATE QUESTIONS





# ADVANCED QUESTIONS


