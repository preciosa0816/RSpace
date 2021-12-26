#####Ch14.Classification(분류)을 위한  Model

####1. Regression & Classfication
#logistic Regression 반응변수 : 0/1,사망/생존

#병원: 환자(2),정상인(0),관찰대상(1)
#통신사: 3(충성도높은사람),2(충성),1(보통),0(불평)

#반응변수(y): 연속형타입- 선형 Regression
#             이산형타입- Classfication

#classification 문제해결을 위한 알고리즘:
#      Desision Tree, Random Forest, K-NN, SVM(Super Vector Machine),Neural Network, Deep Learning
#회귀- 판매량에 따른 월급 : 반응변수(월급:정수)
#회귀- cars(속도에 따른 제동거리) : 반응변수(제동거리:실수)
#회귀- trees(나무의 직경과 키에 따른 목재 부피): 반응변수(목재부피:실수)
#분류 - UCLA addmission(대학원입시데이터): 합격/불합격(0,1) 
#               :logistic Regression기법  을 통해서- binary classfication(이진분류)
#분류-iris(붓꽃데이터): 반응변수(품종:setosa,versicolor,virginca)


#####3. Decision Tree
#기계학습 중 하나로 특정 항목에 대한 의사 결정 규칙 (Decision rule)을 나무 형태로 분류해 나가는 분석 기법.
#(예) 타이타닉 호 탑승자의 성별, 나이, 자녀의 수를 이용해서 생존 확률

#Decision Tree Packages:  tree,  rpart, party
iris
View(iris)
plot(iris)
str(iris)
table(is.na(iris$Species))
table(iris$Species)#iris$Species 종류별 갯수 

#Sepal (꽂받침), Petal(꽂잎)

#par(): 그래픽장치의 설정을 정의하는데 이용할 수 있는 함수로 여러 가지 그래픽인수는 그래픽의 속성을 정의하는 할 수 있으며, 이들 인수를 이용하여 화면의 분할 방법, 글자의 크기, 색상 등을 설정하여 그래픽환경을 다양하게 조정

library(rpart)
r=rpart(Species~., data = iris) ##rpart: 트리객체생성
print(r)
par(mfrow=c(1,1),xpd=NA) 
##mfow:한장에 여러개(c(n:m)n행m열) 그래프 나열 
##xpd: F:plot region 내부에 그림출력, T:figure region 내부에 그림출력, Na:그림이 클 경우 그래픽 장치 내부에 그림 출력  =>여백확보 
plot(r) ##트리객체 시각화
text(r,use.n = TRUE) ###트리 노드 시각화 (글자)


#학습을 마친 Decison Tree가지고 훈련집합에 대해 예측
p=predict(r,iris,type = 'class') #type='prob는 default
table(p, iris$Species)

#confusion matrix(혼동행렬)::부류별로 옳은분류 잘못된 분류를 나열한 행렬

#사전확률(prior probability):붓꽂의 실제 존재비율 10  :10   :80 가정
#기본정확률                 :                     33.3:33.3:33.3
r_prior=rpart(Species~., data = iris,parms =list(prior=c(0.1,0.1,0.8)) )
plot(r_prior)
text(r_prior,use.n = TRUE)


#Decision Tree 예측하기
#샘플을 조금 수정해서 사용하기
#setosa: 1
#versicolor:51
#virginca:101 약간수정해서 사용하기

newd = data.frame(Sepal.Length=c(5.11, 7.01, 6.32),
                  Sepal.Width= c(3.51, 3.2, 3.31),
                  Petal.Length=c(1.4, 4.71, 6.02),
                  Petal.Width= c(0.19, 1.4, 2.49))
print(newd)

predict(r,newdata = newd)
#####################################################
summary(r)
#Variable importance : 설명변수의 중요도

#Decision Tree 시각화
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(r)
rpart.plot(r, type=4)

#Decision Tree 장/단점 
#성능이 낮다.
#예측결과는 해석이 가능함 
#예측과정이 매우 빠르다. 
#결측값을 가진 샘플을 처리할수 있다. 
#범주형 변수를 그대로 사용 가능 
#여러개의 결정트리를 결합해서 사용가능
#Ensemble method : 여러개의 결정트리를 결합(예측기)하는 기법
#결정트리를 결합하는 앙상블기법은 random Forestn
#성능을 높이기 위해서 결정트리들을 결합을 해서 random Forest 형태로 사용 

####4. random Forest
library(randomForest)
str(iris)
f=randomForest(Species~., data=iris)
f

summary(f)
plot(f)
#varUsed(): RandomForest에 있는 결정트리가 설명변수를 질문에 사용한 횟수
#varImpPlot():
varUsed(f)
varImpPlot(f)

#treesize():leaf node
treesize(f)

#randomForest 예측
  #type=prob:확률
  #Type=vote :  

newd = data.frame(Sepal.Length=c(5.11,7.01,6.32),
                  Sepal.Width=c(3.51,3.2,3.31),
                  Petal.Length=c(1.4,4.71,6.02),
                  Petal.Width=c(0.19,1.4,2.49))

predict(f,newdata = newd)
predict(f,newdata = newd,type="prob") #확률
predict(f,newdata = newd, type="vote", norm.votes = FALSE) #투표

#repart type=vector/prob/class/matrix
#randomForest type=prov/vote/response(기본값)

#randomForest의 hyper Parameter
#: 결정트리갯수가 500개  =>줄이거나 늘리고 싶을 때:ntree
#: nodesize : leaf node(마지막 노드)에 도달한 샘플의 최소갯수 
small_forest=randomForest(Species~., data = iris, ntree=20, nodesize=6, maxnodes=12)
treesize(small_forest)
small_forest

#####5. SVM(support Vcetor Ml LAcoi0j)
#: 데이터를 나누는 최적의 경계를 만드는 방식 (2분류 : 이진분류기)
#: 2개이상으로 나누어진 집단을 분류하는데 사용되는 머신러닝 기법 
# 분류 알고리즘 중 가장 정확도가 높다/. 이상치의 영향도 적게 받음
#Support Vectors : 경계선에 가장 가까운 벡터
#margin : :데이터와 경계사이의 거리
#HyperPlane: Support Vector 와 Margin으 이용해서 그린선이 최적의 경계가 되며 이것을 HyperPlane이라고 한다.
#Kernel Trick : HyperPlane(다차원)=>3차원으로 차원을 낮춤
#:커널함수 - polynominal, radial basis(default), sigmoid, 
#R에서 지원하는 SVM라이브러리 : e1071, svmadmin,svmplus

library(e1071)
#kernel='radial basis'   : default
s=svm(Species~., data=iris) 
print(s)

table(predict(s,iris),iris$Species) #오차4/150

s=svm(Species~., data=iris, kernel='polynomial')
p=predict(s,iris)
table(p,iris$Species) #virginica에서만 오차7개 /150

#=>iris에는 radial basis를 사용하는 것이 오차가 적다.

#매개변수 cost : 여백의 크기와 잘못 분류하는 샘플의 수를 조정하는 매개변수 
#cost=100 : c를 크게하면 훈련집합에 대해서 오류율이 낮아지는 반면 일반화능력이 떨어짐 
#kernel='radial basis'   : default
s=svm(Species~., data=iris,cost=100)  
table(predict(s,iris),iris$Species)# 오차:2/150

#####6.K-NN (Nearest Neighbor):최근접
#SVM(2분류) =>K개 분류 
#:훈련집합에서 testSample과 가장 가까운 k개의 샘플을 찾은 다음에 발생빈도가 가장 높은 부류와 분류된다. 
#: 훈련집합에 있는 모든 샘플과 거리계산해야 하므로 훈련집합전체를 메모리에 저장: KNN 메모리 기반모델이라고 한다. 훈련집합이 크면 비효율적.
## K-NN는 class 패키지 사용 
install.packages(class)
library(class)
train=iris
str(iris)
test=data.frame(Sepal.Length=c(5.11,7.01,6.32),
                Sepal.Width=c(3.51,3.2,3.31),
                Petal.Length=c(1.4,4.71,6.02),
                Petal.Width=c(0.19,1.4,2.49))



k=knn(train[,1:4],test,train$Species,k=5)
k

#####7.train함수
#Decision Tree: rpart()
#Random Forest: randomForest()
#SVM          :svm()
#K-NN         :knn()

#=>일관성 유지: train함수로 통일.
install.packages(caret)
library(caret)

r=train(Species~.,data=iris, method='rpart')
r

f=train(Species~.,data=iris, method='rf')
f

s=train(Species~.,data=iris, method='svmRadial')
s

k=train(Species~.,data=iris, method='knn')
k

####8. 분류한 모델의 다양한 적용
####(예1) UCLA Addimision dataset
library(rpart)
library(rpart.plot)
library(randomForest)

ucla=read.csv("dataSet/binary.csv")
str(ucla)

#반응변수인 (admit)반드시 범주형으로 변환 ::rpart(), randomforest()
#범주형으로 설정하지 ㅏㅇㄴㅎ으면, regression으로 인식
ucla$admit=factor(ucla$admit)

##Decision Tree
r=rpart(admit~.,data=ucla)
par(mfrow=c(1,1), xpd=NA)#xpd\:그릴수있는 위치 제어
plot(r)
text(r, use.n=T)

p=predict(r,ucla,type='class')
table(p, ucla$admit)

#=>Decision Tree 결과: (249+54)/400=75.75%
#2)randomForest
f=randomForest(admit~., data=ucla) #OOB estimate of  error rate: 28%
print(f)
#=>randomForest결과: (258+30)/400 = 72%


####(예2) colon dataset
library(survival)
str(colon)
#결장암 환자에게 보조적인 화학요법으로 레바미졸을 처방하고 치료효과를 기록한 데이터 셋 
#status:재발/사망여부(0: 완치, 1: 재발/사망) 
#extent:암세포가 침투한 깊이:1~4
#node: 암세포가 있는 림프절의 수
clean_colon=na.omit(colon) #결측치 제거
clean_colon=clean_colon[c(TRUE,FALSE), ] #행에대해 홀수번째 값만 출력 
clean_colon$status=factor(clean_colon$status)#범주형으로 바꾸기
str(clean_colon)

#1)Decision Tree
r=rpart(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon)
r
plot(r)
text(r, use.n=TRUE)
p=predict(r, clean_colon, type = 'class') #class:분류
table(p,clean_colon$status) #(319+283)/888 = 67.8%
summary(r)

#2)randomForest
f=randomForest(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon) #OOB estimate of  error rate: 28%
print(f)
#=>randomForest결과: (305+265)/888 =64.19%

##(예3) voice Dataset
#:음성신호를 듣고 여성인지 남성인지 알아내는데 사용하는 데이터
#: 음성신호에서 추출한 20개의 특징(설명변수)
#: 반응변수(=label variable)= 여성 or 남성
voice=read.csv("dataSet/voice.csv")
str(voice)

#1)Decision Tree
r=rpart(label~., data=voice)
par(mfrow=c(1,1), xpd=NA) #행과열 출력하기
plot(r)
text(r, use.n=T)
p=predict(r,voice, type='class')
table(p, voice$label) #결과: (1551+1496)/3168=96.18%


#2)randomForest
f=randomForest(label~., data=voice) #OOB estimate of  error rate: 2.02%
print(f) #결과: (1555+1549)/3168=97.98%
































































