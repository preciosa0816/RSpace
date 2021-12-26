####ch13-2. 일반화(generalized) 선형모델

#glm() : 일반화 선형모델 
##해수욕장 
#y=방문객 수 
# y=1000*x+200  (x:기온) =>문제점 해결: 일반화 선형모델(지수)
# 지수관계로 모델링:: y=1000*s**0.1x+200

#예) 가판에서 목도리를 판매
#할인해서 파는 경우 할인에 따른 순이익 데이터 수집,
# 할인률을 %단위로 기록하고 순이익은 5만원 기준으로 해서 그 미만이면 0, 이상이면 1로 기록
library(scatterplot3d)
muffler=data.frame(discount=c(2.0,4.0,6.0,8.0,10.0),
                   profit=c(0,0,0,1,1)) #할인률과 순이익 

plot(muffler,pch=20,cex=2,xlim=c(0,12))
m=lm(profit~discount, data=muffler)
coef(m) #Model: prifit=0.15discount-0.5
fitted(m)
residuals(m)
deviance(m)
abline(m)

#새로운 할인률 적용해서 순이익 예측하기 
newd=data.frame(discount=c(1,5,12,20,30))
p=predict(m,newdata = newd)
p

plot(muffler,pch=20,xlim=c(0,32),ylim=c(-0.5,4.2))
abline(m)

res=data.frame(discount=newd,profit=p)
##cex:글자 및 심볼의 확대비율
#legned:범례 
points(res,pch=20,cex=2,col='red')
legend("bottomright",legend = c("train data","new data"),pch=c(20,20),cex=2,col=c("black","red"),bg="gray")
#=>오차가 너무 커서 모델로 사용 불가능 #########
#=> 일반화 선형모델
####2. 일반화 선형모델
muffler=data.frame(discount=c(2.0,4.0,6.0,8.0,10.0),
                   profit=c(0,0,0,1,1))

#family=binomial:반응 변수에게 2가지 값만 가진다고 알려주는 역할 
g=glm(profit~discount, data=muffler,family=binomial)
g
coef(g)
fitted(g)
residuals(g)

plot(muffler, pch=20, cex=2)
abline(g,col='blue', lwd=2)

#추가해서 할인율 적용
newd=data.frame(discount=c(1,5,12,20,30))
p=predict(g, newd, type = 'response')
#type = 'response':0~1사이의 값의 형식
print(p)

plot(muffler, pch=20, cex=2,xlim=c(0,32))
abline(g,col='blue',lwd=2)#lwd:선의 굵기
res=data.frame(discount=newd,profit=p)
points(res,pch=20,cex=2, col='red')
legend("bottomright",legend = c("train data","new data"),pch=c(20,20),cex=2,col=c("black","red"),bg="gray")


#####실제 데이터 적용::Haberman survival
## https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/ 에서 데이터 다운로드
haberman=read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data")
View(haberman)
#Attribute Information:

#1. Age of patient at time of operation (numerical) : 수술받은 당시의 나이
#2. Patient's year of operation (year - 1900, numerical) : 수술받은 연도
#3. Number of positive axillary nodes detected (numerical) : 양성림프샘 갯수 
#4. Survival status (class attribute) : 사망상태
#-- 1 = the patient survived 5 years or longer
#-- 2 = the patient died within 5 year
#=>5년이상 생존은 1, 5년이내 사망 2 (반응변수)
library(dplyr) 
#5년안에 죽은 사람 수 81/305명
haberman %>% filter(survival==2) %>% count(n())

names(haberman)=c('age','op_year','no_nodes','survival')
str(haberman)
haberman$survival=factor(haberman$survival)#범주형변환 (1,2만 존재)
str(haberman) 

h=glm(survival~age+op_year+no_nodes, data=haberman,family=binomial)

h
coef(h) 
#model::survival= 0.019age-.0.009op_year+0.0881no_nodes-1.8561
deviance(h)
fitted(h)
residuals(h)


#추가된 환자2명을 예측 
new_patients=data.frame(age=c(37,66),op_year=c(58,60),no_nodes=c(5,32))
p=predict(h,newdata = new_patients,type = 'response')
print(p)#type = 'response':0~1사이의 값의 형식
#첫번째 환자 ::5년이상 생존할 확률 : 100-22.42=77.58%
#두번째 환자 ::5년이상 생존할 확률: 100-84.30=15.70%


##특징(feature:설명변수)선택(selection)
#: 위 데이터 중 수술연도는 생존율과 상관관계가 모호하므로 삭제한다 
#:중요도가 높은 것들만 선ㅌ개해서 모델작성 
h=glm(survival~age+no_nodes, data=haberman,family=binomial)
coef(h)
#Model :: survival=0.019age+0.088no_nodes-2.4288
deviance(h) # 수술연도를 제거하기 전보다 더 크다.
new_patients=data.frame(age=c(37,66),no_nodes=c(5,32))
predict(h,newdata = new_patients,type = 'response')



######3. Logistic Regression 
#반응변수 2가지 값만 가지는 변수를 logistic regression 
#:2가지:참과 거짓, 성공실패, 결함/정상, 사망/생존, 승리/패배
l=a1x+a0 #선형회귀
# 로지스틱회귀 : 선형 회귀분석과 달리 결과 변수(종속 변수)가 범주형 데이터인 경우에 사용되는 기법(수치형데이터x)
y= 1/(1+e**-l)#logit 함수  
              #link함수
              #l:잠복변수(latent variable, hidden variable) 

#로지스틱회귀 : link함수로 logit함수를 쓴다.



####4. Logistic Regression 적용: UCLA admission dataset 
#=> 결측치가 없는 데이터 
ucla=read.csv("dataSet/binary.csv")
View(ucla)
str(ucla)
# ucla 대학에 대학원 입학여부
#admit():불합격(0), 합격(1)
#gre:미국 대학원 수학능력시험점수
#gpa:학부성적(평균평점)
#rank:출신 대학순위(1,2,3,4)

library(dplyr)
library(ggplot2)

ucla %>% ggplot(aes(gre,admit))+geom_point()
#=>geom_point를 사용해 그래프를 그린 결과 각각의 점들이 겹쳐져 알아보기 어렵다. 
ucla %>% ggplot(aes(gre,admit))+geom_jitter()#잡음 넣기 
ucla %>% ggplot(aes(gre,admit))+geom_jitter(aes(col=admit))
ucla %>% ggplot(aes(gre,admit))+geom_jitter(aes(col=factor(admit)))
ucla %>% ggplot(aes(gre,admit))+geom_jitter(aes(col=factor(admit)), height = 0.1, width = 0.0) #1
#=> geom_point로 그래프를 출력한 경우 두 번째 그래프처럼 점들의 간격이 좁을 경우 가독성이 떨어집니다. 그러나 geom_jitter의 경우 일정 범위 내에 흩뿌려 주기 때문에 쉽게 살펴 볼 수 있습니다. 


install.packages("gridExtra")
library(gridExtra)
p1=ucla %>% ggplot(aes(gpa,admit))+geom_jitter(aes(col=factor(admit)), height = 0.1, width = 0.0)#2
p2=ucla %>% ggplot(aes(rank,admit))+geom_jitter(aes(col=factor(admit)), height = 0.1, width = 0.0)#3

grid.arrange(p1,p2,ncol=2)

#glm()
m=glm(admit~gre+gpa+rank,data=ucla, family=binomial)
m=glm(admit~.,data=ucla, family=binomial)
coef(m)#. == 반응변수를 제외한 모든 변수 
deviance(m, type="response")
summary(ucla)
#Model ::amit = 0.002gre+0.777gpa-0.5600rank-3.4495

#새로운 지원자(gre:376,gpa:3.6, rank:3)
newd=data.frame(gre=376, gpa=3.6, rank=3)
p=predict(m,newd,type="response")
print(p)

####5. Logistic Regression 적용: colon 데이터셋(결측치)
library(survival)
str(colon)
#결장암 환자에게 보조적인 화학요법으로 레바미졸을 처방하고 치료효과를 기록한 데이터 셋 
#status:재발/사망여부(0: 완치, 1: 재발/사망) 
#extent:암세포가 침투한 깊이:1~4
#node: 암세포가 있는 림프절의 수
library(dplyr)
library(ggplot2)
plot(colon)
View(colon)
#=>변수가 너무 많아서 plot으로 얻은 그래프로 변수간의 상관관계를 알기 어렵다.
p1=colon %>% ggplot(aes(extent,status))+geom_jitter(aes(col=factor(status)),height=0.1, width=0.1)
p1
p2=colon %>% ggplot(aes(age,status))+geom_jitter(aes(col=factor(status)),height=0.1, width=0.1)
p2
p3=colon %>% ggplot(aes(sex,status))+geom_jitter(aes(col=factor(status)),height=0.1, width=0.1)
p3
p4=colon %>% ggplot(aes(nodes,status))+geom_jitter(aes(col=factor(status)),height=0.1, width=0.1)
p4

grid.arrange(p1,p2,p3,p4, ncol=2, nrow=2)

m=glm(status~.,data=colon, family=binomial)
m #결측치가있음(study 변수)
deviance(m)

#study의 결측치 제거 
#glm()함수는 자동으로 결측치를 제거하고 적용한다.
table(is.na(colon)) #FALSE  29646 TRUE 82
#na.omit()사용하기
clean_colon=na.omit(colon)
table(is.na(clean_colon))

k=glm(status~.,data=clean_colon, family=binomial)
k 

# 15개 설명변수 중에서 study(모두조사참여:1), time(etype까지의 일수), etype(재발,사망), id를 제외하고 glm()사용 
clean_colon=clean_colon[c(TRUE,FALSE),]
m=glm(formula=,data=clean_colon, family=binomial)
m
coef(m)
str(colon)


#Model:: status = -0.11rxLev-rxLev5FU-0.003sex+0.01age+0.2obsstruct+0.002perfor+0.36adhere+0.12nodes+0.03differ+0.38surg+0.56extent+0.62node4=2.98

#범주형 자료 다루기
#rx  : Factor w/ 3 levels "Obs","Lev","Lev+5FU":
#범주형은 수치형으로 바꿔야 한다.(순서형)
#범주형을 3가지 형으로 나열("Obs","Lev","Lev+5FU")
#one-hot-code(범주형=>순서형):
# Obs      :(0,0)
# Lev      :(1,0)      :rxLev
# Lev+5FU  :(0,1)  :rxLev+5FU







