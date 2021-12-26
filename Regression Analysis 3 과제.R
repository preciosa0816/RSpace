
##########Regression Analysis 3
#1. 훈련집합으로 지금까지 전체과정 통해서 예측하기

x=c(3.0,6.0,3.0,6.0,7.5,7.5,15.0) #설명변수
u=c(10.0,10.0,20.0,20.0,5.0,10.0,12.0)
y=c(4.65,5.9,6.7,8.02,7.7,8.1,6.1) 

scatterplot3d(x,u,y,xlim=0:20,ylim =3:22, zlim = 4:10, pch = 20, type = 'h', angle = 30 )

m=lm(y~x+u)
coef(m)

#y=0.4x+0.2u

s=scatterplot3d(x,u,y,xlim=0:20,ylim =3:22, zlim = 4:10, pch = 20, type = 'h', angle = 30 )
s$plane3d(m) #적합도
fitted(m)  #잔차
residuals(m)#잔차의 제곱합
deviance(m)/length(x) #평균제곱오차 


#2. y=2.3x**2-1.6u+10.5 함수를 scatterplot3d로 그리기 
library(scatterplot3d)
library(matlab)
x=seq(-30,30,5)
u=seq(-30,30,5)
m=meshgrid(x,u) #x,u is renamed x,y
xx=as.vector(m$x)
uu=as.vector(m$y)#as:형변환

y = 2.3*xx^2-1.6*uu+10.5
yy=as.vector(y)
s=scatterplot3d(xx,uu,yy,xlim=-30:30,ylim=-30:30,zlim=-300:3000,pch=20,type='h')
scatterplot3d(x, u, y)


