import numpy as np

# 1)ARRAY CREATION USING ARRAY() FUNCTION
# array creation
# zero dim
a=np.array(7)
print(a)

# 1-d
# list is a comma seperated values,whereas array is space seperated
# collection of 0d elements
a=np.array([1,2,3])
print(a)

# 2-d
# collection of 1d elements
a=np.array([[1,2],[3,4]])
print(a)
# gives ndarray as type
print(type(a)) 
# ndim for defining number of dimensions

# 2)ARRAY CREATION USING ASSARRAY() FUNCTION AND NDITER()

a=[1,2,3]
# asarray has 3 arguments input,datatype,order(r,c)
b=np.asarray(a,dtype=float)
# row major order,column major order
a=[[10,20],[30,40]]
# normal
b=np.asarray(a,dtype=float,order="F")
#c-row major ,f-column major 
for i in np.nditer(b):
    print(i)


# 3)ARRAY CREATION USING FROMBUFFER()
# when we take strings ,then we place them in buffer and consider
a=b"checking"
# input,dtype-S1,count,offset
ans=np.frombuffer(a,dtype="S1",count=1)

print(ans)

# 4) ARRAY CREATION USING FROMITER()
# seq to arrray formation
a=[10,20,30,40]
ans=np.fromiter(a,dtype=float,count=3)
print(ans)