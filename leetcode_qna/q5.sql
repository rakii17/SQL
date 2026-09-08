/*196. Delete Duplicate Emails
Write a solution to delete all duplicate emails, 
keeping only one unique email with the smallest id.
For SQL users, please note that you are supposed to 
write a DELETE statement and not a SELECT one.
Question Link: https://leetcode.com/problems/delete-duplicate-emails/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
DELETE p1.*
FROM Person p1
JOIN person p2
ON p1.email = p2.email
WHERE p1.id > p2.id

/*Output:
| id | email            |
| -- | ---------------- |
| 1  | john@example.com |
| 2  | bob@example.com  |
*/