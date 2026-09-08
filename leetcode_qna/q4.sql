/*183. Customers Who Never Order
Write a solution to find all customers who never order anything.
Return the result table in any order.
Question Link: https://leetcode.com/problems/customers-who-never-order/description/?envType=problem-list-v2&envId=v2abvuzj */

#Query:
SELECT name as Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders)

/*Output:
| Customers |
| --------- |
| Henry     |
| Max       |
*/