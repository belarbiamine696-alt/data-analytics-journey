let
 Source = Csv.Document(File.Contents(DataFolder & "\dim_modes.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
 Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 Typed = Table.TransformColumnTypes(Headers,{{"ShippingMode", type text}},"en-US")
in
 Typed