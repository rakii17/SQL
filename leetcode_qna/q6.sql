/*197. Rising Temperature
Write a solution to find all dates' id with 
higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.
Question Link: https://leetcode.com/problems/rising-temperature/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
SELECT w1.id
FROM Weather w1
JOIN Weather w2
    ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;

/*Output:
| id |
| -- |
| 2  |
| 4  |
*/