let
 Source = Csv.Document(File.Contents(DataFolder & "\fact_orders.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
 Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 Typed = Table.TransformColumnTypes(Headers,{{"OrderId", Int64.Type}, {"OrderDate", type date}, {"ShippingDate", type date}, {"ShippingMode", type text}, {"Market", type text}, {"Region", type text}, {"OrderStatus", type text}, {"DeliveryStatus", type text}, {"ActualDays", Int64.Type}, {"ScheduledDays", Int64.Type}, {"DelayDays", Int64.Type}, {"Eligible", Int64.Type}, {"Late", Int64.Type}, {"SampleLineCount", Int64.Type}, {"SampleQuantity", Int64.Type}, {"SampleNetSales", type number}, {"SampleBenefit", type number}},"en-US")
in
 Typed