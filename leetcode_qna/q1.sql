/*175. Combine Two Tables
Write a solution to report the first name, last name, city, and 
state of each person in the Person table. 
If the address of a personId is not present in the Address table, report null instead.
Return the result table in any order.
Question Link: https://leetcode.com/problems/combine-two-tables/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
SELECT
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM
    Person p
LEFT JOIN
    Address a
ON
    p.personID = a.personID

/*Output:
| firstName | lastName | city          | state    |
| --------- | -------- | ------------- | -------- |
| Allen     | Wang     | null          | null     |
| Bob       | Alice    | New York City | New York |
*/