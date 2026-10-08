I started with a dirty cafe file - 10,001 rows, most of them ERROR.
I cleaned it to 3,089 rows I could actually use.

Two bugs that blocked me:
1. I made Pivot from A2 / J4 empty -> got PivotTable16 empty cache
2. Fields were invisible because Side-by-Side layout was unchecked - fixed from gear icon

What I found:
- Salad is best seller: 1272 qty, $6360 (Sheet2)
- Jan is biggest month: 913 sales, Salad peaks Aug 122 / Jan 121, worst May 64 (Sheet3)
- 70% errors means POS system is broken

Files: raw csv, clean xlsx, analysis xlsx with pivots

Learned: cleaning = decide Delete / Keep as Unknown, not just delete everything.
