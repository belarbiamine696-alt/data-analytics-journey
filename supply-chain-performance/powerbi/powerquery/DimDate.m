let
 Source = Csv.Document(File.Contents(DataFolder & "\dim_date.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
 Headers = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 Typed = Table.TransformColumnTypes(Headers,{{"Date", type date}, {"Year", Int64.Type}, {"Month", type text}, {"MonthSort", Int64.Type}},"en-US")
in
 Typed