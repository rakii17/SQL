/*182. Duplicate Emails
Write a solution to report all the duplicate emails. 
Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.
Question Link: https://leetcode.com/problems/duplicate-emails/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
SELECT 
    email as Email
FROM 
    Person
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;

/*Output:
| Email   |
| ------- |
| a@b.com |
*/