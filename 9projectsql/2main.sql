-- Membuat CTE donation_details untuk menghitung total donasi per assignment dan donor_type
WITH donation_details AS (
    SELECT
        d.assignment_id,  -- Ambil ID assignment dari tabel donations
        ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,  -- Hitung total donasi dan bulatkan 2 desimal
        dn.donor_type  -- Ambil tipe donor dari tabel donors
    FROM donations d
    JOIN donors dn ON d.donor_id = dn.donor_id  -- Join untuk mendapatkan tipe donor
    GROUP BY d.assignment_id, dn.donor_type  -- Kelompokkan per assignment dan tipe donor
),
ranked AS (
    SELECT
        *,  -- Ambil semua kolom dari donation_details
        ROW_NUMBER() OVER (PARTITION BY donor_type ORDER BY rounded_total_donation_amount DESC) AS rn
        -- Beri peringkat per donor_type berdasarkan total donasi tertinggi
)
SELECT
    a.assignment_name,  -- Nama assignment
    a.region,           -- Region assignment
    r.rounded_total_donation_amount,  -- Total donasi yang sudah dibulatkan
    r.donor_type        -- Tipe donor
FROM ranked r
JOIN assignments a ON a.assignment_id = r.assignment_id  -- Join untuk mendapatkan nama dan region
WHERE rn <= 5  -- Ambil 5 teratas per donor_type
ORDER BY r.rounded_total_donation_amount DESC;  -- Urutkan hasil berdasarkan total donasi tertinggi







#######################


-- CTE donation_counts untuk menghitung jumlah donasi per assignment
WITH donation_counts AS (
    SELECT
        assignment_id,  -- ID assignment
        COUNT(donation_id) AS num_total_donations  -- Hitung jumlah donasi per assignment
    FROM donations
    GROUP BY assignment_id  -- Kelompokkan per assignment
),
ranked_assignments AS (
    SELECT
        a.assignment_name,  -- Nama assignment
        a.region,           -- Region assignment
        a.impact_score,     -- Impact score assignment
        dc.num_total_donations,  -- Jumlah donasi
        ROW_NUMBER() OVER (PARTITION BY a.region ORDER BY a.impact_score DESC) AS rank_in_region
        -- Beri peringkat per region berdasarkan impact tertinggi
    FROM assignments a
    JOIN donation_counts dc ON a.assignment_id = dc.assignment_id  -- Join untuk memastikan assignment punya donasi
    WHERE dc.num_total_donations > 0  -- Hanya ambil assignment yang punya minimal 1 donasi
)
SELECT
    assignment_name,        -- Nama assignment
    region,                 -- Region assignment
    impact_score,           -- Impact score
    num_total_donations     -- Jumlah donasi
FROM ranked_assignments
WHERE rank_in_region = 1  -- Ambil assignment dengan impact tertinggi per region
ORDER BY region ASC;       -- Urutkan hasil berdasarkan region
