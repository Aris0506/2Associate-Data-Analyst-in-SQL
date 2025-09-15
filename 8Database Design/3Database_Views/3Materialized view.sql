###############################
# Materialized view = query + hasilnya disimpan di DB, lebih cepat, tapi perlu di-refresh supaya data up-to-date.

Creating and refreshing a materialized view - > membuat view dengan query + menyimpan hasilnya. and 
# memperbarui isinya supaya sinkron dengan tabel asli.

-- Create a materialized view called genre_count 
CREATE MATERIALIZED  VIEW genre_count AS
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre;

INSERT INTO genres
VALUES (50000, 'classical');

-- Refresh genre_count
REFRESH MATERIALIZED VIEW genre_count;

SELECT * FROM genre_count;