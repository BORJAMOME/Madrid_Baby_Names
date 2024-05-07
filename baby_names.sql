-- Create database called names
CREATE database names;

-- Create database called baby_names
CREATE TABLE baby_names (
  year INT,
  name VARCHAR(64),
  gender VARCHAR(64),
  num INT
);

-- Get the total of unique names per year
SELECT year, COUNT(DISTINCT name) AS unique_names
FROM baby_names
GROUP BY year;

-- Calculate the average popularity of names by gender. 
SELECT gender, AVG(num) AS avg_popularity
FROM baby_names
GROUP BY gender;

-- Select first names and the total babies with that name and order by the total number of babies with that name, descending
SELECT name, SUM(num)
    FROM baby_names
    GROUP BY name
    ORDER BY SUM(num) DESC;

-- Select total babies by gender and order by the total number of babies with that gender, descending
SELECT gender, SUM(num)
    FROM baby_names
    GROUP BY gender
    ORDER BY SUM(num) DESC;

-- Classify names by popularity 'Very Popular', 'Popular', 'Moderately Popular', 'Not Very Popular', 'Rarely Used' and 'No Data'
-- Alias this column as popularity_type
-- Select name and num for baby_names
-- Order the results alphabetically by name
SELECT name, num, 
    CASE WHEN num > 600 then 'Very Popular'
		 WHEN num > 300 then 'Popular'
         WHEN num > 100 then 'Moderately Popular'
         WHEN num > 50 then 'Not Very Popular'
         WHEN num > 1 then 'Rarely Used'
         else 'No data' end as popularity_type
	FROM baby_names;

-- Select the top 10 names by gender from the 'baby_names' table.
-- Ordering them by their associated number in descending order.
SELECT gender, name, num
FROM baby_names
ORDER BY num DESC
LIMIT 10;

-- Select the top 10 male's names from the 'baby_names' table.
-- Ordering them by their associated number in descending order.
SELECT name, num
FROM baby_names
WHERE gender = 'M'
ORDER BY num DESC
LIMIT 10;

-- Select the top 10 female's names from the 'baby_names' table.
-- Ordering them by their associated number in descending order.
SELECT name, num
FROM baby_names
WHERE gender = 'F'
ORDER BY num DESC
LIMIT 10;

-- Tally the total number of names composed of a single word compared to those composed of two words.
SELECT 
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 0 THEN 1 ELSE 0 END) AS single_word_names,
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0 THEN 1 ELSE 0 END) AS compound_names
FROM baby_names;

-- Select the first letter of each name and count how many names start with that letter.
SELECT 
    SUBSTRING(name, 1, 1) AS first_letter,
    COUNT(*) AS total_names
FROM baby_names
GROUP BY SUBSTRING(name, 1, 1)
ORDER BY first_letter;

-- Calculate the probability that a name starts with a certain letter.
SELECT 
    LEFT(name, 1) AS first_letter,
    COUNT(*) AS name_count,
    COUNT(*) / (SELECT COUNT(*) FROM baby_names) AS probability
FROM 
    baby_names
GROUP BY 
    first_letter
ORDER BY 
    first_letter;

-- Select the last letter of each name and count how many names ends with that letter.
SELECT 
    RIGHT(name, 1) AS last_letter,
    COUNT(*) AS name_count
FROM 
    baby_names
GROUP BY 
    last_letter
ORDER BY 
    last_letter;

-- Calculate the probability that a name ends with a certain letter.
SELECT 
    last_letter,
    COUNT(*) AS name_count,
    COUNT(*) / (SELECT COUNT(*) FROM baby_names) AS probability
FROM 
    (SELECT RIGHT(name, 1) AS last_letter FROM baby_names) AS last_letters
GROUP BY 
    last_letter
ORDER BY 
    last_letter;

-- Calculate which name has the most letters.
SELECT 
    name,
    LENGTH(name) AS letter_count
FROM 
    baby_names
ORDER BY 
    letter_count DESC
LIMIT 1;

-- Calculate which name has the less letters.
SELECT 
    name,
    LENGTH(name) AS letter_count
FROM 
    baby_names
ORDER BY 
    letter_count ASC
LIMIT 1;

-- Based on the average number of letters in each name, calculate the probability that a name has X number of letters.
SELECT 
    letter_count,
    COUNT(*) AS name_count,
    COUNT(*) / (SELECT COUNT(*) FROM baby_names) AS probability
FROM 
    (SELECT LENGTH(name) AS letter_count FROM baby_names) AS letter_counts
GROUP BY 
    letter_count
ORDER BY 
    letter_count;

-- What is the probability that, being male and born in 2022, I have one name or another?
SELECT 
    name,
    SUM(num) AS total_name_count,
    CONCAT(FORMAT((SUM(num) / (SELECT SUM(num) FROM baby_names WHERE gender = 'M')) * 100, 2), '%') AS probability
FROM 
    baby_names
WHERE 
    gender = 'M'
GROUP BY 
    name;

-- What is the probability that, being female and born in 2022, I have one name or another?
SELECT 
    name,
    SUM(num) AS total_name_count,
    CONCAT(FORMAT((SUM(num) / (SELECT SUM(num) FROM baby_names WHERE gender = 'M')) * 100, 2), '%') AS probability
FROM 
    baby_names
WHERE 
    gender = 'F'
GROUP BY 
    name;
