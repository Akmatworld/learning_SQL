task 1
 SELECT model,speed,hd FROM PC WHERE price < 500

task 2
 SELECT DISTINCT maker FROM Product WHERE type = 'Printer'
task 3
 SELECT model,ram,screen FROM laptop WHERE price > 1000
task 4
 SELECT * FROM Printer WHERE color = 'y'
task 5
 SELECT model,speed,hd FROM PC WHERE (cd = '12x' OR cd = '24x') AND price < 600

task 6
 SELECT DISTINCT p.maker, l.speed
 FROM product p INNER JOIN laptop l
 ON p.model=l.model AND l.hd>=10

task 7 
 SELECT model, price
 FROM PC
 WHERE model IN (SELECT model
 				FROM Product
 				WHERE maker = 'B' AND
 				type = 'PC')
UNION
SELECT model, price
FROM Laptop
WHERE model IN (SELECT model
 					FROM Product
 					WHERE maker = 'B' AND type = 'Laptop')
UNION
SELECT model, price
FROM Printer
WHERE model IN (SELECT model
				FROM Product
 				WHERE maker = 'B' AND type = 'Printer')
task 8
SELECT maker FROM Product WHERE type = 'PC'
except
SELECT maker FROM Product WHERE type = 'Laptop'

task 9
SELECT DISTINCT p.maker 
FROM Product p INNER JOIN PC pc  
ON p.model = pc.model
WHERE p.type = 'PC' AND pc.speed >=450

task 10
SELECT model,price
FROM Printer
WHERE price = (SELECT MAX(price) FROM Printer)

task 11
SELECT AVG(speed) FROM PC

task 12
SELECT AVG(speed) AS Avg_speed 
FROM Laptop WHERE price > 1000

task 13
SELECT AVG(pc.speed)
FROM PC pc INNER JOIN Product p
ON p.model=pc.model
WHERE p.maker = 'A'

task 14
SELECT maker, MAX(type) 
FROM product 
GROUP BY maker 
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1

task 15
SELECT hd FROM PC GROUP BY hd HAVING COUNT(hd) >= 2

task 16
SELECT DISTINCT A.model AS model,B.model AS model,A.speed,A.ram
FROM PC as A INNER JOIN PC as B
ON A.speed = B.speed AND A.ram = B.ram AND A.model > B.model
ORDER BY A.model

task 17
SELECT DISTINCT p.type Type,l.model Model,l.speed 
FROM Laptop l INNER JOIN Product p
ON p.model=l.model
WHERE speed < (SELECT MIN(speed) FROM PC)

task 18
SELECT DISTINCT p.maker Maker,pr.price
FROM Product p INNER JOIN Printer pr
ON p.model = pr.model 
WHERE pr.color = 'y' AND pr.price = (SELECT MIN(price) FROM Printer GROUP BY color HAVING color = 'y')

task 19
SELECT p.maker,AVG(l.screen) Screen
FROM Product p INNER JOIN Laptop l
ON p.model = l.model
GROUP BY p.maker

task 20
SELECT DISTINCT maker Maker, COUNT(model) Count_model
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(model) >= 3

task 21
SELECT p.maker Maker,MAX(pc.price) Max_price
FROM Product p INNER JOIN PC pc 
ON p.model = pc.model 
GROUP BY maker

task 22
SELECT speed, AVG(price) AVG_price
FROM PC
WHERE speed > 600
GROUP BY speed

task 23
SELECT p.maker 
FROM Product p INNER JOIN PC pc 
ON p.model=pc.model 
WHERE speed >= 750
INTERSECT
SELECT p.maker 
FROM Product p INNER JOIN Laptop l 
ON p.model=l.model 
WHERE speed >= 750

task 24
SELECT model FROM
				(SELECT model,price
				FROM PC WHERE price = (SELECT MAX(price) 
					                   FROM PC)
UNION
SELECT model,price
FROM Printer WHERE price = (SELECT MAX(price)
                            FROM Printer)
UNION
SELECT model,price
FROM Laptop WHERE price = (SELECT MAX(price)
                           FROM Laptop)) X
						   WHERE price = (SELECT MAX(price)
						   				  FROM (SELECT price
												FROM PC WHERE price = (SELECT MAX(price) 
                       												   FROM PC)
UNION
SELECT price
FROM Printer WHERE price = (SELECT MAX(price)
                            FROM Printer)
UNION
SELECT price
FROM Laptop WHERE price = (SELECT MAX(price)
                           FROM Laptop)) A
);

task 25
SELECT DISTINCT p.maker 
FROM Product p INNER JOIN PC pc 
ON p.model=pc.model
WHERE p.maker IN(SELECT maker 
                 FROM Product WHERE type = 'Printer')
					AND pc.ram = (SELECT MIN(pc.ram) 
								  FROM Product p INNER JOIN PC pc 
                					ON p.model=pc.model
                					WHERE p.maker IN(SELECT maker 
                									 FROM Product WHERE type = 'Printer'))
					AND pc.speed = (SELECT MAX(pc.speed) 
									FROM Product p INNER JOIN PC pc ON p.model=pc.model
									WHERE p.maker IN(SELECT maker 
                 					FROM Product WHERE type = 'Printer')
                 	AND pc.ram = (SELECT MIN(pc.ram) 
                 				  FROM Product p INNER JOIN PC pc ON p.model=pc.model
                              	  WHERE p.maker IN(SELECT maker 
                              	  FROM Product WHERE type = 'Printer')))

task 26
SELECT AVG(price) AVG_price
FROM (SELECT pc.price 
	  FROM Product p INNER JOIN PC pc
       ON p.model = pc.model 
       WHERE p.maker = 'A' 
       		UNION ALL 
       SELECT l.price 
       FROM Product p INNER JOIN Laptop l
       ON p.model = l.model 
       WHERE p.maker = 'A'     
) AS A;

task 27

SELECT p.maker Maker,AVG(hd) Avg_hd 
FROM PC pc INNER JOIN Product p
ON p.model=pc.model
WHERE p.maker IN(SELECT maker 
                 FROM Product WHERE type = 'Printer')
GROUP BY p.maker

task 31
SELECT class,country 
FROM classes
WHERE bore >= 16

task 33
SELECT ship FROM Outcomes WHERE battle = 'North Atlantic' AND result = 'sunk';

task 34
SELECT s.name FROM Ships s INNER JOIN Classes c ON s.class=c.class
WHERE launched >= 1922 AND displacement >= 35000 AND type = 'bb'

task 35
SELECT model, type 
FROM product 
WHERE UPPER(model) NOT LIKE '%[^A-Z]%' 
OR model not LIKE '%[^0-9]%'

task 36
SELECT ship AS name  FROM outcomes WHERE ship IN(SELECT class FROM Classes)
UNION
SELECT s.name AS name FROM Classes c INNER JOIN ships s ON c.class=s.class WHERE s.name = c.class

task 37

SELECT c.class 
FROM classes c INNER JOIN (SELECT class,name 
                           FROM ships
                           UNION
                           SELECT c.class,o.ship 
                           FROM Outcomes o inner join Classes c
                           ON c.class=o.ship) AS t1
ON t1.class = c.class
GROUP BY c.class
HAVING COUNT(c.class) = 1

task 38
SELECT country FROM Classes WHERE type = 'bb'
intersect
SELECT country FROM Classes WHERE type = 'bc'

task 40
SELECT c.class,s.name,c.country
FROM Classes c INNER JOIN Ships s
ON c.class=s.class
WHERE numGuns >= 10

task 41

SELECT 'cd' chr,cast(cd AS VARCHAR(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)
UNION
SELECT 'hd' ,cast(hd AS VARCHAR(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)
UNION
SELECT 'model' ,cast(model AS VARCHAR(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)
UNION
SELECT 'price' ,cast(price as varchar(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)
UNION
SELECT 'ram' ,cast(ram as varchar(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)
UNION
SELECT 'speed' ,cast(speed as varchar(20)) value FROM pc WHERE code = (SELECT MAX(code) FROM pc)

task 42
SELECT DISTINCT o.ship,b.name 
FROM Outcomes o INNER JOIN Battles b
ON o.battle=b.name
WHERE o.result = 'sunk'

task 44
SELECT name FROM Ships WHERE name LIKE 'r%'
union
SELECT ship FROM Outcomes WHERE ship LIKE 'r%'

task 45
SELECT ship FROM Outcomes WHERE ship LIKE '% % %'
UNION
SELECT name FROM Ships WHERE name LIKE '% % %'

task 48
SELECT c.class FROM Outcomes o INNER JOIN Classes c ON c.class=o.ship WHERE o.result = 'sunk'
UNION
SELECT class FROM Ships WHERE name IN(SELECT ship FROM Outcomes WHERE result ='sunk')

task 49
SELECT s.name FROM ships s INNER JOIN Classes c ON s.class = c.class
WHERE c.bore = 16
UNION 
SELECT c.class AS name FROM Classes c INNER JOIN
(SELECT ship FROM outcomes WHERE not ship IN(SELECT name FROM Ships)) AS Out ON out.ship = c.class
WHERE c.bore = 16

task 50
SELECT DISTINCT b.name from 
Outcomes o INNER JOIN Battles b 
ON o.battle =b.name
WHERE o.ship IN(SELECT name 
                FROM ships WHERE class = 'Kongo')

task 53
SELECT CAST(AVG(CAST(numGuns AS NUMERIC(6,2))) AS NUMERIC(6,2)) FROM Classes WHERE type = 'bb'
