"""Rebuild SQLite and Power BI extracts with Python's standard library."""
from pathlib import Path
import csv,sqlite3,json,datetime
ROOT=Path(__file__).resolve().parents[1]
def export(path,cur):
 with path.open("w",newline="",encoding="utf-8") as f:
  w=csv.writer(f);w.writerow([c[0] for c in cur.description]);w.writerows(cur.fetchall())
def run():
 db=sqlite3.connect(ROOT/"data/supply_chain.sqlite")
 db.executescript((ROOT/"sql/01_schema.sql").read_text())
 with (ROOT/"data/order_lines.csv").open(encoding="utf-8",newline="") as f:
  reader=csv.DictReader(f);fields=reader.fieldnames;raw=list(reader)
 db.executemany("INSERT INTO order_lines VALUES("+",".join("?" for _ in fields)+")",
  [tuple(r[k] for k in fields) for r in raw])
 db.executescript((ROOT/"sql/02_views.sql").read_text())
 for statement in (ROOT/"sql/04_quality_checks.sql").read_text().split(";"):
  if statement.strip():
   issues=db.execute(statement).fetchall()
   if issues:raise ValueError("Data quality check failed: "+repr(issues[:5]))
 for file,sql in [
 ("fact_orders.csv","SELECT * FROM fact_orders ORDER BY OrderId"),
 ("shipping_performance.csv","SELECT * FROM shipping_performance ORDER BY LateRate DESC"),
 ("monthly_performance.csv","SELECT substr(OrderDate,1,7) Month,COUNT(*) EligibleOrders,SUM(Late) LateOrders,1.0*SUM(Late)/COUNT(*) LateRate FROM fact_orders WHERE Eligible=1 GROUP BY substr(OrderDate,1,7) ORDER BY Month"),
 ("dim_modes.csv","SELECT DISTINCT ShippingMode FROM order_lines ORDER BY ShippingMode"),
 ("dim_markets.csv","SELECT DISTINCT Market FROM order_lines ORDER BY Market")]:
  export(ROOT/"data"/file,db.execute(sql))
 low,high=db.execute("SELECT MIN(OrderDate),MAX(OrderDate) FROM order_lines").fetchone()
 day=datetime.date.fromisoformat(low);end=datetime.date.fromisoformat(high)
 with (ROOT/"data/dim_date.csv").open("w",newline="",encoding="utf-8") as f:
  w=csv.writer(f);w.writerow(["Date","Year","Month","MonthSort"])
  while day<=end:
   w.writerow([day.isoformat(),day.year,day.strftime("%Y-%m"),day.year*100+day.month])
   day+=datetime.timedelta(days=1)
 groups={}
 for r in raw:groups.setdefault(r["OrderId"],r)
 eligible=[r for r in groups.values() if r["OrderStatus"] not in ("CANCELED","SUSPECTED_FRAUD") and r["DeliveryStatus"]!="Shipping canceled"]
 late=[r for r in eligible if int(r["ActualDays"])>int(r["ScheduledDays"])]
 actual=db.execute("SELECT COUNT(*),SUM(Eligible),SUM(CASE WHEN Eligible=1 THEN Late ELSE 0 END) FROM fact_orders").fetchone()
 assert actual==(len(groups),len(eligible),len(late)),actual
 for col in ("NetSales","ReportedBenefit"):
  sqlval=db.execute("SELECT SUM("+col+") FROM order_lines").fetchone()[0]
  assert abs(sqlval-sum(float(r[col]) for r in raw))<0.001
 for statement in (ROOT/"sql/03_analysis.sql").read_text().split(";"):
  if statement.strip():db.execute(statement).fetchall()
 report={"line_rows":len(raw),"distinct_orders":len(groups),"eligible_orders":len(eligible),
 "late_orders":len(late),"excluded_orders":len(groups)-len(eligible),"late_rate":len(late)/len(eligible),
 "quality_checks":"passed","SQL_Python_reconciliation":"passed","date_start":low,"date_end":high,
 "power_bi_native_refresh":"pending Desktop verification"}
 (ROOT/"docs/validation.json").write_text(json.dumps(report,indent=2))
 db.commit();db.close();print(json.dumps(report));return report
if __name__=="__main__":run()
