create database covid_test;

use covid_test;

 create table covid_data (
							Ind_Id INT, 
                            Test_date DATE, 
                            Cough_symptoms varchar(10), 
                            Fever varchar(20) ,
                            Sore_throat varchar(10), 
                            Shortness_of_breath varchar(10), 
                            Headache varchar(10), 
                            Corona varchar(10), 
                            Age_60_above varchar(10), 
                            Sex varchar(10), 
                            Known_contact varchar(30)
                            );


#Imported Data using Mysql Command line
 LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\covid_cleaned.csv" 
 INTO TABLE covid_data 
 FIELDS TERMINATED BY ',' 
 ENCLOSED BY '"' 
 LINES TERMINATED BY '\n' 
 IGNORE 1 ROWS;

select * from covid_data;


# Q.1 Find the number of corona patients who faced shortness of breath.

select count(Ind_Id) as NoOfPatients
from covid_data 
where Corona = "positive" 
and Shortness_of_breath = "TRUE";

/*
Conclusion :- There are 1162 corona patients who faced shortness of breath.
*/

# Q.2 Find the number of negative corona patients who have fever and sore_throat. 

select count(Ind_Id) as NoOfPatients
from covid_data 
where Corona = "negative" 
and Fever = "TRUE" 
and Sore_throat = "TRUE";

/*
Conclusion :- There are 121 corona negative patients who have fever and Sore throat.
*/

# Q.3 Group the data by month and rank the number of positive cases.

select monthname(Test_date) as Month,
count(Ind_Id) as positivecases, 
RANK() OVER(order by count(Ind_Id) DESC) AS 'rank'
from covid_data
where Corona = "positive"
group by monthname(Test_date);

/* 
Conclusion :- In April we found most number of corona positive cases(8863), And in march 5863 corona positive cases.
*/

# Q.4 Find the female negative corona patients who faced cough and headache.

select * from covid_data
where Sex = "female" 
and Corona = "negative" 
and Cough_symptoms = "TRUE" 
and Headache = "TRUE";

/*
Conclusion :- 32 female negative corona patients who faced cough and headache.
*/

# Q.5 How many elderly corona patients have faced breathing problems?

select count(*)
from covid_data
where Age_60_above = "Yes"
and Shortness_of_breath = "TRUE";

/* 
Conclusion :- 286 elderly corona patients have faced breathing problems.(In problem it's not mentioned corona positive or negative patients)
*/

# Q.6 Which three symptoms were more common among COVID positive patients?

select 
	(select count(*) from covid_data where Cough_symptoms = "TRUE" and corona = "positive") as Cough_count,
    (select count(*) from covid_data where Fever = "TRUE" and corona = "positive") as Fever_count,
    (select count(*) from covid_data where Sore_throat = "TRUE" and corona = "positive") as Sore_count,
    (select count(*) from covid_data where Shortness_of_breath = "TRUE" and corona = "positive") as shortBreath_count,
    (select count(*) from covid_data where Headache = "TRUE" and corona = "positive") as headache_count,
    (select count(*) from covid_data where corona = "positive") as positive_count
from covid_data
limit 1;

/* 
Conclusion :- Cough_Symptoms, Fever and Headache are the most common symptoms among Corona positive patients.
*/

# Q.7 Which symptom was less common among COVID negative people?

select 
	(select count(*) from covid_data where Cough_symptoms = "TRUE" and corona = "negative") as Cough_count,
    (select count(*) from covid_data where Fever = "TRUE" and corona = "negative") as Fever_count,
    (select count(*) from covid_data where Sore_throat = "TRUE" and corona = "negative") as Sore_count,
    (select count(*) from covid_data where Shortness_of_breath = "TRUE" and corona = "negative") as shortBreath_count,
    (select count(*) from covid_data where Headache = "TRUE" and corona = "negative") as headache_count,
    (select count(*) from covid_data where corona = "negative") as negative_count
from covid_data
limit 1;

/*
Conclusion :- Headache, Shortness of Breath, Sore throat symptom was less common among COVID negative people.
*/

# Q.8 What are the most common symptoms among COVID positive males whose known contact was abroad? 

select 
	(select count(*) from covid_data where Cough_symptoms = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Cough_count,
    (select count(*) from covid_data where Fever = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Fever_count,
    (select count(*) from covid_data where Sore_throat = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Sore_count,
    (select count(*) from covid_data where Shortness_of_breath = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as shortBreath_count,
    (select count(*) from covid_data where Headache = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as headache_count,
    (select count(*) from covid_data where corona = "positive"  and Known_contact like '%Abroad%') as positive_Abroad
from covid_data
limit 1;

/*
Conclusion :- Cough and Fever are the most common symptoms among COVID positive males whose known contact was abroad.
*/