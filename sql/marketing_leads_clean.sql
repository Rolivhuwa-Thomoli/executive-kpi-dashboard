-- Semantic-layer view consumed by the Power BI model.
-- Cleaning pipeline output (Chapter 6): 320 raw CRM rows -> 300 clean rows.
-- 11 province spellings normalised, 19 emails flagged missing rather than guessed.

CREATE VIEW dbo.marketing_leads_clean
AS
SELECT
    lead_id,
    full_name,
    CASE WHEN email LIKE '%_@_%._%' THEN email END AS email,  -- invalid -> NULL, flagged
    province,          -- normalised to the 7 official province names
    monthly_budget,
    source,
    signup_date
FROM dbo.marketing_leads_staging
WHERE province IS NOT NULL
  AND monthly_budget >= 0;
GO
