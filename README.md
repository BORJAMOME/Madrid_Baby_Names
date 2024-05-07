# Analyzing baby names data from the Community of Madrid in 2022
[![SQL](https://img.shields.io/badge/MySQL-8.0+-f29221?style=for-the-badge&logo=mysql&logoColor=white&labelColor=101010)](https://mysql.com)

This repository contains SQL queries to analyze a CSV file containing data on baby names born in the Community of Madrid in 2022. The data is sourced from the Instituto de Estadística de la Comunidad de Madrid.

## Files Included
- **baby_names_madrid_2022.csv**: CSV file containing data on baby names born in the Community of Madrid in 2022.
- **queries.sql**: SQL queries for analyzing the baby names data.

## SQL Queries Included
1. **Get the total of unique names per year**: This query calculates the total number of unique names per year.
```sql
SELECT year, COUNT(DISTINCT name) AS unique_names
FROM baby_names
GROUP BY year;
```
![Screenshot 2024-05-07 at 15 44 42](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6377bbb9-3117-4122-aba3-4faf236f1253)

2. **Calculate the average popularity of names by gender**: This query calculates the average popularity of names by gender.
 ```sql
SELECT gender, AVG(num) AS avg_popularity
FROM baby_names
GROUP BY gender;
```
![Screenshot 2024-05-07 at 15 47 25](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/74e8143e-407b-464f-8600-3c554ff62730)

3. **Select first names and the total babies with that name and order by the total number of babies with that name, descending**: This query selects the first names and the total number of babies with each name, ordering them by the total number of babies in descending order.
```sql
SELECT name, SUM(num)
    FROM baby_names
    GROUP BY name
    ORDER BY SUM(num) DESC;
```
![Screenshot 2024-05-07 at 15 47 51](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/74294122-810d-45be-aba6-9106dfd7cb7f)

4. **Select total babies by gender and order by the total number of babies with that gender, descending**: This query selects the total number of babies by gender and orders them by the total number of babies in descending order.
```sql
SELECT gender, SUM(num)
    FROM baby_names
    GROUP BY gender
    ORDER BY SUM(num) DESC;
```
![Screenshot 2024-05-07 at 15 48 10](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/4a3589eb-40b8-4326-abc4-fb33ddb5306d)

5. **Classify names by popularity**: This query classifies names by popularity into categories such as 'Very Popular', 'Popular', 'Moderately Popular', 'Not Very Popular', 'Rarely Used', and 'No Data'.
```sql
SELECT name, num, 
    CASE WHEN num > 600 then 'Very Popular'
		 WHEN num > 300 then 'Popular'
         WHEN num > 100 then 'Moderately Popular'
         WHEN num > 50 then 'Not Very Popular'
         WHEN num > 1 then 'Rarely Used'
         else 'No data' end as popularity_type
	FROM baby_names;
```
![Screenshot 2024-05-07 at 15 49 07](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/961d140a-5425-4a05-bfb4-6f2abbd0b7ef)

6. **Select the top 10 names by gender**: This query selects the top 10 names by gender from the 'baby_names' table, ordering them by their associated number in descending order.
```sql
SELECT gender, name, num
FROM baby_names
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 49 26](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/cd2667c0-ff04-4bf8-81da-ccd50d96138f)

7. **Select the top 10 male names**: This query selects the top 10 male from the 'baby_names' table, ordering them by their associated number in descending order.
```sql
SELECT name, num
FROM baby_names
WHERE gender = 'M'
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 49 55](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/f7858a37-be1c-4d3e-92b2-fb2033e96c85)

8. **Select the top 10 female names**: This query selects the top 10 female from the 'baby_names' table, ordering them by their associated number in descending order.
```sql
SELECT name, num
FROM baby_names
WHERE gender = 'F'
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 50 12](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/f39a906f-0902-426c-be78-c2ac94728e38)

9. **Tally the total number of names composed of a single word compared to those composed of two words**: This query calculates the total number of names composed of a single word and those composed of two words.
```sql
SELECT 
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 0 THEN 1 ELSE 0 END) AS single_word_names,
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0 THEN 1 ELSE 0 END) AS compound_names
FROM baby_names;
```
![Screenshot 2024-05-07 at 15 50 32](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6522253e-ca92-4241-837e-5f43cf0e56dd)

10. **Select the first letter of each name and count how many names start with that letter**: This query selects the first letter of each name and counts how many names start with that letter.
```sql
SELECT 
    SUBSTRING(name, 1, 1) AS first_letter,
    COUNT(*) AS total_names
FROM baby_names
GROUP BY SUBSTRING(name, 1, 1)
ORDER BY first_letter;
```
![Screenshot 2024-05-07 at 15 50 53](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6df7153a-9cba-46e9-99d3-61addc4e023e)

11. **Calculate the probability that a name starts with a certain letter**: This query calculates the probability that a name starts with a certain letter.
```sql
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
```
![Screenshot 2024-05-07 at 15 51 18](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/2920610f-33bf-4507-a6eb-5c9a572bc715)

12. **Select the last letter of each name and count how many names end with that letter**: This query selects the last letter of each name and counts how many names end with that letter.
```sql
SELECT 
    RIGHT(name, 1) AS last_letter,
    COUNT(*) AS name_count
FROM 
    baby_names
GROUP BY 
    last_letter
ORDER BY 
    last_letter;
```
![Screenshot 2024-05-07 at 15 51 37](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/f37f73d1-8fbb-4b3b-9367-b75a7c6ae965)

13. **Calculate the probability that a name ends with a certain letter**: This query calculates the probability that a name ends with a certain letter.
```sql
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
```
![Screenshot 2024-05-07 at 15 52 18](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/fd4e174b-3b9c-4c3f-b3b2-c22c265d7dfe)

14. **Calculate which name has the most letters**: This query calculates which name has the most letters.
```sql
SELECT 
    name,
    LENGTH(name) AS letter_count
FROM 
    baby_names
ORDER BY 
    letter_count DESC
LIMIT 1;
```
![Screenshot 2024-05-07 at 15 52 40](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/0ccbef25-7292-4af9-8e84-249db5ec4dd9)

15. **Calculate which name has the fewest letters**: This query calculates which name has the fewest letters.
```sql
SELECT 
    name,
    LENGTH(name) AS letter_count
FROM 
    baby_names
ORDER BY 
    letter_count ASC
LIMIT 1;
```
![Screenshot 2024-05-07 at 15 53 30](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/74b78ff2-0d6d-4661-a91d-b68950043355)

16. **Based on the average number of letters in each name, calculate the probability that a name has X number of letters**: This query calculates the probability that a name has a certain number of letters based on the average number of letters in each name.
```sql
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
```
![Screenshot 2024-05-07 at 15 53 47](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/5d834a16-c934-4f57-81e5-39ab4d2cc505)

17. **What is the probability that being male and born in 2022, I have one name or another?**: This query calculates the probability that being male and born in 2022, one has one name or another.
```sql
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
```
![Screenshot 2024-05-07 at 15 54 08](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/45e2f156-e812-4930-b216-39e820e9d5b4)

18. **What is the probability that being female and born in 2022, I have one name or another?**: This query calculates the probability that being female and born in 2022, one has one name or another.
```sql
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
```
![Screenshot 2024-05-07 at 15 54 37](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/8ed218cc-1098-4ca0-93fe-2cd5165080ba)

