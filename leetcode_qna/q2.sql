/*181. Employees Earning More Than Their Managers
Write a solution to find the employees who earn more than their managers.
Return the result table in any order.
Question Link: https://leetcode.com/problems/employees-earning-more-than-their-managers/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
SELECT
    e1.name as Employee
FROM
    Employee e1
LEFT JOIN   
    Employee e2
ON
    e1.managerID = e2.id
WHERE
    e1.salary > e2.salary;
    

/*Output:
| Employee |
| -------- |
| Joe      |
*/