SELECT
  lead_id,
  lead_source,
  CAST(created_at AS DATE) AS created_date
FROM {{ ref('leads') }}
