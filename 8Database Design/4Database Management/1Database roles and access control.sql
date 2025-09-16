# Database roles and access control ->  wadah/grup izin yang bisa dipakai oleh user (ibarat "jabatan").
#  aturan detail siapa boleh apa (ibarat "hak & wewenang" sesuai jabatan).

# Create a role -> itu adalah perintah di database (SQL) untuk membuat sebuah role (peran) 
# yang nantinya bisa diberikan ke user.

-- Create a data scientist role
CREATE ROLE data_scientist;

-- Create a role for Marta
CREATE ROLE marta LOGIN;

-- Create an admin role
CREATE ROLE admin WITH CREATEDB CREATEROLE;


######################
# GRANT privileges and ALTER attributes -> ngasih izin supaya user/role bisa melakukan aksi tertentu.
#  mengubah atribut (bisa tabel, role, user, dll).

-- Grant data_scientist update and insert privileges
GRANT UPDATE, SELECT ON long_reviews TO data_scientist;

-- Give Marta's role a password
ALTER ROLE marta WITH PASSWORD 's3cur3p@ssw0rd';


#########################
# Add a user role to a group role -> memasukkan user ke dalam grup role, 
# supaya user itu otomatis punya semua izin (privileges) yang dimiliki oleh group role tersebut.

-- Add Marta to the data scientist group
GRANT data_scientist TO  Marta;

-- Celebrate! You hired data scientists.


-- Remove Marta from the data scientist group
REVOKE data_scientist FROM Marta;

