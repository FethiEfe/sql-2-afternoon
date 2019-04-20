
-- PRACTICE JOINS
-- 1-) 
SELECT * 
    FROM invoice
    JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
    WHERE invoice_line.unit_price > 0.99
-- 2-)
    SELECT first_name, last_name, invoice_date, total
    FROM customer
    JOIN invoice ON invoice.customer_id = customer.customer_id
-- 3-)
    SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
    FROM customer
    JOIN employee ON customer.support_rep_id = employee.employee_id
-- 4-) 
    SELECT album.title, artist.name
    FROM album
    JOIN artist ON album.artist_id = artist.artist_id
-- 5-)
    SELECT playlist_track.track_id
    FROM playlist_track
    JOIN playlist ON playlist_track.track_id = playlist.playlist_id
    WHERE playlist.name = 'Music'
-- 6-)
    SELECT track.name
    FROM track
    JOIN playlist_track ON track.track_id = playlist_track.track_id
    WHERE playlist_track.playlist_id=5
-- 7-)
    SELECT t.name, p.name
    FROM track t
    JOIN playlist_track pt ON t.track_id = pt.track_id
    JOIN playlist p ON pt.playlist_id = p.playlist_id;
-- 8-)
    SELECT track.name, album.title
    FROM track 
    JOIN genre ON genre.genre_id = track.genre_id
    JOIN album ON album.album_id = track.album_id
    WHERE genre.name = 'Alternative & Punk'

-- PRACATICE NESTED QUERIES

-- 1-)
    SELECT *
    FROM invoice
    WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );
-- 2-)
    SELECT *
    FROM playlist_track
    WHERE playlist_id IN 
    ( SELECT playlist_id FROM playlist WHERE name = 'Music' );
-- 3-) 
    SELECT track.name
    FROM track
    WHERE track_id IN 
    ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );
-- 4-)
    SELECT *
    FROM track
    WHERE genre_id IN 
    ( SELECT genre_id FROM genre WHERE name = 'Comedy' );
-- 5-)
    SELECT *
    FROM track
    WHERE album_id IN 
    ( SELECT album_id FROM album WHERE name = 'Fireball' );
-- 6-)
    SELECT *
    FROM track
    WHERE album_id IN ( 
    SELECT album_id FROM album WHERE artist_id IN ( 
        SELECT artist_id FROM artist WHERE name = 'Queen'
    )
    ); 

---------------------------------------------------------------------
-- PRACTICE UPDATING ROWS
-- 1-)
    UPDATE customer
    SET fax = null
-- 2-)
    UPDATE customer
    SET company = 'Self'
    WHERE company IS null
-- 3-)
    UPDATE customer
    SET last_name = 'Thompson'
    WHERE first_name = 'Julia' AND last_name = 'Barnett'
-- 4-)
    UPDATE customer
    SET support_rep_id = 4
    Where email = 'luisrojas@yahoo.cl'
-- 5-)
    UPDATE track
    SET composer = 'The darkness around us'
    WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
    AND composer IS null;

-- ---------------------------------------------------------------------
-- GROUP BY
-- 1-) 
    SELECT COUNT(*), genre.name
    FROM track 
    JOIN genre  ON track.genre_id = genre.genre_id
    GROUP BY genre.name;
-- 2-)
    SELECT COUNT(*), genre.name
    FROM track 
    JOIN genre  ON genre.genre_id = track.genre_id
    WHERE genre.name = 'Pop' OR genre.name = 'Rock'
    GROUP BY genre.name;
-- 3-)
    SELECT ar.name, COUNT(*)
    FROM album al
    JOIN artist ar ON ar.artist_id = al.artist_id
    GROUP BY ar.name;
---------------------------------------------------------------------
-- USE DISTINCT
-- 1-)
    select  distinct composer from track
-- 2-)
    select  distinct billing_postal_code from invoice
-- 3-)
    select  distinct company from customer
---------------------------------------------------------------------
-- DELETE ROWS
-- 1-)
    DELETE 
    FROM practice_table 
    WHERE type = 'bronze';
-- 2-)
    DELETE 
    FROM practice_table 
    WHERE type = 'bronze';
-- 3-)
    DELETE 
    FROM practice_table 
    WHERE value = 150

---------------------------------------------------------------------
-- eCommerce Simulation 

-- 1-) 
    CREATE TABLE users (
  	id SERIAL,
    name VARCHAR(40),
    email VARCHAR(400)
    );

    CREATE TABLE products (
    id SERIAL,
    name VARCHAR(40),
    price INTEGER
    );

    CREATE TABLE orders (
    id SERIAL,
    name VARCHAR(40),
    price INTEGER,
    FOREIGN KEY (id) REFERENCES products(id)
    );
-- 2-) 
    INSERT INTO users (name, user_email) 
    VALUES
    ('Fethi', 'crazyboy_tr@coldmail.com'),
    ('Anand', 'asianboy@asia.com'),
    ('Carlos', 'locaamigo@burrito.com'),

    INSERT INTO products (product_name, product_price) 
    VALUES
    ('chair', 20),
    ('pillow', 3),
    ('mattress', 200),
    
    INSERT INTO orders (id, name, price, total) 
    VALUES
    (1, 20, 'chair', 20),
    (2, 3, 'pillow', 3)
    (3, 200, 'mattress', 200),

-- 3-) 
    SELECT
    SELECT *
    FROM orders;

    SELECT *
    FROM products
    WHERE id = 1;

    SELECT *
    FROM orders
    WHERE users.id = 1;

    SELECT SUM(total)
    FROM orders
    WHERE users.id = 2


    SELECT COUNT(*)
    FROM ORDERS
    where users.id = 3;
