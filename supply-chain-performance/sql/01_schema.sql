PRAGMA foreign_keys=ON;
DROP TABLE IF EXISTS order_lines;
CREATE TABLE order_lines(
 OrderId INTEGER NOT NULL,OrderItemId INTEGER PRIMARY KEY,OrderDate TEXT NOT NULL,
 ShippingDate TEXT NOT NULL,ShippingMode TEXT NOT NULL,Market TEXT NOT NULL,
 Region TEXT NOT NULL,Category TEXT NOT NULL,Product TEXT NOT NULL,
 OrderStatus TEXT NOT NULL,DeliveryStatus TEXT NOT NULL,
 ActualDays INTEGER NOT NULL CHECK(ActualDays>=0),
 ScheduledDays INTEGER NOT NULL CHECK(ScheduledDays>=0),
 Quantity INTEGER NOT NULL CHECK(Quantity>0),NetSales REAL NOT NULL,ReportedBenefit REAL NOT NULL);
CREATE INDEX idx_order ON order_lines(OrderId);
CREATE INDEX idx_date ON order_lines(OrderDate);
