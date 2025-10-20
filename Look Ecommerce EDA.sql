 SELECT *
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE user_id IS NOT NULL -- Look at some known users first
LIMIT 10;

---know the scale and the range of the data
SELECT
  COUNT(*) AS total_events,
  COUNT(DISTINCT session_id) AS total_sessions,
  COUNT(DISTINCT user_id) AS total_users_with_events,
  MIN(created_at) AS first_event_time,
  MAX(created_at) AS last_event_time
FROM `bigquery-public-data.thelook_ecommerce.events`;

--analyse the different types of events 
SELECT
  event_type,
  COUNT(*) AS number_of_events,
  -- See what % of all events this type represents
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.events`), 2) AS percent_of_total
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY event_type
ORDER BY number_of_events DESC;


---compare the activities of logged in users vs visitors
SELECT
  IF(user_id IS NULL, 'anonymous', 'known') AS user_type,
  event_type,
  COUNT(*) AS number_of_events
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY event_type, user_type
ORDER BY user_type, event_type DESC;

---analyse the traffoc sources
SELECT
  traffic_source,
  COUNT(DISTINCT session_id) AS number_of_sessions,
  COUNT(DISTINCT user_id) AS number_of_users
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY traffic_source
ORDER BY number_of_sessions DESC;


SELECT
  session_id,
  COUNT(*) as event_count,
  MIN(created_at) as session_start,
  MAX(created_at) as session_end
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE user_id IS NOT NULL -- Filter for known users to see more interesting behavior
GROUP BY session_id
ORDER BY session_start DESC
LIMIT 10;
---User journey from session id
SELECT
  user_id,
  session_id,
  created_at,
  sequence_number,
  event_type,
  uri
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE session_id = 'b4facea4-76a0-43e3-bba9-3ce3d7e0c124' 
ORDER BY sequence_number; -- Order by the sequence to see the journey in order


WITH purchase_sessions AS (
  SELECT DISTINCT session_id
  FROM `bigquery-public-data.thelook_ecommerce.events`
  WHERE event_type = 'purchase'
)

SELECT
  e.session_id,
  e.sequence_number,
  e.event_type,
  e.uri,
  e.created_at
FROM `bigquery-public-data.thelook_ecommerce.events` e
JOIN purchase_sessions p ON e.session_id = p.session_id
WHERE e.session_id IN (SELECT session_id FROM purchase_sessions)
ORDER BY e.session_id, e.sequence_number
LIMIT 100;


----

WITH purchase_sessions AS (
  SELECT DISTINCT session_id
  FROM `bigquery-public-data.thelook_ecommerce.events`
  WHERE event_type = 'purchase'
)

SELECT
  e.session_id,
  e.sequence_number,
  e.event_type,
  e.uri,
  e.created_at
FROM `bigquery-public-data.thelook_ecommerce.events` e
JOIN purchase_sessions p ON e.session_id = p.session_id
WHERE e.session_id IN (SELECT session_id FROM purchase_sessions)
ORDER BY e.session_id, e.sequence_number
LIMIT 100;