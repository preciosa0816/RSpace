#Classfication _Ch14_assignment

#1. iris에는 4개의 설명변수가 있다. 이중 Petal.Length를 제외한 3개만 사용하여 Decision Tree 모델을 구하고 그림을 그려라. 또한 table 함수를 사용하여 혼동행렬을 구하라
library(rpart)
r=rpart(Species~Sepal.Length+Sepal.Width+Petal.Width, data = iris) ##rpart: 트리객체생성
print(r)
par(mfrow=c(1,1),xpd=NA) 

str(iris)
plot(r) ##트리객체 시각화
text(r,use.n = TRUE) ###트리 노드 시각화 (글자)

#2. iris의 사전확률이 setosa:versicolor:virginca= 10:80:10이라 가정하고 결정트리를 구하라. 지금까지 작성한 그림과 달라진것이 무엇인지 확인하기
r_prior=rpart(Species~., data = iris,parms =list(prior=c(0.1,0.8,0.1)) )
plot(r_prior)
text(r_prior,use.n = TRUE)

