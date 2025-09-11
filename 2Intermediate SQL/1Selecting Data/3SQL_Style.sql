# Formatting

-- Rewrite this query
select person_id, role from roles limit 10

-- Formatted query
SELECT person_id, role 
FROM roles 
LIMIT 10;

person id # ingat kali nama field tidak pakai underscore saat memanggil gunakan seperti ini  "person id

SELECT "person id", role  
FROM roles 
LIMIT 10;"