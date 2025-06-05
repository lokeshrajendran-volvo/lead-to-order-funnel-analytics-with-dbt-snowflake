SELECT
  opp_id,
  lead_id,
  stage,
  CAST(created_at AS DATE) AS created_date
FROM {{ ref('opportunities') }}
