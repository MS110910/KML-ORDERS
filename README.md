# KMS-ORDERS
Kultra Mega Stores (KMS), headquartered in Lagos, specialises in offi ce supplies andfurniture. Its customer base includes individual consumers, small businesses (retail), and large corporate clients (wholesale) across Lagos, Nigeria.
You have been engaged as a Business Intelligence Analyst to support the Abuja division of KMS. The Business Manager has shared an Excel fi le containing order data from 2009 to 2012 and has requested that you analyze the data and present your key insights and fi ndings.
### Case Scenario I
### 1. Which product category had the highest sales?
* **SQL Query:**
```sql
SELECT product_category,
SUM(sales) AS Total_Sales
FROM orderstore
GROUP BY product_category
ORDER BY Total_Sales DESC
LIMIT 1;
```
* **Result:**
```text
Product_Category | Total_Sales
-----------------+-------------
Technology       | 5984248.18
```
* **Insight:**
This shows that **"Technology"** is the leading product category in terms of sales, generating a significant total revenue of **₦5,984,248.18** (assuming Nigerian Naira currency). This indicates a strong market demand for technology products within Kultra Mega Stores' operations during the 2009-2012 period. Management should consider leveraging this strength, perhaps through targeted promotions or expanding product lines within this category.

### 2. What are the Top 3 and Bottom 3 regions in terms of sales?
* **SQL Query (Top 3 Regions):**
```sql
SELECT region, 
SUM(Sales) AS Total_Sales
FROM orderstore
GROUP BY region
ORDER BY Total_Sales DESC
LIMIT 3;
```

* **Result (Top 3 Regions):**
```text
region        | Total_Sales
--------------+--------------
West          | 3597549.2755
Ontario       | 3063212.4795
Prarie        | 2837304.6015
```

* **SQL Query (Bottom 3 Regions):**
```sql
SELECT region, 
SUM(Sales) AS Total_Sales
FROM orderstore
GROUP BY region
ORDER BY Total_Sales ASC
LIMIT 3;
```
* **Result (Bottom 3 Regions):**
```text
region                 | Total_Sales
-----------------------+--------------
Nunavut                | 116376.4835
Northwest Territories  | 800847.3295
Yukon                  | 975867.3710
```

* **Insight**
These regions highlights significant disparities in revenue generation across different geographical areas. The **"West," "Ontario," and "Prarie"** regions are clearly the top performers, contributing the most to overall sales. This suggests strong market presence and customer base in these areas.
Conversely, **"Nunavut," "Northwest Territories," and "Yukon"** are the least regions in terms of sales. Their lower sales figures indicate either a weaker market penetration, lower population density, or specific logistical/economic challenges. 
  
### 3. What were the total sales of appliances in Ontario?
* **SQL Query:**
```sql
SELECT SUM(Sales) AS
Total_appliances_sold_in_Ontario
FROM orderstore
WHERE Product_Sub_Category = 'Appliances' AND Province = 'Ontario';
```
* **Result:**
```text
Total_appliances_sold_in_Ontario
--------------------------------
                       202346.84
```

* **Insight**
The total sales of **Appliances** specifically within the **Ontario** province amount to **₦202,346.84**. This provides a granular view of category performance in a particular region. While "Technology" is the overall highest-selling category, this figure allows KMS management to assess regional demand for specific product types and potentially tailor marketing or inventory strategies for Appliances in Ontario.

### 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers.
* **SQL Query (to identify customers):**
```sql
SELECT Customer_Name,
SUM(Sales) AS Min_Total_Sales
FROM orderstore
GROUP BY Customer_Name
ORDER BY Min_Total_Sales ASC
LIMIT 10;
```
* **Result (Bottom 10 Customer List):**
```text
Customer_Name     |Min_Total_Sales
------------------+----------------
Jeremy Farry      | 85.72
Natalie DeCherney | 125.90
Nicole Fjeld      | 153.03
Katrina Edelman   | 180.76
Dorothy Dickinson | 198.08
Christine Kargatis| 293.22
Eric Murdock      | 343.328
Chris McAfee      | 350.18
Rick Huthwaite    | 415.82
Mark Hamilton     | 450.99
```

* **Advice to Management:**
To increase revenue from customers like Jeremy Farry, Natalie DeCherney, and others on this list, KMS should consider a targeted approach focusing on engagement and value proposition:
a.  **Personalized  Campaigns:**
    Send personalized emails or SMS messages, offer small, exclusive discounts (e.g., 5-10% off their next purchase), a special bundle tailored to their past (minimal)          purchases with a limited-time validity.

b.  **Targeted Product Recommendations:**
    Analyze the types of products these customers buy (including small purchases). Recommend complementary products, new arrivals in categories they previously showed           interest in, or essential supplies that are frequently repurchased.

c.  **Feedback (Surveys):**
    Reach out to a sample of these customers with a short, incentivized survey (e.g., "Complete this 2-minute survey and get a small discount on your next order").              Understand *why* their spending is low. Is it pricing? Product availability? Customer service experience? Lack of awareness of the full product range? 
    
d.  **Introduce Loyalty Programs:**
    Clearly communicate the benefits of  being a regular customer (e.g., free shipping thresholds, exclusive early access to sales). Provide an incentive for repeat             purchases and increased spending.

### 5.KMS incurred the most shipping cost using which shipping method?
* **SQL Query:**
```sql
SELECT Ship_Mode, 
SUM(Shipping_Cost) AS Most_Shipping_Cost
FROM orderstore
GROUP BY Ship_Mode
ORDER BY Most_Shipping_Cost DESC 
LIMIT 1;
```
* **Result:**
```text
Ship_Mode       | Most_Shipping_Cost
----------------+-------------------
Delivery Truck  | 51971.94
```

* **Insight:**
The **"Delivery Truck"** is the shipping method with the highest total incurred cost for KMS, amounting to **₦51,971.94** considering operational efficiency and profitability. While delivery trucks might be preferred for certain types of goods or routes, management should further investigate if this cost is high as to other ship mode. Also, fuel efficiency, route optimization, maintenance, or labor costs associated with truck deliveries are potential areas for cost reduction if cost is too high.

### Case Scenario II

###  6. Who are the most valuable customers, and what products or services do they typically purchase?
* **SQL Query (Most Valuable Customers by Sales):**
```sql
SELECT Customer_Name, 
SUM(Sales) AS Customer_Total_Sales
FROM orderstore
GROUP BY Customer_Name
ORDER BY Customer_Total_Sales DESC
LIMIT 5;
```
* **Result (Top 5 Most Valuable Customers):**
```text
Customer_Name       | Customer_Total_Sales
--------------------+---------------------
Emily Phan          | 117124.438
Deborah Brumfield   | 97433.1355
Roy Skaria          | 92542.1530
Sylvia Foulston     | 88875.7575
Grant Carroll       | 88417.0025
```

* **SQL Query (Typical Purchases for Top Customers):**
```sql
SELECT Customer_Name, product_category,
SUM(Sales) AS Customer_Total_Category_Sales,
COUNT(*) AS No_of_Orders_in_the_Category
FROM orderstore
WHERE Customer_Name IN ('Emily Phan', 'Deborah Brumfield', 'Roy Skaria', 'Sylvia Foulston', 'Grant Carroll')
GROUP BY Customer_Name, product_category
ORDER BY Customer_Name, Customer_Total_Category_Sales DESC;
```
* **Result (Typical Purchases Breakdown):**
```text
Customer_Name       | Product_Category  | Customer_Total_Category_Sales | No_of_Orders_in_the_Category
--------------------+-------------------+-------------------------------+------------------------------
Deborah Brumfield   | Technology        | 76795.7955                    | 8
Deborah Brumfield   | Furniture         | 12809.62                      | 4
Deborah Brumfield   | Office Supplies   | 7827.72                       | 8
Emily Phan          | Technology        | 110481.968                    | 4
Emily Phan          | Furniture         | 4011.65                       | 1
Emily Phan          | Office Supplies   | 2630.82                       | 5
Grant Carroll       | Office Supplies   | 50837.27                      | 15
Grant Carroll       | Furniture         | 29826.85                      | 5
Grant Carroll       | Technology        | 7752.8825                     | 7
Roy Skaria          | Furniture         | 50177.24                      | 8
Roy Skaria          | Technology        | 30349.3930                    | 6
Roy Skaria          | Office Supplies   | 12015.52                      | 12
Sylvia Foulston     | Furniture         | 48173.380                     | 10
Sylvia Foulston     | Technology        | 29669.0375                    | 5
Sylvia Foulston     | Office Supplies   | 11033.34                      | 9
```

* **Insight**
The most valuable customers for Kultra Mega Stores are **Emily Phan**, **Deborah Brumfield**, **Roy Skaria**, **Sylvia Foulston**, and **Grant Carroll**, based on their significant total sales contributions.
Their purchasing patterns show distinct preferences:
* **Technology Dominance:** Emily Phan and Deborah Brumfield heavily purchase **Technology** products, accounting for a large portion of their overall spending.
* **Furniture & Office Supplies:** Grant Carroll shows a strong preference for **Office Supplies** and **Furniture**. Roy Skaria and Sylvia Foulston also make substantial purchases in **Furniture** and **Technology**, with Office Supplies being their third preference.

**Recommendations for Management:**
* **Tailored Offers:** For customers like Emily Phan and Deborah Brumfield, KMS should continue to push new technology products, accessories, and upgrades.
* **Cross-selling Opportunities:** For customers like Grant Carroll, Roy Skaria, and Sylvia Foulston, consider cross-selling strategies, perhaps bundling office supplies with furniture, or offering discounts on technology upgrades when they purchase large furniture items.
* **Personalized Communication:** Understand the specific needs of these high-value customers and tailor communication and product showcases to their demonstrated preferences.

### 7. Which small business customer had the highest sales?
* **SQL Query:**
```sql
SELECT Customer_Name, 
SUM(Sales) AS Customer_Total_Sales
FROM orderstore
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Customer_Total_Sales DESC
LIMIT 1;
```

* **Result:**
```text
Customer_Name | Customer_Total_Sales
--------------+---------------------
Dennis Kane   | 75967.5905
```

* **Insight**
**Dennis Kane** is identified as the small business customer with the highest sales, contributing **₦75,967.59** to KMS revenue. This customer is a key asset within the small business segment. Management could consider reaching out to Dennis Kane directly to understand their needs better, offer personalized bulk discounts, or explore opportunities for upselling/cross-selling to further solidify this valuable relationship and potentially use them as a case study for attracting similar high-value small business clients.

### 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?
* **SQL Query:**
```sql
SELECT Customer_Name,
COUNT(order_id) AS Total_Orders_Placed
FROM orderstore
WHERE Customer_Segment = 'Corporate' AND order_date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name 
ORDER BY Total_Orders_Placed DESC
LIMIT 1;
```

* **Result:**
```text
Customer_Name | Total_Orders_Placed
--------------+--------------------
Adam Hart     | 27
```

* **Insight**
**Adam Hart** is identified as the Corporate Customer who placed the highest number of orders (27) between 2009 and 2012. This indicates Adam Hart is a highly engaged and consistent corporate client for KMS. Management should recognize this customer as a key relationship and explore opportunities for deepened engagement, perhaps through dedicated account management, exclusive previews of new corporate solutions, or loyalty incentives to maintain their high order frequency.

### 9. Which consumer customer was the most profitable one?
* **SQL Query:**
```sql
SELECT Customer_Name,
SUM(profit) AS Customer_Total_Profit
FROM orderstore
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Customer_Total_Profit DESC
LIMIT 1;
```

* **Result:**
```text
Customer_Name | Customer_Total_Profit
--------------+----------------------
Emily Phan    | 34005.44
```

* **Insight**
**Emily Phan** emerges as the most profitable consumer customer for KMS, generating a total profit of **₦34,005.44**. It's note worthy that Emily Phan also appeared as one of the overall most valuable customers by sales, reinforcing her importance to the business. This indicates a customer who not only purchases frequently but also tends to buy items with higher profit margins. KMS should prioritize retaining and nurturing this relationship, potentially through exclusive offers on high-margin products or personalized communication, to maximize long-term profitability.

### 10. Which customer returned items, and what segment do they belong to?
* **SQL Query:**
```sql
SELECT DISTINCT O.Customer_Name, O.Customer_Segment
FROM orderstore AS O
JOIN OrderStatus AS OS ON O.Order_id = OS.Order_id
WHERE OS.status = 'Returned';
```

* **Result:**
The query returned **419 unique customers** who have returned items. These customers belong to various segments including:
    * Home Office
    * Corporate
    * Small Business
    * Consumer

```text
Customer_Name   | Customer_Segment
----------------+-----------------
Edward Nazzal   | Home Office
Cindy Chapman   | Corporate
Henry Goldwyn   | Small Business
Julie Prescott  | Home Office
Liz Willingham  | Home Office
```

* **Insight**
A substantial number of customers, totaling **419 individuals/entities**, have returned items to KMS. These returns are not isolated to a single customer segment but are observed across **Home Office, Corporate, Small Business, and Consumer** segments. This indicates a widespread issue or characteristic behavior rather than a segment-specific problem.

**Recommendations for Management:**
* **Investigate Root Causes:** KMS should delve deeper into the reasons for these returns. Is it due to product quality issues, incorrect orders, late deliveries, product not meeting expectations, or complex return policies? for returned orders could provide more specific insights.
* **Segment-Specific Strategies:** While returns are broad, specific strategies might be needed per segment. For instance, Home Office clients might value clear product descriptions, while Corporate clients might need more accurate bulk order fulfillment.
* **Return Policy Review:** Evaluate the existing return policy to ensure it is clear, fair, and not inadvertently encouraging returns.
* **Feedback Loop:** Implement a system to capture feedback from customers during the return process to continuously improve products, services, and fulfillment.

### 11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? 
* **SQL Query for Analysis:**
```sql
SELECT Order_Priority, Ship_Mode,
SUM(Shipping_Cost) AS Total_Priority_Shipping_Cost,
COUNT(Order_id) AS No_of_Priority_Orders_by_Ship_Mode
FROM orderstore
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority ASC, Total_Priority_Shipping_Cost DESC;
```

* **Result:**
```text
Order_Priority | Ship_Mode      | Total_Priority_Shipping_Cost     | No_of_Priority_Orders_by_Ship_Mode
---------------+----------------+----------------------------------+-----------------------------------------
Critical       | Delivery Truck | 10783.82                         | 228
Critical       | Regular Air    | 8586.76                          | 1180
Critical       | Express Air    | 1742.10                          | 200
High           | Delivery Truck | 11206.88                         | 248
High           | Regular Air    | 10005.01                         | 1308
High           | Express Air    | 1453.53                          | 212
Low            | Delivery Truck | 11131.61                         | 250
Low            | Regular Air    | 10263.62                         | 1280
Low            | Express Air    | 1551.63                          | 190
Medium         | Delivery Truck | 9461.62                          | 205
Medium         | Regular Air    | 9418.72                          | 1225
Medium         | Express Air    | 1633.59                          | 201
Not Specified  | Regular Air    | 9734.08                          | 1277
Not Specified  | Delivery Truck | 9388.01                          | 215
Not Specified  | Express Air    | 1470.06                          | 180
```

* **Insight:**
It appears that **KMS is NOT optimally or appropriately spending shipping costs based on Order Priority**, particularly for high-priority orders.

**Key Observations:**
a.  **Mismatch for High and Critical Priorities:**
* For both "Critical" and "High" priority orders, the **Delivery Truck** (described as the slowest and most economical method) consistently incurs the *highest total shipping cost*. This is counter-intuitive for urgent orders, where speed should theoretically outweigh cost-per-shipment considerations.
* The fastest and most expensive method, **Express Air**, consistently has the *lowest total shipping cost* and the *lowest number of orders* across *all* priority levels, including "Critical" and "High". This strongly suggests it is being underutilized for urgent shipments, where its speed would be most beneficial, despite its higher individual cost.
b.  **Reliance on Regular Air:** "Regular Air" appears to be the workhorse for all priority levels, handling the vast majority of orders. While this might be a balanced approach for medium to low priorities, its heavy use for "Critical" and "High" orders (despite `Delivery Truck` having higher *total* cost) still implies that the fastest option (Express Air) is not being chosen when urgency is paramount.
c.  **Appropriate for Low/Medium/Not Specified:** For "Low," "Medium," and "Not Specified" priorities, the higher usage and total cost for "Delivery Truck" and "Regular Air" are more justifiable, as these orders are less time-sensitive, and cost efficiency would be a higher priority.

**Conclusion and Recommendations:**
The current spending pattern indicates a potential disconnect between stated order priority and the chosen shipping method. KMS might be sacrificing delivery speed for urgent orders to save on per-shipment costs, which could negatively impact customer satisfaction for critical deliveries.
Management should:
* **Review Shipping Policies:** Establish clearer guidelines for selecting shipping methods based on Order Priority, ensuring that "Critical" and "High" priority orders are consistently routed via faster (even if individually more expensive) options like "Express Air."
* * **Cost-Benefit Analysis for Urgency:** Conduct a detailed cost-benefit analysis comparing the increased shipping cost of "Express Air" for critical orders against the potential loss of customer satisfaction, repeat business, or contractual penalties due to slow delivery.
* **Optimize Delivery Truck Use:** While economical, if "Delivery Truck" has the highest *total* cost for urgent orders, it may indicate inefficiencies in routing, capacity utilization, or a need to shift some of these urgent orders to faster, albeit pricier, modes.

### Key Findings & Recommendations
This sales and order analysis for Kultra Mega Stores (KMS) from 2009 to 2012 provides critical insights into sales performance, customer behavior, and operational efficiency across various segments and regions.

### Key Findings
* **Technology**, the highest-selling product is a dominant product in category, indicating strong market demand and a core revenue driver for KMS. Sales are highly concentrated, with **"West," "Ontario," and "Prarie"** being the top-performing regions, while **"Nunavut," "Northwest Territories," and "Yukon"** significantly lag behind, highlighting uneven market penetration.
* **Emily Phan** stands out as both the **most valuable overall customer by sales** and the **most profitable consumer customer**, making her a crucial asset. Her primary purchases are in **Technology**.
* **Deborah Brumfield** (Technology), **Grant Carroll** (Office Supplies and Furniture), **Dennis Kane** (Small Business) and  **Adam Hart** (Corporate) are also valuable customers demonstrating consistent engagement.
A defined group of **bottom 10 customers** contributes minimally to revenue, suggesting potential for targeted re-engagement and customer retention.
A considerable number of customers (**419 unique customers**) across all segments (Consumer, Corporate, Small Business, Home Office) have returned items, indicating a potentially widespread issue in product satisfaction or fulfillment.
Despite "Delivery Truck" being the slowest and most economical, it incurs the highest *total* shipping costs for **"Critical" and "High" priority orders**. Conversely, "Express Air" (fastest, most expensive) is significantly underutilized for these urgent shipments. This suggests a disconnect between order priority and shipping method selection.

###  Recommendations
a.  **Capitalize on Strengths:**
* **Invest in Technology Segment:** Continue to prioritize inventory, marketing, and new product introductions within the Technology category, leveraging its high demand and profitability.
* **Deepen Engagement with Top Customers:** Implement personalized loyalty programs, exclusive offers, and dedicated account management for high-value customers like Emily Phan, Deborah Brumfield, Dennis Kane, and Adam Hart, tailored to their specific purchasing behaviors.

b.  **Address Underperforming Areas:**
* **Regional Strategy Review:** Investigate the reasons for low sales in regions like Nunavut, Northwest Territories, and Yukon. This might involve market research, targeted marketing campaigns, or re-evaluation of logistical feasibility.
* **Bottom Customer Re-engagement:** Develop specific re-engagement campaigns (e.g., targeted discounts, personalized recommendations, feedback surveys) to encourage repeat purchases from low-revenue customers.

c.  **Optimize Operations & Customer Satisfaction:**
* **Investigate Return Root Causes:** Conduct a comprehensive analysis of returned items to identify underlying issues (e.g., product quality, inaccurate descriptions, fulfillment errors) and develop strategies to reduce return rates across all customer segments.
* **Refine Shipping Strategy:** Re-evaluate the shipping method selection process, particularly for high-priority orders. Ensure that faster, more appropriate shipping methods (like Express Air) are utilized for "Critical" and "High" priority orders, even if individual costs are higher, to maintain customer satisfaction and service level agreements. A detailed cost-benefit analysis comparing expedited shipping with customer retention and satisfaction should be performed.
* **Data-Driven Decision Making:** Continuously monitor key performance indicators (KPIs) related to sales, customer segments, shipping costs, and returns to ensure ongoing strategic alignment and identify new opportunities or challenges.










    












    
   








