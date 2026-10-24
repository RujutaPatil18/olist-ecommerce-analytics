# Olist E-Commerce Analytics Dashboard

## Project Overview
This project analyzes Brazilian e-commerce marketplace data to understand sales performance, product category revenue, customer satisfaction, and delivery efficiency. The analysis uses SQL for data exploration and Power BI to build an interactive dashboard for business decision-making.

## Business Objectives
- Analyze total revenue and order volume.
- Track monthly sales trends.
- Identify top-performing product categories.
- Evaluate customer review ratings.
- Measure on-time and late delivery performance.
- Monitor order status distribution.

## Tools & Technologies
- **MySQL:** Data querying, aggregation, and business analysis.
- **Power BI Desktop:** Interactive dashboard and data visualization.
- **Power Query:** Data transformation and date preparation.
- **DAX:** KPI and calculated-column creation.
- **Python:** Data import and database-loading support.

## Key Performance Indicators (KPIs)

| KPI | Result |
|---|---:|
| Total Product Revenue | R$13.59 million |
| Orders with Items | 98,666 |
| Total Order Items | 112,650 |
| Average Order Value | R$137.75 |
| On-Time or Early Delivery Rate | 91.89% |
| Late Delivery Rate | 8.11% |
| Positive Review Rate (4–5 stars) | 77.07% |

*Revenue represents product prices and excludes freight charges. Delivery rates are calculated using orders with recorded delivery dates.*

## Key Business Insights

### 1. Revenue Performance
Total product revenue was approximately R$13.59 million. Monthly revenue analysis helps identify periods of higher and lower sales activity.

### 2. Top Product Categories
Health & Beauty was the highest-revenue category at approximately R$1.26 million, followed by Watches & Gifts at R$1.21 million and Bed Bath Table at R$1.04 million.

### 3. Delivery Performance
Approximately 91.89% of orders with recorded delivery dates arrived on time or early, while 8.11% arrived late.

### 4. Customer Satisfaction
Approximately 77.07% of recorded reviews were 4 or 5 stars. The 1-star review share was 11.51%, indicating an opportunity to investigate negative customer experiences.

### 5. Average Order Value
The average product revenue per order containing items was R$137.75. This metric can help track changes in customer purchasing value over time.

## Business Recommendations
- Investigate late deliveries by seller, location, and product category.
- Analyze low-rated reviews to identify recurring customer complaints.
- Monitor inventory and seller performance in high-revenue categories.
- Test bundles and complementary product recommendations to increase order value.
- Track monthly revenue and order volume to support business planning.

## Dashboard Features
The Power BI dashboard includes:
- KPI cards for revenue, orders, average order value, and delivery performance.
- Monthly revenue trend.
- Top five product categories by revenue.
- Customer review ratings.
- Delivery performance breakdown.
- Order status breakdown.
- Month and year slicers for interactive filtering.

## Data Source
The project uses the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle. The dataset contains marketplace order, customer, product, seller, and review information.

## Conclusion
This project demonstrates practical skills in SQL-based data analysis, data preparation, KPI development, and interactive business intelligence reporting. It translates raw e-commerce data into actionable findings related to sales, customer satisfaction, and delivery performance.
