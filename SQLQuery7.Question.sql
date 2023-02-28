UPDATE country_vaccination_stats
SET daily_vaccinations = COALESCE((
  SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY daily_vaccinations) OVER (PARTITION BY country)
  FROM country_vaccination_stats AS cv2
  WHERE cv2.country = country_vaccination_stats.country
  AND daily_vaccinations IS NOT NULL
), 0)
WHERE daily_vaccinations IS NULL;

SELECT* FROM country_vaccination_stats
