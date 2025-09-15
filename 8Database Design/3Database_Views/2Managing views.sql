### Managing views = mengelola view di database → melihat, mengubah, atau menghapus view sesuai kebutuhan.

# Creating a view from other views -> bikin view baru dengan query yang mengambil data dari view lain.
# Kegunaan: menyusun lapisan-lapisan query supaya lebih modular, rapi, dan mudah digunakan.

-- Create a view with the top artists in 2017
CREATE VIEW top_artists_2017 AS
-- with only one column holding the artist field
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewid = top_15_2017.reviewid;

-- Output the new view
SELECT * FROM top_artists_2017;

#################
# Granting and revoking access ->  memberikan izin ke user untuk mengakses/ubah objek di database dan mencabut izin tersebut.

-- Revoke everyone's update and insert privileges
REVOKE UPDATE, INSERT ON long_reviews FROM PUBLIC; 

-- Grant the editor update and insert privileges 
GRANT UPDATE, INSERT ON long_reviews TO editor; 


##################
# Updatable views ->  view yang bisa dipakai untuk mengubah data (insert, update, delete), dan perubahannya otomatis memengaruhi tabel asal.
# Tidak semua view updatable → tergantung query yang dipakai saat membuat view.


#######################
# Redefining a view = memperbarui definisi view (query yang mendasarinya).
# Caranya: CREATE OR REPLACE VIEW atau ALTER VIEW.
# Tujuannya agar view tetap relevan dengan perubahan kebutuhan atau struktur data.

-- Redefine the artist_title view to have a label column
CREATE OR REPLACE VIEW artist_title AS
SELECT reviews.reviewid, reviews.title, artists.artist, labels.label
FROM reviews
INNER JOIN artists
ON artists.reviewid = reviews.reviewid
INNER JOIN labels
ON labels.reviewid = artists.reviewid;

SELECT * FROM artist_title;

