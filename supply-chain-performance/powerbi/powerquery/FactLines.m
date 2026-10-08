let
 Source = Csv.Document(File.Contents(DataFolder & "\order_lines.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
 Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 Typed = Table.TransformColumnTypes(Headers,{{"OrderId", Int64.Type}, {"OrderItemId", Int64.Type}, {"OrderDate", type date}, {"ShippingDate", type date}, {"ShippingMode", type text}, {"Market", type text}, {"Region", type text}, {"Category", type text}, {"Product", type text}, {"OrderStatus", type text}, {"DeliveryStatus", type text}, {"ActualDays", Int64.Type}, {"ScheduledDays", Int64.Type}, {"Quantity", Int64.Type}, {"NetSales", type number}, {"ReportedBenefit", type number}},"en-US")
in
 Typed