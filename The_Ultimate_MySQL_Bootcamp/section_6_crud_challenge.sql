-- 79. CRUD Challenge --------------------------
-- Create the database
CREATE DATABASE shirts_db;

USE shirts_db;

-- Create the shirts table
CREATE TABLE shirts (
    PRIMARY KEY (shirt_id),
    shirt_id   INT          AUTO_INCREMENT,
    article    VARCHAR(30),
    color      VARCHAR(30),
    shirt_size VARCHAR(6),
    last_worn  INT          DEFAULT 0
);

DESC shirts;

-- Insert the initial data
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('t-shirt', 'white', 'S', 10),
       ('t-shirt', 'green', 'S', 200),
       ('polo shirt', 'black', 'M', 10),
       ('tank top', 'blue', 'S', 50),
       ('t-shirt', 'pink', 'S', 0),
       ('polo shirt', 'red', 'M', 5),
       ('tank top', 'white', 'S', 200),
       ('tank top', 'blue', 'M', 15);

SELECT * FROM shirts;

-- Insert a purple polo shirt, size medium, last worn 50 days ago
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('polo shirt', 'purple', 'M', 50);

SELECT * FROM shirts;

-- Select all shirts and return article and color only
SELECT article,
       color
  FROM shirts;

-- Select all medium shirts and return everything but shirt_id
SELECT article,
       color,
       shirt_size,
       last_worn
  FROM shirts
 WHERE shirt_size = 'M';

-- Update all polo shirts to size 'L'
UPDATE shirts
   SET shirt_size = 'L'
 WHERE article = 'polo shirt';

SELECT * FROM shirts;

-- Update the shirt last worn 15 days ago to worn 0 days ago
UPDATE shirts
   SET last_worn = 0
 WHERE last_worn = 15;
 
SELECT * FROM shirts;
 
-- Update all white shirts to size 'XS' and color 'off white'
UPDATE shirts
   SET shirt_size = 'XS',
       color = 'off white'
 WHERE color = 'white';
  
SELECT * FROM shirts;
  
-- Delete all old shirts (last worn 200 days ago)
DELETE FROM shirts
 WHERE last_worn = 200;

SELECT * FROM shirts;

-- Delete all tank tops
DELETE FROM shirts
 WHERE article = 'tank top';

SELECT * FROM shirts;

-- Delete all shirts
DELETE FROM shirts;

SELECT * FROM shirts;

-- Delete the shirts table
DROP TABLE shirts;

SHOW TABLES;







