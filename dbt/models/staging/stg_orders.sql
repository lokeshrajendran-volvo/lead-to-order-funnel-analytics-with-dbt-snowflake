SELECT
  order_id,
  opp_id,
  CAST(order_value AS FLOAT) AS order_value,
  CAST(created_at AS DATE) AS order_date
FROM {{ ref('orders') }}
