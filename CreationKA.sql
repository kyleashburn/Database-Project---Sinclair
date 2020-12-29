CONNECT ka/ka;

--Clean up user/schema

--Drop sequences
DROP SEQUENCE salary_id_seq;
DROP SEQUENCE job_id_seq;
DROP SEQUENCE category_id_seq;
DROP SEQUENCE region_id_seq;

DROP TABLE  region CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE cityzip CASCADE CONSTRAINTS;
DROP TABLE jobs CASCADE CONSTRAINTS;
DROP TABLE salary CASCADE CONSTRAINTS;

DROP TRIGGER city_zip_b4_update_uppercase_state;

DROP PROCEDURE insert_row_category_proc;

DROP FUNCTION what_state;


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

--Add constraints
ALTER TABLE cityzip
ADD CONSTRAINT cityzip_constraint_pk PRIMARY KEY(zip);

ALTER TABLE cityzip
ADD CONSTRAINT cityzip_constraint_region_id_fk FOREIGN KEY(region_id) REFERENCES region(region_id);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_pl PRIMARY KEY (job_id);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_cat_id_fk FOREIGN KEY(category_id) REFERENCES category(category_id);

ALTER TABLE region
ADD CONSTRAINT region_constraint_pk PRIMARY KEY (region_id);

ALTER TABLE region
ADD CONSTRAINT region_constraint_region_name_unq UNIQUE (region_name);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_pk PRIMARY KEY (category_id);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_cat_name_unq UNIQUE(category_name);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_pk PRIMARY KEY(salary_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_job_id_fk FOREIGN KEY(job_id) REFERENCES jobs(job_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_zip_fk FOREIGN KEY(zip) REFERENCES cityzip(zip);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_job_id_fk FOREIGN KEY(category_id) REFERENCES category(category_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_chk CHECK (salary >=0);

--Add trigger
CREATE OR REPLACE TRIGGER city_zip_b4_update_uppercase_state
BEFORE INSERT OR UPDATE OF state 
ON cityzip
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
    categories_name_param,
    field_param
    );
    
    COMMIT;
EXCEPTION WHEN OTHERS THEN
ROLLBACK;

END;
/

--Add function
CREATE OR REPLACE FUNCTION what_state
(
    zip_param NUMBER
)
RETURN VARCHAR2
AS
    state_return VARCHAR2(4);
BEGIN
    SELECT state
    INTO state_return
    FROM region r
        INNER JOIN cityzip cz
            ON cz.city=r.region_name
        INNER JOIN salary s
            ON s.zip = cz.zip
    WHERE s.zip = zip_param;
    RETURN state_return;
END;
/

ALTER TABLE cityzip
ADD CONSTRAINT cityzip_constraint_region_id_fk FOREIGN KEY(region_id) REFERENCES region(region_id);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_pl PRIMARY KEY (job_id);

ALTER TABLE jobs
ADD CONSTRAINT jobs_constraint_cat_id_fk FOREIGN KEY(category_id) REFERENCES category(category_id);

ALTER TABLE region
ADD CONSTRAINT region_constraint_pk PRIMARY KEY (region_id);

ALTER TABLE region
ADD CONSTRAINT region_constraint_region_name_unq UNIQUE (region_name);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_pk PRIMARY KEY (category_id);

ALTER TABLE category
ADD CONSTRAINT cat_constraint_cat_name_unq UNIQUE(category_name);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_pk PRIMARY KEY(salary_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_job_id_fk FOREIGN KEY(job_id) REFERENCES jobs(job_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_zip_fk FOREIGN KEY(zip) REFERENCES cityzip(zip);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_job_id_fk FOREIGN KEY(category_id) REFERENCES category(category_id);

ALTER TABLE salary
ADD CONSTRAINT sal_constraint_chk CHECK (salary >=0);

--Add trigger
CREATE OR REPLACE TRIGGER city_zip_b4_update_uppercase_state
BEFORE INSERT OR UPDATE OF state 
ON cityzip
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
    categories_name_param,
    field_param
    );
    
    COMMIT;
EXCEPTION WHEN OTHERS THEN
ROLLBACK;

END;
/

--Add function
CREATE OR REPLACE FUNCTION what_state
(
    zip_param NUMBER
)
RETURN VARCHAR2
AS
    state_return VARCHAR2(4);
BEGIN
    SELECT state
    INTO state_return
    FROM region r
        INNER JOIN cityzip cz
            ON cz.city=r.region_name
        INNER JOIN salary s
            ON s.zip = cz.zip
    WHERE s.zip = zip_param;
    RETURN state_return;
END;
/