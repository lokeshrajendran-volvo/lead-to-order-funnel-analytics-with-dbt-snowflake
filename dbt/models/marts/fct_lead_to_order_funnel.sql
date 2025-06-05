WITH joined AS (
  SELECT
    l.lead_id,
    o.opp_id,
    od.order_id,
    od.order_value
  FROM {{ ref('stg_leads') }} l
  LEFT JOIN {{ ref('stg_opportunities') }} o ON l.lead_id = o.lead_id
  LEFT JOIN {{ ref('stg_orders') }} od ON o.opp_id = od.opp_id
)

SELECT
  COUNT(DISTINCT lead_id) AS total_leads,
  COUNT(DISTINCT opp_id) AS total_opportunities,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(COUNT(DISTINCT opp_id)::float / NULLIF(COUNT(DISTINCT lead_id), 0), 2) AS lead_to_opp_conversion_rate,
  ROUND(COUNT(DISTINCT order_id)::float / NULLIF(COUNT(DISTINCT opp_id), 0), 2) AS opp_to_order_conversion_rate,
  ROUND(COUNT(DISTINCT order_id)::float / NULLIF(COUNT(DISTINCT lead_id), 0), 2) AS lead_to_order_conversion_rate,
  ROUND(SUM(order_value)::float / NULLIF(COUNT(DISTINCT lead_id), 0), 2) AS avg_order_value_per_lead
FROM joined
