/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the additional project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			

-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CRIME
-- [Q1] Which was the most frequent crime committed each week? 
-- Hint: Use a subquery and the windows function to find out the number of crimes reported each week and assign a rank. 
Then find the highest crime committed each week

Note: For reference, refer to question number 3 - mls_week-2_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery and windows function from this question */



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, total officers and cases reported in each precinct code and check the trend*/



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q3] At what points of the day is the crime rate at its peak? Group this by the type of crime.
-- Hint: 
time day parts
[1] 00:00 to 05:00 = Midnight, 
[2] 05:01 to 12:00 = Morning, 
[3] 12:01 to 18:00 = Afternoon,
[4] 18:01 to 21:00 = Evening, 
[5] 21:00 to 24:00 = Night

Use a subquery, windows function to find the number of crimes reported each week and assign the rank.
Then find out at what points of the day the crime rate is at its peak.
 
 Note: For reference, refer to question number 3 - mls_week-2_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery, windows function from this question */
      


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q4] At what point in the day do more crimes occur in a different locality?
-- Hint: 
time day parts
[1] 00:00 to 05:00 = Midnight, 
[2] 05:01 to 12:00 = Morning, 
[3] 12:01 to 18:00 = Afternoon,
[4] 18:01 to 21:00 = Evening, 
[5] 21:00 to 24:00 = Night

Use a subquery and the windows function to find the number of crimes reported in each area and assign the rank.
Then find out at what point in the day more crimes occur in a different locality.
 
 Note: For reference, refer to question number 3 - mls_week-2_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery, windows function from this question */



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?
-- Hint: Age 0 to 12 kids, 13 to 23 teenage, 24 to 35 Middle age, 36 to 55 Adults, 56 to 120 old.*/


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.
-- Hint: Count the number of crimes for different case statuses. */


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
-- Hint: Check if there is a correlation between the number of CCTVs in each area and the crime rate.*/
	
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
-- Hint: Use the case when function, add separately when cctv_flag is true and false and check whether in particular area how many cctv is there,
How much CCTV footage is available? How much CCTV footage is not available? */


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q9] Is crime more likely to be committed by relation of victims than strangers?
-- Hint: Find the distinct crime type along with the count of crime when the offender is related to the victim.*/


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
-- Hint: Find the complaint type along with the count of crime.*/


-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



