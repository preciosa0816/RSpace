##Ch15_모델의 성능평가 

#모델 선택(Model Selection) : 여러모델의 성능을 평가하고 좋은 모델을 선택 
# 완벽한 모델 X: 1)현실의 불확실성 존재
#                2)데이터의 불완전성
#불완전성을 보완 : 엄정한 모델 성능평가기준마련
#여러모델을 성능평가하여 일정수준이상이 되면 현장에 투입 (설치)

###1.정확률(Accuracy)
#:성능평가 기준으로 가장 널리 사용
#: 반대는 오류율(error rate)
#(예) 150개 샘플, 102개를 맞추고 48개를 틀린경우
# ->정확률:102/150:약85%, 오류율: 48/150=약15% 
#기각(reject):AI판단을 하기 위한 것이 아니고, 전문가에게 판정을 미룸
#             정확률(54%)라면->참조

#iris-Decision Tree, randomForest를 적용해서 정확률측정
library(rpart)
library(randomForest)
libcurlVersion(caret)
library(caret)

r=rpart(Species~.,data=iris)
f=randomForest(Species~.,data=iris)
r_pred=predict(r,iris, type="class")
confusionMatrix(r_pred,iris$Species)
#decision Tree 결과 = (50+49+45)/150=96%
#Decision tree 오류율= 4%

f_fred=predict(f,iris,type="class")
confusionMatrix(f_fred,iris$Species)
#randomFores 결과 = 100%
#randomFores 오류율= 0%

##=>둘중에서 randomForest를 선택 ]

####2.일반화(Generalization) 능력 측정
#: 학습할 떄 사용하지 않았던 새로운 샘플에 대해 높은 성능을 가지는 성질
#: 학습할 떄 98%정확률을 보이고 현장에서 97%
#:반면에 현장 65% 정확률ㅇ르 보인다면 일반화능력이 낮다. 
  #문제해결방법:Training set(훈련집합)&Test set(테스트집합) 분리해서 사용 
#Training Set : 모델만들기
#Test set: 모델을 적용해서 예측에 사용 
iris

#iris를 사용한 Train set& Test set나누기 
n=nrow(iris)
i=1:n
train_list=sample(i,n*0.6) #60%를 randome 하게 샘플링
test_list=setdiff(i,train_list) #나머지 40% #serdiff():집합의 차이
iris_train=iris[train_list,] #훈련집합 추출
iris_test=iris[test_list,] #테스트집합추출

f=randomForest(Species~.,data=iris_train) #훈련집합으로 randomForest를 학습
p=predict(f,newdata = iris_test) #예측(일반화 능력평가 )

p

iris_test$Species
#정확률::59/60 =>98.33% =>"일반화 능력이 우수하다."

##caret library를 사용한 훈련집합과 테스트집합
#:train()를 통해서 여러가지 regression&Classification 평가내용 지원
library(caret)
train_list=createDataPartition(y=iris$Species,p=0.6, list=FALSE)#60%확률 
iris_train=iris[train_list,]
iris_test=iris[-train_list,]

f=randomForest(Species~.,data=iris_train)
p=predict(f,newdata = iris_test)

p
iris_test$Species

####3. Corss Validation(cv:교차 검증)















































































































































































































































