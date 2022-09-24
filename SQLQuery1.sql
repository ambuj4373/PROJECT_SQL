
----CHECKING DATA 
USE zomato_eda
GO
SELECT *
FROM zomato_data




--CHECK IF THERE IS ANY NULL VALUE IN THE TABLE

SELECT *
FROM zomato_data

WHERE Cuisines IS NULL


--ADDING ANOTHER TABLE

SELECT *
FROM zomato_country

--MERGINNG BOTH THE TABLES- THIS WILL HELP US TO UNDERSTAND THR DATA COUNTRY-WISE USING PRIMARY KEY OF ZOMATO_DATA (Country Code) WHICH IS FOREIGN KEY IN TABLE (country_code)

SELECT *
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]


--LIST OF COUNTRIES THE SURVEY HOLDS -- THIS SHOWS ZOMATO IS AN INTERNATONAL COMPANY HOLDONG ITS EMPIRE IN SEVERAL COUNTRIES

SELECT DISTINCT (Country)
FROM zomato_data, zomato_country ---Survey contains 15 Countries


--LET US CHECK NUMBER OF REGISTERED RESTUARANTS IN INDIA

SELECT  COUNT (Country) AS total_restaurants_india
FROM zomato_data, zomato_country
WHERE Country = 'India'



--CHECKING MOST NON-RATED RESTSAURANTS ACROSS GLOBE 


SELECT  (Country), (Latitude), (Longitude)
FROM zomato_data, zomato_country
WHERE [Rating text] = 'Not rated'
ORDER BY 1

--CHECKING EXCELLENT RATED RESTSAURANTS ACROSS GLOBE WITH MORE THAN 500 VOTES

SELECT  (Country), (Latitude), (Longitude)
FROM zomato_data, zomato_country
WHERE [Rating text] = 'Excellent' AND Votes >=500
ORDER BY 1

--CURRENCY AND COUNTRY

SELECT (Currency), (Country)
FROM zomato_data,  zomato_country


--ONLINE DELIVERY DISTRIBUTION


SELECT Country, Longitude, Latitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Has Online delivery] = 'Yes' AND Country = 'India'


--LETS CHECK COVERAGE OF THE CITY IN INDIA	

SELECT City, Longitude, Latitude
FROM zomato_data Z1 INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE Country = 'India'
ORDER BY City


--NOW TRYING TO FIND ANSWERS TO SOME QUESTIONS RESTAURANTS LOCATED IN DELHI

--QUE 1/THE LOCALITY IN NEW DELHI HAVING MOST NUMBER OF RESTAURANTS?

SELECT Locality, [Aggregate rating]
FROM zomato_data Z1 INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE City = 'New Delhi'
ORDER BY 1


--QUE 2/ What kind of Cuisine do these highly-rated (aggregate rating > 3.8 & Votes => 100 restaurants offer in New Delhi Locality

SELECT DISTINCT (Cuisines), (Locality)
FROM zomato_data Z1 INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Aggregate rating] > 3 AND Votes >=100 AND Cuisines IS NOT NULL AND City = 'New Delhi'
ORDER BY 1

--Q3: How many of such restaurants accept online delivery in these locality


SELECT Locality AS Online_Delivery_Available, [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Has Online delivery] = 'Yes' AND City = 'New Delhi' 



--Q4: How many of such restaurants do not accept online delivery in these locality

SELECT Locality AS Online_Delivery_Not_Available, [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Has Online delivery] = 'No' AND City = 'New Delhi'



--Q5: Understanding the Restaurants Excellent, Average, Very Good, Poor, Good, Not Rated Rating localities.

SELECT (Locality),[Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Rating text] = 'Excellent' AND City = 'New Delhi'
ORDER BY 1


SELECT (Locality), [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE [Rating text] = 'Very Good' AND City = 'New Delhi'
ORDER BY 1

SELECT (Locality), [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Rating text] = 'Good' AND City = 'New Delhi'
ORDER BY 1

SELECT (Locality), [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Rating text] = 'Average' AND City = 'New Delhi'
ORDER BY 1

SELECT (Locality), [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Rating text] = 'Poor' AND City = 'New Delhi'
ORDER BY 1

SELECT (Locality), [Restaurant Name], Latitude, Longitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE [Rating text] = 'Not Rated' AND City = 'New Delhi'
ORDER BY 1



--Q6: Rating VS Cost of dinning in New Delhi

SELECT [Average Cost for two], [Aggregate rating]
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code]
WHERE City = 'New Delhi'
ORDER BY 1




--Q7: Location of Highly rated restaurants across New Delhi

SELECT Locality, Longitude, Latitude
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE [Rating text] = 'Very Good' OR [Rating text] = 'Good' OR [Rating text] =' Excellent' AND City = 'New Delhi'
ORDER BY 1


--QUE 8 Common Eateries 

--[Breakfast And Coffee Restaurants]

SELECT [Restaurant Name], [Aggregate rating], Cuisines
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE City = 'New Delhi' AND Cuisines LIKE '%Cafe%' AND Votes > 500


--[Fast Food Restaurants]

SELECT [Restaurant Name], [Aggregate rating], Cuisines
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE City = 'New Delhi' AND Cuisines LIKE '%Fast Food%' AND Votes > 500
ORDER BY [Aggregate rating] DESC


--[: Ice Cream Parlors / Desert Parlour]

SELECT [Restaurant Name], [Aggregate rating], Cuisines
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE City = 'New Delhi' AND Cuisines LIKE '%Ice Cream%' OR Cuisines LIKE '%Desert%' AND Votes > 250
ORDER BY [Aggregate rating] DESC


--[Best Mediterranean, Tibetan, Thai, Italian Restaurants]

SELECT [Restaurant Name], [Aggregate rating], Cuisines
FROM zomato_data Z1
INNER JOIN zomato_country C2
ON Z1.[Country Code] = C2.[Country Code] 
WHERE City = 'New Delhi' AND Cuisines LIKE '%Italian%' OR Cuisines LIKE '%Mediterranean%' OR Cuisines LIKE '%Thai%' OR Cuisines LIKE '%Tibetan%' AND Votes > 500
ORDER BY [Aggregate rating] DESC


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


