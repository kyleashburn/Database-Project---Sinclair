/*
Programmer: Kyle Ashburn
Assignment: Final Database Project
Date:4/24/18
*/

--connect to system to create new user. 
CONNECT system/system

BEGIN

    EXECUTE IMMEDIATE 'DROP USER ka';

    EXECUTE IMMEDIATE 'CREATE USER ka IDENTIFIED BY ka';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE, CREATE ANY VIEW TO ka';

    EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE(' '); 
END;
/
DISCONNECT system;

CONNECT ka/ka;

--Clean up user/schema

--Drop sequences

BEGIN 

    EXECUTE IMMEDIATE 'DROP SEQUENCE salary_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE job_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE category_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE region_id_seq';

    EXECUTE IMMEDIATE 'DROP TABLE  region CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE category CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE cityzip CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE jobs CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE salary CASCADE CONSTRAINTS';

    EXECUTE IMMEDIATE 'DROP TRIGGER city_zip_b4_update_uppercase_state';

    EXECUTE IMMEDIATE 'DROP PROCEDURE insert_row_category_proc';
    
    EXECUTE IMMEDIATE 'DROP FUNCTION what_state';

    EXECUTE IMMEDIATE 'DROP VIEW managers';

   EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE(' '); 

END;
/


--Create the sequences. 
CREATE SEQUENCE salary_id_seq;

CREATE SEQUENCE job_id_seq;

CREATE SEQUENCE category_id_seq;

CREATE SEQUENCE region_id_seq;

--Create the tables.
CREATE TABLE region
(
region_id NUMBER,
region_name VARCHAR2(100),
state VARCHAR2(25)
);

CREATE TABLE category
(
category_id NUMBER,
category_name VARCHAR2(100),
field VARCHAR2(50)
);

CREATE TABLE cityzip
(
zip NUMBER,
city VARCHAR2(75),
region_id NUMBER
);

CREATE TABLE jobs
(
job_id NUMBER ,
category_id NUMBER,
description VARCHAR2(500),
job_name VARCHAR2(75)   
);

CREATE TABLE salary
(
SalaryID NUMBER,
JobID NUMBER,
CategoryID NUMBER,	
ZIP	NUMBER,
Salary NUMBER
);

--Add trigger
CREATE OR REPLACE TRIGGER region_upcase_state
BEFORE INSERT OR UPDATE OF state 
ON region
FOR EACH ROW 
WHEN (new.state != UPPER(new.state))
BEGIN
  :new.state := UPPER(:new.state);
END;
/


--Add procedure
CREATE OR REPLACE PROCEDURE insert_row_category_proc
(
 category_name_param category.category_name%type,
  field_param category.field%type  
)
AS
    
BEGIN

    INSERT INTO category
    (
    category_id,
    category_name,
    field
    )
    
    VALUES
    (
    category_id_seq.nextval,
    category_name_param,
    field_param
    );
    
    COMMIT;
EXCEPTION WHEN OTHERS THEN
ROLLBACK;

END;
/

--Insert Data

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'User Support' , 'IT');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Database Services' , 'IT');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Network Security' , 'IT');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Network Engineering' , 'IT');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'IT Management' , 'IT');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Administrative Support' , 'Administration');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Marketing Analytics' , 'Marketing');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Marketing Support' , 'Marketing');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Marketing' , 'Marketing');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Marketing Management' , 'Marketing');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Bookkeeping' , 'Accounting');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'AP/AR Staff' , 'Accounting');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Accounting' , 'Accounting');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Accounting Management' , 'Accounting');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Compensation and Benefits' , 'Human Resources');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Training' , 'Human Resources');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Recruiting' , 'Human Resources');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'HR Analytics' , 'Human Resources');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'CHR Management' , 'Human Resources');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Back End' , 'Software Development');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'Front End' , 'Software Development');

INSERT INTO Category
(
category_id, category_name, field)
VALUES
( CATEGORY_ID_SEQ.NEXTVAL, 'SD Management' , 'Software Development');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Cincinati', 'OH');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Columbus', 'OH');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Dayton', 'OH');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Cary', 'NC');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Cihapel Hill', 'NC');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Raleigh', 'NC');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Durham', 'NC');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Tampa', 'FL');

INSERT INTO region
(region_id, region_name, state)
VALUES
(REGION_ID_SEQ.NEXTVAL,'Chicago', 'IL');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 1, 'User Support Specialist');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 2, 'Database Administrator');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 3, 'Network Security Specialist');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 4, 'Network Engineer');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL ,5 , 'IT Manager 1');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 6, 'Office Assistant 2');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 7, 'Senior Marketing Analyst');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 8, 'Junior Graphic Designer');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 9, 'Marketing Generalist');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 10, 'Marketing Director');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 11, 'Bookkeeper');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 12, 'Accounts Recievable Accountant');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 13, 'Certified Public Accountant');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 14, 'Accounting Manager');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 15, 'Benefits Manager');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 16, 'Training Specialist');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 17, 'Recruiter');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 18, 'HR Analyst');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 19, 'HR Manager');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 20, 'Front End Developer');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 21, 'Back End Developer');

INSERT INTO jobs
( job_id, category_id, job_name)
VALUES
(JOB_ID_SEQ.NEXTVAL, 22, 'Software Development Lead');

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 1,1 , 45424, 38000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 2 , 2 , 45206, 110000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 3 ,3 , 43054, 119000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 4,4 , 27516, 125000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 5,5 , 27602, 130000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 6,6 , 27701, 48000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 7, 7 , 27711, 123000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 8,8 , 27539, 35000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 9 , 9 , 33616, 47500);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 10 , 10 , 33617, 115000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 11 ,11 , 43240, 43000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 12 ,12 ,43251 , 60000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 13 ,13 , 60601, 76000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 14 ,14 , 60602, 84500);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 15 ,15 , 60603, 62000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 16 ,16 , 60609, 48000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 17 ,17 , 27706, 49000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 18 ,18 , 27707, 78000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 19 ,19 , 33603, 96000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 20 ,20 , 27560, 67000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 21, 21 , 27606, 89000);

INSERT INTO salary
(salaryid, jobid, categoryid, zip, salary)
VALUES
(SALARY_ID_SEQ.NEXTVAL, 22 ,22 , 27607, 117000);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(45424, 'Dayton', 4);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(45206,'Cincinati',1);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(43054, 'Columbus', 2);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27516,'Chapel Hill', 3);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27602, 'Raleigh', 6);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27701,'Durham', 7);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27711, 'Durham', 7);


INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27539, 'Cary', 5);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(33616, 'Tampa', 8);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(33617, 'Tampa', 8);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(43240, 'Columbus', 2);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(43251, 'Columbus', 2);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(60601, 'Chicago', 9);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(60602, 'Chicago', 9);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(60603, 'Chicago', 9);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(60609, 'Chicago', 9);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27706, 'Durham', 7);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27707, 'Durham', 7);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(33603, 'Tampa', 8);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27560, 'Raleigh', 6);

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27606, 'Raleigh', 6); 

INSERT INTO cityzip
(zip, city, region_id)
VALUES
(27607, 'Raleigh', 6);

--Add constraints

ALTER TABLE region
ADD CONSTRAINT region_constraint_pk PRIMARY KEY (region_id);

ALTER TABLE region
ADD CONSTRAINT region_constraint_reg_name_unq UNIQUE (region_name);

ALTER TABLE cityzip
ADD CONSTRAINT cityzip_constraint_reg_id_fk FOREIGN KEY(region_id) REFERENCES region(region_id);

ALTER TABLE cityzip
ADD CONSTRAINT cityzip_constraint_pk PRIMARY KEY(zip);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_pk PRIMARY KEY (category_id);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_cat_name_unq UNIQUE(category_name);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_pl PRIMARY KEY (job_id);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_cat_id_fk FOREIGN KEY(category_id) REFERENCES category(category_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_pk PRIMARY KEY(salaryid);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_job_id_fk FOREIGN KEY(jobid) REFERENCES jobs(job_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_zip_fk FOREIGN KEY(zip) REFERENCES cityzip(zip);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_chk CHECK (salary >=0);

--Create View
CREATE VIEW managers
AS 
    SELECT j.job_id, job_name, c.category_id, c.category_name, salary
    FROM jobs j
        INNER JOIN category c
            ON c.category_id = j.category_id
        INNER JOIN salary s
            ON s.jobid=j.job_id
    WHERE category_name LIKE '%Management%';	
