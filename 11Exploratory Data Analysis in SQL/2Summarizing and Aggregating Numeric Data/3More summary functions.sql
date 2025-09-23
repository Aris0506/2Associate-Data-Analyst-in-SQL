# Correlation -> cara mengukur hubungan linear antar kolom numerik, biasanya pakai fungsi bawaan DB (seperti corr() di PostgreSQL).

-- Correlation between revenues and profit
SELECT CORR(revenues, profits) AS rev_profits,
	   -- Correlation between revenues and assets
       CORR(revenues, assets) AS rev_assets,
       -- Correlation between revenues and equity
       CORR(revenues, equity) AS rev_equity 
  FROM fortune500;

  

# Mean and Median

-- What groups are you computing statistics by?
SELECT sector,
       -- Select the mean of assets with the avg function
       AVG(assets) AS mean,
       -- Select the median
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY assets) AS median
  FROM fortune500
 -- Computing statistics for each what?
 GROUP BY sector
 -- Order results by a value of interest
 ORDER BY mean;

 
