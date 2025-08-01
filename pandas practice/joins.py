import pandas as pd

# employees dataframe
employees=pd.DataFrame({
    'emp_id':[1,2,3,4],
    'name':['Alice', 'Bob', 'Charlie', 'David'],
    'dept_id':[101, 102, 103, None]
})


departments=pd.DataFrame({
    'dept_id':[101,102,104],
    'dept_name':['HR', 'Finance', 'Marketing']
})

print(employees)
print('--------------')

print(departments)

print('--------------')
# inner join
inner_join=pd.merge(employees,departments,how='inner',on='dept_id')

print("\nInner Join:")
print(inner_join)
print('--------------')

left_join=pd.merge(employees,departments,on='dept_id',how='left')
print("\nLeft Join:")
print(left_join)

