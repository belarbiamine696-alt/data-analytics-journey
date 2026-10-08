-- Grain: one order item. Verify consistent order attributes before grouping.
DROP VIEW IF EXISTS fact_orders;
CREATE VIEW fact_orders AS
SELECT OrderId,MIN(OrderDate) OrderDate,MIN(ShippingDate) ShippingDate,
 MIN(ShippingMode) ShippingMode,MIN(Market) Market,MIN(Region) Region,
 MIN(OrderStatus) OrderStatus,MIN(DeliveryStatus) DeliveryStatus,
 MIN(ActualDays) ActualDays,MIN(ScheduledDays) ScheduledDays,
 MIN(ActualDays)-MIN(ScheduledDays) DelayDays,
 CASE WHEN MIN(OrderStatus) IN ('CANCELED','SUSPECTED_FRAUD')
 OR MIN(DeliveryStatus)='Shipping canceled' THEN 0 ELSE 1 END Eligible,
 CASE WHEN MIN(ActualDays)>MIN(ScheduledDays) THEN 1 ELSE 0 END Late,
 COUNT(*) SampleLineCount,SUM(Quantity) SampleQuantity,
 SUM(NetSales) SampleNetSales,SUM(ReportedBenefit) SampleBenefit
FROM order_lines GROUP BY OrderId;
DROP VIEW IF EXISTS shipping_performance;
CREATE VIEW shipping_performance AS
SELECT ShippingMode,COUNT(*) TotalOrders,SUM(Eligible) EligibleOrders,
 SUM(CASE WHEN Eligible=1 THEN Late ELSE 0 END) LateOrders,
 1.0*SUM(CASE WHEN Eligible=1 THEN Late ELSE 0 END)/NULLIF(SUM(Eligible),0) LateRate,
 AVG(CASE WHEN Eligible=1 AND Late=1 THEN DelayDays END) AvgLateDays,
 1.0*SUM(CASE WHEN Eligible=1 THEN Late ELSE 0 END)/
 NULLIF((SELECT SUM(Late) FROM fact_orders WHERE Eligible=1),0) ShareOfLateOrders
FROM fact_orders GROUP BY ShippingMode;
