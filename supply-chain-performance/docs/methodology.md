# Methodology
## Grain and population
Input has 15,000 unique OrderItemId values and 9,656 distinct OrderId values.
Check consistent order-level dates, mode, market, region, status and durations before taking one record per order. Otherwise MIN() would hide conflicting values and grouping must stop.
Keep canceled/suspected-fraud orders in the order table for reconciliation. Exclude them from shipping performance.
The eligible population has 9,209 orders; the excluded population has 447 orders.

## KPI definitions
- Late rate = late eligible orders / all eligible orders.
- On-time-or-early rate = 1 - late rate. This is shipping duration performance, not OTIF.
- Average late days = mean(ActualDays - ScheduledDays) on eligible late orders only.
- Share of late orders = a mode's late eligible orders / all late eligible orders.
- Reported margin = sum(eligible sampled line benefit) / sum(eligible sampled line net sales). Source monetary units; no unverified currency symbol.
- Monthly grouping uses the order date. Empty months are not fabricated as zero observations.

## Data dictionary
| Field | Meaning |
|---|---|
| OrderId | Grouping key; repeated across order lines. |
| OrderItemId | Unique order-line identifier; primary key. |
| OrderDate / ShippingDate | Source dates, reduced to dates (timestamps not used in the metrics). |
| ShippingMode / Market / Region | Source categorical attributes. Same for all sampled lines of an order; checked before grouping. |
| OrderStatus / DeliveryStatus | Source status fields; canceled/suspected fraud excluded from eligibility. |
| ActualDays / ScheduledDays | Source shipping durations in days. |
| Quantity | Quantity on the sampled order line. |
| NetSales | Source Order Item Total; sample monetary units, currency not independently confirmed. |
| ReportedBenefit | Source Benefit per order recorded on each line; treated as reported line benefit, not audited realised profit. |
| DelayDays | ActualDays - ScheduledDays; signed days. |
| Eligible | 1 unless canceled, suspected fraud, or Shipping canceled. |
| Late | 1 when ActualDays > ScheduledDays. Only eligible orders enter the rate. |
| SampleLineCount / SampleQuantity / SampleNetSales / SampleBenefit | Aggregation of sampled lines; not necessarily complete order totals. |

## Cleaning
Trim categorical strings, normalise dates, type numeric fields, enforce unique order-item keys and positive quantity. Remove customer names, addresses, coordinates and contact/password fields from published data. Check source late-status labels against the duration comparison.
No outlier deletion or arbitrary clipping of negative benefit. Negative reported benefit is retained.

## Original Excel reconciliation
Original Delivery Analysis row counts sum to 15,000: those are line counts, not unique shipments. It includes cancellation in denominators.
Original row-level average margin ratios also differ from a ratio of summed monetary values. The corrected outputs are intentionally not expected to match those original rates.

## Limits
Sample selection is unknown, spans 2015-2018 and may contain partial orders. Avoid extrapolating to the whole company, claiming an intervention improved performance, asserting carrier root causes, or naming confidential SEBN-MA data. Product category is an order-line attribute; it is not assigned as a unique order category.
Data provenance: https://data.mendeley.com/datasets/8gx2fvg2k6/5. Authors Constante, Silva, Pereira; CC BY 4.0. Exact source version used for the pre-existing workbook is unrecorded.
