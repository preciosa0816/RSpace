##Classification_Models
## [문제1]kyphosis 데이터에 결정트리 , 랜덤 포리스트, K-NN,SVM모델을 적용하라 

library(rpart)
library(caret)
str(kyphosis) ## 4개변수 총 81개 데이터
View(kyphosis)
##1) Decision Tree Model
r=rpart(Kyphosis~.,data = kyphosis)
r
plot(r)
text(r, use.n=TRUE)
p=predict(r, kyphosis, type = 'class') #class:분류
table(p,kyphosis$Kyphosis) #(53+15)/81= 83.95%
summary(r)

r=train(Kyphosis~.,data = kyphosis, method='rpart')
r
##cp          Accuracy   Kappa    
#0.00000000  0.7692898  0.2546180
#0.01960784  0.7692898  0.2546180
#0.17647059  0.7647932  0.1332773


#2)randomForest
library(randomForest)
f=randomForest(Kyphosis~.,data = kyphosis) #OOB estimate of  error rate: 19.75%
print(f)
#=>randomForest결과: (60+5)/81=80.25%
f=train(Kyphosis~.,data = kyphosis, method='rf')
f

##  mtry  Accuracy   Kappa   
#    2   0.7760579  0.295424
#    3   0.7752566  0.304937


#3)K-NN
k=train(Kyphosis~.,data=kyphosis, method='knn')
k

##k  Accuracy   Kappa     
#5  0.7482613  0.11531912
#7  0.7596561  0.10010626
#9  0.7586708  0.05417263

#4)SVM모델
s=train(Kyphosis~.,data=kyphosis, method='svmRadial')
s
##  C     Accuracy   Kappa     
#0.25  0.7984418  0.02252021
#0.50  0.7955989  0.21308429
#1.00  0.7938338  0.28543080

s=svm(Kyphosis~.,data=kyphosis) 
print(s)

table(predict(s,kyphosis),kyphosis$Kyphosis) #오차9/81

s=svm(Kyphosis~.,data=kyphosis, kernel='polynomial')
p=predict(s,kyphosis)
table(p,kyphosis$Kyphosis) ## (63+4)/81=82.72% 


#[문제2] UCLA admission, colon, voice 데이터에 SVM적용하고, 결정트리 랜덤포레스트와 정확율 비교하기 
library(rpart)
library(rpart.plot)
library(randomForest)

ucla=read.csv("dataSet/binary.csv")
str(ucla)
ucla$admit=factor(ucla$admit)

##1)Decision Tree
r=rpart(admit~.,data=ucla)
par(mfrow=c(1,1), xpd=NA)#xpd\:그릴수있는 위치 제어
plot(r)
text(r, use.n=T)

p=predict(r,ucla,type='class')
table(p, ucla$admit)
#=>Decision Tree 결과: (249+54)/400=75.75%

r=train(admit~.,data=ucla, method='rpart')
r
##  cp          Accuracy   Kappa     
#0.01574803  0.6647001  0.16415408
#0.02362205  0.6639761  0.14125107
#0.06299213  0.6748594  0.08654938

#2)randomForest
f=randomForest(admit~., data=ucla) #OOB estimate of  error rate: 28%
print(f)
#=>randomForest결과: (258+30)/400 = 72%
f=train(admit~.,data=ucla, method='rf')
f
##  mtry  Accuracy   Kappa    
#    2   0.6643687  0.1749495
#    3   0.6528748  0.1574091

#3)SVM
s=train(admit~., data=ucla, method='svmRadial')
s
##  C     Accuracy   Kappa    
#0.25  0.6894604  0.0881083
#0.50  0.6977984  0.1384296
#1.00  0.7008783  0.1622329

s=svm(admit~., data=ucla) 
print(s)

table(predict(s,ucla),ucla$admit) #정확도:(264+24)/400=72%

s=svm(admit~., data=ucla, kernel='polynomial')
p=predict(s,ucla)
table(p,ucla$admit)#정확도:(267+11)/400=69.5%


#==>decision tree>randomforest>svm 순의 정확도 

########################################################
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

r=train(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon, method='rpart')
r
##  cp          Accuracy   Kappa    
#0.01162791  0.6128178  0.2242110
#0.01627907  0.6157106  0.2304532
#0.23023256  0.5796954  0.1511898

#2)randomForest
f=randomForest(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon) #OOB estimate of  error rate: 28%
print(f)
#=>randomForest결과: (305+265)/888 =64.19%

f=train(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon, method='rf')
f
##  mtry  Accuracy   Kappa    
#    2    0.6242682  0.2427166
#    7    0.5934262  0.1863519
#   12    0.5836187  0.1669308

#3)SVM
s=train(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon, method='svmRadial')
s
##C     Accuracy   Kappa    
#0.25  0.6213165  0.2390417
#0.50  0.6208585  0.2385981
#1.00  0.6125533  0.2222030
s=svm(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon) 
print(s)

table(predict(s,clean_colon),clean_colon$status) #정확도:(364+252)/888=69.37%

s=svm(status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+surg+extent+node4,data = clean_colon, kernel='polynomial')
p=predict(s,clean_colon)
table(p,clean_colon$status)#정확도:(398+223)/888=69.93%

#==>svm>decision tree>randomforest 순의 정확도

#######################################################

voice=read.csv("dataSet/voice.csv")
str(voice)

#1)Decision Tree
r=rpart(label~., data=voice)
par(mfrow=c(1,1), xpd=NA) #행과열 출력하기
plot(r)
text(r, use.n=T)
p=predict(r,voice, type='class')
table(p, voice$label) #결과: (1551+1496)/3168=96.18%

r=train(label~., data=voice, method='rpart')
r
##  cp           Accuracy   Kappa    
#0.008207071  0.9613513  0.9226643
#0.014520202  0.9563650  0.9126892
#0.909090909  0.6738401  0.3611422

#2)randomForest
f=randomForest(label~., data=voice) #OOB estimate of  error rate: 2.02%
print(f) #결과: (1555+1549)/3168=97.98%

f=train(label~., data=voice, method='rf')
f
##  mtry  Accuracy   Kappa    
#    2    0.9787257  0.9574301
#   11    0.9763229  0.9526229
#   20    0.9729511  0.9458755

#3)SVM
s=train(label~., data=voice, method='svmRadial')
s
##  C     Accuracy   Kappa    
#0.25  0.9768465  0.9536712
#0.50  0.9790618  0.9581036
#1.00  0.9801844  0.9603478

s=svm(label~., data=voice) 
print(s)

table(predict(s,voice),voice$label) #정확도:(1565+1555)/3168=98.48%

s=svm(label~., data=voice, kernel='polynomial')
p=predict(s,voice,type='class')
table(p,voice$label)#정확도:(1506+1569)/3168=97.06%


#==> randomforest>svm>decision tree 순의 정확도순






































