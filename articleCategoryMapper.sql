SELECT 
page_location,
CASE
  WHEN REGEXP_CONTAINS(page_location, r'/scholarships') THEN 'Educations.com Scholarships'
  WHEN REGEXP_CONTAINS(page_location, r'/articles-and-advice') AND REGEXP_CONTAINS(page_location, r'scholarships') THEN 'Scholarship Advice'
  WHEN REGEXP_CONTAINS(page_location, r'/articles-and-advice') AND NOT REGEXP_CONTAINS(page_location, r'scholarships') THEN 'Study Abroad & Articles'
  WHEN REGEXP_CONTAINS(page_location, r'/higher-education-news') THEN 'Study Abroad News'
  WHEN REGEXP_CONTAINS(page_location, r'/study-guides/degree-guides') THEN 'Degree Guides'
  WHEN REGEXP_CONTAINS(page_location, r'/study-guides/subjects') THEN 'Subject Guides'
  WHEN REGEXP_CONTAINS(page_location, r'/study-guides') AND NOT REGEXP_CONTAINS(page_location, r'/subjects/') AND NOT REGEXP_CONTAINS(page_location, r'/study-guides/degree-guides') THEN 'Country Guides'
  WHEN REGEXP_CONTAINS(page_location, r'/top-10-lists') THEN 'Top 10s'
  WHEN REGEXP_CONTAINS(page_location, r'/industry-reports') THEN 'Reports'
  WHEN REGEXP_CONTAINS(page_location, r'/quizzes') THEN 'Quizzes & Tools'
  WHEN REGEXP_CONTAINS(page_location, r'/fair') THEN 'Events'
  ELSE 'Other'
END AS article_type,
INITCAP(REPLACE(CASE
  WHEN REGEXP_CONTAINS(page_location, r'/study-guides/')
        AND NOT REGEXP_CONTAINS(page_location, r'/subjects/')
        AND NOT REGEXP_CONTAINS(page_location, r'/study-guides/degree-guides')
  THEN REGEXP_EXTRACT(page_location, r'/study-guides/[a-zA-Z0-9-]+/study-in-([a-zA-Z0-9-]+)(?:/|$)')
  ELSE NULL
END, '-', ' ')) AS article_country
FROM `keystone-ssgtm.analytics_320674742.sanity_rollup_v2` 
WHERE event_date = "2025-07-20" 
AND LOWER(page_type) LIKE "%article%"
GROUP BY 1,2