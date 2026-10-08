# Interview practice: learn the project before claiming independent proficiency
## 60-second explanation
I started with a historical supply chain sample of 15,000 order lines. I checked the grain and found 9,656 distinct orders. I separated canceled/suspected-fraud orders, compared actual versus scheduled shipping days, and ranked modes by both late rate and late-order volume. Excel provides a formula-driven view, SQL reproduces the metrics, and the Power BI project defines the model and measures. This is educational sample data, and I have not measured an operational improvement.

## Ten sessions
1. Excel: explain the original pivots, source tables and chart ranges. Rebuild a shipping-mode pivot independently.
2. Excel: rebuild COUNTIFS/SUMIFS/AVERAGEIFS metrics from raw eligible orders. Explain weighted rate versus average rates.
3. Data quality: identify duplicate OrderItemId, repeated OrderId, cancellation and partial-order risk.
4. SQL: write SELECT, WHERE and GROUP BY for mode performance from a blank file.
5. SQL: implement order-level grouping; demonstrate why blindly using MIN can hide conflicts.
6. SQL: reproduce monthly LAG and per-market DENSE_RANK; explain ties and percentage points.
7. Power BI: open/refresh the PBIP, set the parameter, inspect relationships and compare cards with SQL.
8. DAX: explain CALCULATE, filter context, DIVIDE and why the fact tables share dimensions instead of joining directly.
9. Reporting: independently change a measure, add a market slicer and explain one insight plus one limitation.
10. Mock interview: demonstrate the entire pipeline without reading the README, then record questions you could not answer.

## Questions to answer
- Why are there fewer orders than rows?
- Why exclude canceled orders from this particular denominator?
- Why can the mode with the highest late rate differ from the mode with most late orders?
- Is the source shipping date a verified delivery-to-customer date?
- Why not claim OTIF or inventory turnover?
- What does a partial sample mean for financial totals?
- Why is an aggregate margin a ratio of sums?
- What would you need to prove a cost saving or carrier root cause?
- How do filters reach both order and line fact tables?
- Which parts did you build originally, and which did you develop with assistance?

## Readiness gate
Describe AI assistance honestly. Present only skills you can demonstrate. Before claiming a completed native Power BI dashboard, refresh and render it in Desktop, check the published KPI values, and save the verified report/screenshots.
