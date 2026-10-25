# Advanced SQL Analysis

This folder contains advanced SQL queries developed for the E-Commerce Sales Analysis project.

## Analysis Files

### 1. Monthly Sales Growth
**File:** `advanced_monthly_sales_growth.sql`

- Calculates monthly sales for delivered orders.
- Uses a CTE and the `LAG()` window function.
- Calculates month-over-month sales growth.

### 2. Top Product Categories
**File:** `advanced_top_product_categories.sql`

- Calculates revenue by product category.
- Uses joins, aggregation, CTEs, and `DENSE_RANK()`.
- Identifies the five highest-revenue categories.

### 3. Repeat Customer Analysis
**File:** `advanced_repeat_customer_analysis.sql`

- Counts customers with more than one delivered order.
- Calculates the repeat-customer percentage.
- Uses a CTE and conditional aggregation.


### 4. Top Seller Analysis

**File:** `advanced_top_seller_analysis.sql`

- Calculates revenue and unique delivered orders for each seller.
- Uses aggregation and `DENSE_RANK()` to rank sellers.
- Identifies the top 10 sellers by product revenue.
