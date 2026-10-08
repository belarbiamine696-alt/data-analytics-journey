let
 Source = Csv.Document(File.Contents(DataFolder & "\dim_markets.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
 Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 Typed = Table.TransformColumnTypes(Headers,{{"Market", type text}},"en-US")
in
 Typed