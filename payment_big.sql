USE sakila;

CREATE TABLE payment_big ( 
    payment_id   INT UNSIGNED NOT NULL AUTO_INCREMENT, 
    customer_id  SMALLINT UNSIGNED NOT NULL, 
    staff_id     TINYINT UNSIGNED NOT NULL, 
    rental_id    INT DEFAULT NULL, 
    amount       DECIMAL(5,2) NOT NULL, 
    payment_date DATETIME NOT NULL, 
    PRIMARY KEY (payment_id) 
) ENGINE=InnoDB; 

-- Multiplica los pagos reales x60 desplazando la fecha (aprox. 1 millón de filas) 
INSERT INTO payment_big (customer_id, staff_id, rental_id, amount, payment_date) 
SELECT p.customer_id, p.staff_id, p.rental_id, p.amount, p.payment_date + INTERVAL (a.d + 10 * b.d) DAY 
FROM payment p 
CROSS JOIN (
    SELECT 0 d 
    UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 
    UNION ALL SELECT 9) a 
CROSS JOIN 
    (SELECT 0 d 
    UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    UNION ALL SELECT 5) b;