-- =============================================
-- PART 1: PREPARATION
-- Membuat wadah dan import data (dilakukan sekali saja)
-- =============================================
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC, 
    freight_value NUMERIC
);

-- Cek data
SELECT * FROM order_items LIMIT 5;

-- =============================================
-- PART 2: EDA & FILTERING
-- Mencari "Aktor Utama": Produk Laris dengan Variasi Harga
-- =============================================
SELECT 
    product_id,
    COUNT(*) as quantity_sold,           -- Indikator Volume
    COUNT(DISTINCT price) as variasi_harga -- Indikator Elastisitas
FROM order_items
GROUP BY product_id
HAVING COUNT(DISTINCT price) >= 3 
ORDER BY quantity_sold DESC     
LIMIT 3;

-- (Output: Kita pilih ID 'aca2eb7d00ea1a7b8ebd4e68314663af')

-- =============================================
-- PART 3: DATA TRANSFORMATION
-- Karena tidak ada kolom 'quantity', kita buat sendiri pakai CTE
-- =============================================
WITH good_table AS (
    SELECT 
        price, 
        COUNT(*) as quantity_sold 
    FROM order_items
    WHERE product_id = 'aca2eb7d00ea1a7b8ebd4e68314663af' 
    GROUP BY price 
)
SELECT * FROM good_table ORDER BY price;

-- =============================================
-- PART 4: THE BRAIN (ELASTICITY CHECK)
-- Menghitung Slope & Intercept untuk melihat sensitivitas
-- =============================================
WITH good_table AS (
    SELECT price, COUNT(*) as quantity_sold 
    FROM order_items
    WHERE product_id = 'aca2eb7d00ea1a7b8ebd4e68314663af' 
    GROUP BY price 
)
SELECT 
    regr_slope(ln(quantity_sold), price) as slope,        
    regr_intercept(ln(quantity_sold), price) as intercept
FROM good_table;

-- =============================================
-- PART 5: THE OPTIMIZATION (CALCULUS METHOD)
-- Mencari Harga Optimal (Teoritis)
-- =============================================
WITH good_table AS (
    SELECT price, COUNT(*) as quantity_sold 
    FROM order_items
    WHERE product_id = 'aca2eb7d00ea1a7b8ebd4e68314663af' 
    GROUP BY price 
),
regression_stats AS (
    SELECT 
        regr_intercept(ln(quantity_sold), price) as intercept,
        regr_slope(ln(quantity_sold), price) as slope
    FROM good_table
)
SELECT 
    slope,
    intercept,
    -- CASTING KE NUMERIC (Biar gak Double Precision lagi)
    ROUND((-1.0 / slope)::NUMERIC, 2) AS optimal_price_recommendation,
    
    -- CASTING KE NUMERIC
    ROUND(((-1.0 / slope) * EXP(intercept - 1.0))::NUMERIC, 2) AS max_possible_revenue

FROM regression_stats;

-- =============================================
-- PART 6: REALITY CHECK (HISTORICAL BEST)
-- Membandingkan Teori vs Fakta Lapangan
-- (REVISI: CTE 'regression_stats' DIHAPUS karena tidak dipakai)
-- =============================================
WITH good_table AS (
    SELECT 
        price, 
        COUNT(*) as quantity_sold 
    FROM order_items
    WHERE product_id = 'aca2eb7d00ea1a7b8ebd4e68314663af'
    GROUP BY price 
)
SELECT
    price, 
    price * quantity_sold AS revenue
FROM good_table
ORDER BY revenue DESC
LIMIT 1;