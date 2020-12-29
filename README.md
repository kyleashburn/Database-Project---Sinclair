# Database Project -Sinclair
As part of my education at my community college, I worked to create a database for a job hunting/posting website I was considering making at the time. I designed it to store such things as job titles, tasks, salary range, and other things. It needed to be able to provide the salary range for a given job in a given area. It also needed to be able to retrieve a job description associated with an id or series of IDs associated with a category. My main goal was to provide the backend for the website I was considering constructiong. The users are individuals accessing information about salary and job information for a given area. The database was an Oracle database so the syntax is matched to Oracle PL/SQL.

The original DDL for my database is as follows:
city_zip (zip, city, region_id(FK))

jobs (job_id, category_id(FK), description, job_name)

category (catergory_id, category_name, description, field)

salary (salary_id, job_id(FK), category_id(FK), zip(FK), salary)

region (region_id, region_name)

My ER diagram is as follows:
![ER Diagram](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/CIS%202268%20DB%20Project%20Schema.svg)

I've included the files that [create the user for my database](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/create_ka.sql), [create the structure of the database](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/CreationKA.sql), and [load in the data](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/load.sql). I've also included some [sample queries](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/queries.sql) I designed. Finally, I've included [the powerpoint](https://github.com/kyleashburn/Database-Project---Sinclair/blob/main/Final%20Presentation.pptx) from my presentation for the database.   


