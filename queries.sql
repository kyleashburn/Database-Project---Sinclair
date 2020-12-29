/*
Programmer: Kyle Ashburn
Assignment: Database Final Project: Queries
Date:4/24/18
*/

--Query #1
--Multi-Table query that uses concatenataion and compound search condition to return job information including location (a column alias). I then throw in a sort on multiple tables for fun.
SELECT j.job_id, j.job_name, c.category_name, salary, cz.zip, city || ', ' || state AS location
FROM jobs j
    INNER JOIN category c
        ON j.category_id = c.category_id
    INNER JOIN salary s
        ON s.jobid = j.job_id
    INNER JOIN cityzip cz
        ON s.zip = cz.zip
    INNER JOIN region r
        ON r.region_id = cz.region_id
WHERE state = 'NC' OR state = 'OH'
ORDER BY state DESC, city ASC, category_name ASC;
--I'm quite proud of this one!


--Query #2
-- Multi-table query that returns the state and the sum of the salaries for that state. Uses aggregate function, alias, groups by state, and orders by the sum.
SELECT state, SUM(salary) AS state_sal_sum
FROM region r
    INNER JOIN cityzip cz
        ON cz.region_id = r.region_id
    INNER JOIN salary s
        ON s.zip = cz.zip
GROUP BY state
ORDER BY SUM(salary);

--Query #3
--A very simple single-table query that shows region id and what state it's in using distinct to prevent repeat of region.
SELECT DISTINCT region_id, state
FROM region;

--Query #4
--Uses a subquery to return the salaries that are higher than average. 
SELECT jobid, job_name, salary, zip
FROM salary s
    INNER JOIN jobs j
        ON j.job_id=s.jobid
WHERE salary > 
    (SELECT AVG(salary)
     FROM salary )
ORDER BY salary;

--Query #5
--A very very simple suqery that returns the range for the salaries to show use of basic arithmatic.
SELECT MAX(salary)-MIN(salary) AS salary_range
FROM salary;



--Demonstrating use of function (Not a very complex function)
select salaryid, jobid, categoryid, zip, salary, what_state(zip)
FROM salary;
--Output has weird formatting.


--Demonstrating use of Trigger
INSERT INTO region
(region_id, region_name, state)
VALUES
(region_id_seq.nextval, 'New York City', 'ny');

--See what is returned.
SELECT state
FROM region r
WHERE region_name LIKE '%New York%';

--deleting row of data to ensure database is clean
DELETE FROM region
WHERE state = 'NY';


--Demonstrating use of procedure
CALL insert_row_category_proc
( 'Ninja-Clown(Mime)', 'Espionage/Entertainment');

--Results
SELECT *
FROM category
WHERE category_name LIKE '%Ninja%';

--Then cleaning up again.
DELETE FROM category
WHERE category_name LIKE '%Ninja%';

--Demonstrating that the view works.
SELECT *
FROM managers;

