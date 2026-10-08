# Power BI project
Includes 3 PBIR pages, 13 visuals, 5 model tables, 6 single-direction relationships and 12 DAX measures.
Open SupplyChain.pbip in a current Power BI Desktop version supporting PBIP and PBIR. If required, enable the project/enhanced report preview features documented by Microsoft.
Set Transform Data > Manage Parameters > DataFolder to the absolute path of this project's data folder, then Close & Apply and Refresh.
Expected unfiltered counts: 9,209 eligible, 4,809 late, 447 excluded; late rate 52.2%.
Import theme.json if desired. Filter by shipping mode and market on the Shipping modes page.
The two facts share date, mode and market dimensions; they are not connected directly. Product is an order-line attribute. The model does not allocate whole orders to a unique product category.
Native Desktop opening, M refresh, DAX execution and report rendering have not been verified in this environment. JSON/report structure checks are not proof of native execution. Treat this as an authored project pending that verification; save a verified PBIX and screenshots only after the cards reconcile.
Official references:
https://learn.microsoft.com/en-us/power-bi/developer/projects/projects-overview
https://learn.microsoft.com/en-us/power-bi/developer/projects/projects-report
https://learn.microsoft.com/en-us/power-bi/developer/projects/projects-dataset
