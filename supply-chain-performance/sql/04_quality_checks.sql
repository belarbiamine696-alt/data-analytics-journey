-- Every query should return zero issues.
SELECT OrderItemId,COUNT(*) n FROM order_lines GROUP BY OrderItemId HAVING COUNT(*)>1;
SELECT OrderId FROM order_lines GROUP BY OrderId HAVING
 COUNT(DISTINCT OrderDate)>1 OR COUNT(DISTINCT ShippingDate)>1 OR
 COUNT(DISTINCT ShippingMode)>1 OR COUNT(DISTINCT Market)>1 OR
 COUNT(DISTINCT Region)>1 OR COUNT(DISTINCT OrderStatus)>1 OR
 COUNT(DISTINCT DeliveryStatus)>1 OR COUNT(DISTINCT ActualDays)>1 OR COUNT(DISTINCT ScheduledDays)>1;
SELECT OrderItemId FROM order_lines WHERE
 (DeliveryStatus='Late delivery' AND ActualDays<=ScheduledDays) OR
 (DeliveryStatus IN ('Advance shipping','Shipping on time') AND ActualDays>ScheduledDays);
SELECT OrderItemId FROM order_lines WHERE julianday(ShippingDate)<julianday(OrderDate);
