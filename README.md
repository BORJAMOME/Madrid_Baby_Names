# Análisis de los nombres de bebé en la Comunidad de Madrid (2022)
[![SQL](https://img.shields.io/badge/MySQL-8.0+-f29221?style=for-the-badge&logo=mysql&logoColor=white&labelColor=101010)](https://mysql.com)

Este repositorio contiene consultas SQL diseñadas para analizar un archivo CSV con datos sobre los nombres de bebé registrados en la Comunidad de Madrid durante el año 2022.

La fuente de los datos es el Instituto de Estadística de la Comunidad de Madrid.

## Archivos incluidos
- **baby_names_madrid_2022.csv**: Archivo CSV con datos sobre nombres de bebé nacidos en la Comunidad de Madrid en 2022.
- **queries.sql**: Consultas SQL para analizar los datos de nombres de bebés.

## Consultas en SQL
1. **Obtener el total de nombres únicos por año**: Esta consulta calcula cuántos nombres distintos se registraron en cada año.
```sql
SELECT year, COUNT(DISTINCT name) AS unique_names
FROM baby_names
GROUP BY year;
```
![Screenshot 2024-05-07 at 15 44 42](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6377bbb9-3117-4122-aba3-4faf236f1253)

2. **Calcular la popularidad promedio de los nombres por género**: Esta consulta calcula la popularidad promedio de los nombres según el género.
 ```sql
SELECT gender, AVG(num) AS avg_popularity
FROM baby_names
GROUP BY gender;
```
![Screenshot 2024-05-07 at 15 47 25](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/74e8143e-407b-464f-8600-3c554ff62730)

3. **Seleccionar los primeros nombres y el total de bebés con ese nombre, ordenados por el total de bebés en orden descendente**: Esta consulta selecciona los primeros nombres y el total de bebés con cada nombre, ordenándolos de acuerdo con el total de bebés de forma descendente.
```sql
SELECT name, SUM(num)
    FROM baby_names
    GROUP BY name
    ORDER BY SUM(num) DESC;
```
![Screenshot 2024-05-07 at 15 47 51](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/74294122-810d-45be-aba6-9106dfd7cb7f)

4. **Seleccionar el total de bebés por género y ordenarlos por el total de bebés de ese género, de forma descendente**: Esta consulta selecciona el total de bebés por género y los ordena según el total de bebés de cada género, en orden descendente.
```sql
SELECT gender, SUM(num)
    FROM baby_names
    GROUP BY gender
    ORDER BY SUM(num) DESC;
```
![Screenshot 2024-05-07 at 15 48 10](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/4a3589eb-40b8-4326-abc4-fb33ddb5306d)

5. **Clasificar los nombres por popularidad**: Esta consulta clasifica los nombres según su popularidad en categorías como 'Very Popular', 'Popular', 'Moderately Popular', 'Not Very Popular', 'Rarely Used', y 'No Data'.
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

6. **Seleccionar los 10 nombres principales por género**: Esta consulta selecciona los 10 nombres más frecuentes por género de la tabla 'baby_names', ordenándolos según su número asociado en orden descendente.
```sql
SELECT gender, name, num
FROM baby_names
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 49 26](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/cd2667c0-ff04-4bf8-81da-ccd50d96138f)

7. **Seleccionar los 10 principales nombres masculinos**: Esta consulta selecciona los 10 nombres masculinos más frecuentes de la tabla 'baby_names', ordenándolos por su número asociado en orden descendente.
```sql
SELECT name, num
FROM baby_names
WHERE gender = 'M'
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 49 55](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/f7858a37-be1c-4d3e-92b2-fb2033e96c85)

8. **Seleccionar los 10 principales nombres femeninos**: Esta consulta selecciona los 10 nombres femeninos más frecuentes de la tabla 'baby_names', ordenándolos por su número asociado en orden descendente.
```sql
SELECT name, num
FROM baby_names
WHERE gender = 'F'
ORDER BY num DESC
LIMIT 10;
```
![Screenshot 2024-05-07 at 15 50 12](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/f39a906f-0902-426c-be78-c2ac94728e38)

9. **Contabilizar el número total de nombres compuestos por una sola palabra en comparación con los compuestos por dos palabras**: Esta consulta calcula el número total de nombres que están compuestos por una sola palabra y los que están compuestos por dos palabras.
```sql
SELECT 
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 0 THEN 1 ELSE 0 END) AS single_word_names,
    SUM(CASE WHEN LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0 THEN 1 ELSE 0 END) AS compound_names
FROM baby_names;
```
![Screenshot 2024-05-07 at 15 50 32](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6522253e-ca92-4241-837e-5f43cf0e56dd)

10. **Seleccionar la primera letra de cada nombre y contar cuántos nombres comienzan con esa letra**: Esta consulta selecciona la primera letra de cada nombre y cuenta cuántos nombres comienzan con esa letra.
```sql
SELECT 
    SUBSTRING(name, 1, 1) AS first_letter,
    COUNT(*) AS total_names
FROM baby_names
GROUP BY SUBSTRING(name, 1, 1)
ORDER BY first_letter;
```
![Screenshot 2024-05-07 at 15 50 53](https://github.com/BORJAMOME/Madrid_Baby_Names/assets/19588053/6df7153a-9cba-46e9-99d3-61addc4e023e)

11. **Calcular la probabilidad de que un nombre comience con una determinada letra**: Esta consulta calcula la probabilidad de que un nombre comience con una determinada letra.

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

12. **Seleccionar la última letra de cada nombre y contar cuántos nombres terminan con esa letra**: Esta consulta selecciona la última letra de cada nombre y cuenta cuántos nombres terminan con esa letra.

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

13. **Calcular la probabilidad de que un nombre termine con una letra determinada**: Esta consulta calcula la probabilidad de que un nombre termine con una letra específica.
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

14. **Calcular cuál es el nombre con más letras**: Esta consulta calcula cuál es el nombre que tiene más letras.
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

15. **Calcular cuál es el nombre con menos letras**: Esta consulta calcula cuál es el nombre que tiene menos letras.
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

16. **Basado en el número promedio de letras en cada nombre, calcular la probabilidad de que un nombre tenga X número de letras**: Esta consulta calcula la probabilidad de que un nombre tenga una cantidad específica de letras, basándose en el número promedio de letras de todos los nombres.
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

17. **¿Cuál es la probabilidad de tener un nombre u otro siendo hombre y nacido en 2022?**: Esta consulta calcula la probabilidad de que, siendo hombre y nacido en 2022, se tenga un nombre específico o algún otro.
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

18. **¿Cuál es la probabilidad de tener un nombre u otro siendo mujer y nacida en 2022?**: Esta consulta calcula la probabilidad de que, siendo mujer y nacida en 2022, se tenga un nombre específico o algún otro.
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

