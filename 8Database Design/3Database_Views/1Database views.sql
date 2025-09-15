# Viewing views - > melihat daftar view yang sudah ada atau menampilkan isi dari sebuah view

-- Get all non-systems views
SELECT * FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');


######################## 
# Creating and querying a view -> membuat sebuah view baru menggunakan view itu layaknya tabel biasa,

-- Create a view for reviews with a score above 9
CREATE VIEW high_scores AS
SELECT * FROM REVIEWS
WHERE score > 9;

-- Count the number of self-released works in high_scores
SELECT COUNT(*) FROM high_scores
INNER JOIN labels ON high_scores.reviewid = labels.reviewid
WHERE label = 'self-released';