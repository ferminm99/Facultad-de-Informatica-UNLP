X,Y = map(int,input().split())
Item = {1:4.0,2:4.5,3:5.0,4:2.0,5:1.5}
X = float(Item[X])*Y
print("Total: R$ %.2f"%X)