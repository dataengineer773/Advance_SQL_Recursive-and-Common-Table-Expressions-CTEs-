# Retrieve employee hierarchy without using CONNECT BY clause
# In this question, the goal is to retrieve an employee hierarchy, displaying the relationships between employees and their managers.
# Concepts:
# Common Table Expressions (CTEs): A temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. Often used to write recursive 
# queries for hierarchical data.


# Solution:
# In PostgreSQL, you can use recursive CTEs to represent hierarchical data:


WITH RECURSIVE rcte AS
  (SELECT emp_id AS root_id,
          emp_id
   FROM test
   WHERE mgr_id IS NULL
   UNION ALL SELECT root_id,
                    t.emp_id
   FROM rcte r
   JOIN test t ON t.mgr_id = r.emp_id)
SELECT root_id AS emp_id,
       string_agg(cast(emp_id AS varchar), ',') AS emp_id_under_manager
FROM rcte
WHERE emp_id != root_id
GROUP BY root_id
ORDER BY root_id;