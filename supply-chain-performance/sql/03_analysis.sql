-- Rates use eligible distinct orders, not repeated order lines.
SELECT * FROM shipping_performance ORDER BY LateRate DESC;
-- Prioritise by late-order contribution as well as rate.
SELECT ShippingMode,LateOrders,ShareOfLateOrders FROM shipping_performance ORDER BY LateOrders DESC;
-- CTE and window function: month-over-month change in percentage points.
WITH monthly AS (
 SELECT substr(OrderDate,1,7) Month,COUNT(*) EligibleOrders,SUM(Late) LateOrders,
 1.0*SUM(Late)/COUNT(*) LateRate FROM fact_orders
 WHERE Eligible=1 GROUP BY substr(OrderDate,1,7)
)
SELECT *,100*(LateRate-LAG(LateRate) OVER (ORDER BY Month)) MoMChangePP FROM monthly ORDER BY Month;
-- Product-level sample sales and per-market ranking.
WITH product_sales AS (
 SELECT Market,Product,SUM(NetSales) SampleNetSales,SUM(ReportedBenefit) SampleBenefit
 FROM order_lines WHERE OrderStatus NOT IN ('CANCELED','SUSPECTED_FRAUD')
 AND DeliveryStatus<>'Shipping canceled' GROUP BY Market,Product
),ranked AS (
 SELECT *,DENSE_RANK() OVER(PARTITION BY Market ORDER BY SampleNetSales DESC) SalesRank
 FROM product_sales
)
SELECT * FROM ranked WHERE SalesRank<=3 ORDER BY Market,SalesRank;
-- Aggregate reported margin is ratio of sums, not average of individual ratios.
SELECT SUM(ReportedBenefit)/NULLIF(SUM(NetSales),0) SampleReportedMargin FROM order_lines
WHERE OrderStatus NOT IN ('CANCELED','SUSPECTED_FRAUD') AND DeliveryStatus<>'Shipping canceled';
