/*

-----------------------------------------------------------------------------------------------------------------------------------
													    Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			

-----------------------------------------------------------------------------------------------------------------------------------
                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  USE new_wheels
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/

SELECT state, COUNT(customer_id) AS customer_count
FROM customer_t
GROUP BY state
ORDER BY customer_count DESC;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 

WITH ratings_cte AS (
    SELECT
        CASE 
            WHEN customer_feedback = 'Very Bad' THEN 1
            WHEN customer_feedback = 'Bad' THEN 2
            WHEN customer_feedback = 'Okay' THEN 3
            WHEN customer_feedback = 'Good' THEN 4
            WHEN customer_feedback = 'Very Good' THEN 5
        END AS numerical_rating,
        quarter_number
    FROM order_t
)
SELECT
    quarter_number,
    AVG(numerical_rating) AS average_rating
FROM ratings_cte
GROUP BY quarter_number
ORDER BY quarter_number;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
-- Step 1: Use a Common Table Expression (CTE) to count the number of each type of feedback per quarter
WITH feedback_counts AS (
    SELECT
        quarter_number,
        customer_feedback,
        COUNT(*) AS feedback_count
    FROM order_t
    GROUP BY quarter_number, customer_feedback
), 

-- Step 2: Calculate the total number of feedback entries per quarter
total_feedbacks AS (
    SELECT
        quarter_number,
        COUNT(*) AS total_feedback_count
    FROM order_t
    GROUP BY quarter_number
)

-- Step 3: Calculate the percentage of each type of feedback per quarter
SELECT
    fc.quarter_number,
    fc.customer_feedback,
    (fc.feedback_count * 100.0 / tf.total_feedback_count) AS feedback_percentage
FROM feedback_counts fc
JOIN total_feedbacks tf
  ON fc.quarter_number = tf.quarter_number
ORDER BY fc.quarter_number, fc.customer_feedback;

/* Based on the provided data, customers appear to be becoming more dissatisfied over time.
 The percentage of negative feedback (Very Bad and Bad) increases steadily from Quarter 1 to Quarter 4, 
 while the percentage of positive feedback (Very Good and Good) decreases. This trend indicates a growing dissatisfaction among customers as time progresses.
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/

SELECT vehicle_maker, COUNT(DISTINCT customer_id) AS customer_count
FROM order_t
JOIN product_t ON order_t.product_id = product_t.product_id
GROUP BY vehicle_maker
ORDER BY customer_count DESC
LIMIT 5;

/* Chevrolet: 83 customers
Ford: 63 customers
Toyota: 52 customers
Dodge: 50 customers
Pontiac: 50 customers
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

WITH ranked_vehicle_makers AS (
    SELECT
        c.state,
        p.vehicle_maker,
        COUNT(DISTINCT o.customer_id) AS customer_count,
        RANK() OVER (PARTITION BY c.state ORDER BY COUNT(DISTINCT o.customer_id) DESC) AS ranking
    FROM order_t o
    JOIN product_t p ON o.product_id = p.product_id
    JOIN customer_t c ON o.customer_id = c.customer_id
    GROUP BY c.state, p.vehicle_maker
)
SELECT
    state,
    vehicle_maker,
    customer_count
FROM ranked_vehicle_makers
WHERE ranking = 1;

-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/

SELECT
    quarter_number,
    COUNT(order_id) AS order_count
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
*/
      
  WITH quarterly_revenue AS (
    SELECT
        quarter_number,
        SUM(quantity * vehicle_price) AS total_revenue
    FROM order_t
    GROUP BY quarter_number
)
SELECT
    quarter_number,
    total_revenue,
    previous_revenue,
    ((total_revenue - previous_revenue) / previous_revenue) * 100 AS qoq_percentage_change
FROM (
    SELECT
        quarter_number,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY quarter_number) AS previous_revenue
    FROM quarterly_revenue
) AS revenue_change
WHERE previous_revenue IS NOT NULL;
    

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/

SELECT
    quarter_number,
    SUM(quantity * vehicle_price) AS total_revenue,
    COUNT(order_id) AS order_count
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/

SELECT
    c.credit_card_type,
    AVG(o.discount) AS average_discount
FROM order_t o
JOIN customer_t c ON o.customer_id = c.customer_id
GROUP BY c.credit_card_type
ORDER BY c.credit_card_type;




-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
	Hint: Use the dateiff function to find the difference between the ship date and the order date.
*/

SELECT
    quarter_number,
    AVG(DATEDIFF(ship_date, order_date)) AS average_shipping_time
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



