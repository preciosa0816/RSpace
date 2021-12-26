##Ch13.Modeling & predict(모델링과 예측)

#통계학 : 어느 집단에 대한 경향이나특징을 알기 위해서 관측하거나 조사하거나 실험한 결과를 숫자나 문자(자료ㅡ 데이터)로 정리한것.
#통계학-기술통계학;자료를 정리 , 표나 그래프, 평균값이나 중앙값ㅣㅣ
#      -수리통계학 = 추측통계학(확률이용):빈도론: 추정, 검정 분산분석
#                                       -베이즈 통계: 베이즈 추정, 베이즈네트워크, 베이즈검정


#      -다변량해석(벡터와 행렬 이용)

#통계학에서 다르는 데이터 종류
#(1)연속데이터 : 연속적인 수치로 나타낸 데이터 - 키, 체중, 시간, 혈압, 경제성장률
#   이산데이터: 연속적이지 않은 수치데이터 - 주사위눈, 연령, 테스트점수

#(2) 질적인 데이터 = 명목척도: 남자1, 여자2
#                    순서척도 : 영업실적3위
#(3) 1차 데이터 : 원래 특정 문제를 수행하기 위해서 수집된 데이터
#    2차데이터 : 다른곳에서 입수한 데이터

#(4) 정형데이터 : DB데이터, 엑셀데이터
#    비정형데이터: 이미지데이터터

##회귀분석 (Regression Analysis): 훈련집합을 가지고 모델을 구하는 것 
#                               독립변수(x)가 변할 때 종속변수(y)가 어떻게 변하는지 수식으로 표현한것.


######1. Modeling & Predict
#Modeling: 우리가 살고있는 현실세계에서 일어나는 현상을 수학식으로 표현한 것.
#          훈련집합을 이용해서 최적의 모델을 찾아내는 과정
#모델링을 통해서 모델을 알면 새로운 사실을 예측할 수 있다.  
#(예)영업사원
#   조건 : 100만원 기본급 , 1대 팔때마다 90만원을 추가로 받음

#   모델 : Y= 90*X+100(단위:만원)
#Y:종속변수,반응변수  X:독립변수,설명변수 90:계수 

#Training Set(훈련집합):주어진 데이터 
#X={x1,x2,x3,,,xn}, Y={y1y2,y3,,,yn}

#i번째 관측(observation) or i번째 sample:: (xi,yi)
#ground truth: 정답 
#계수(coefficient)
#coefficent(계=parameter): 90만원, 100만원 


####2. 현실 세계으 ㅣ모델링 
#:월급읨 모델링보다 현실 대단히 복잡, 
# 현실세계는 불확실성과 측정오차로 가득함

#(예) 자극과 반응
#학교 실험과목에서 전기 자극에 따른 이동거리를 모델링 실습
#전기량:X, 이동거리 :Y
#x={3.0,6.0,9.0,12.0}
#Y= {3.0,4.0,5.5,6.5}
#3=3*x+a 4=6*x+a 5.5=9*x+a 6.5=12*x+a 
##=> 여기에 만족하는 x값이 없음. 종속변수도 오차=> 선형모형으로 해서 오차를 허용
#오차: 오차제곱의 평균 , 평균 제곱오차 
#모델적합 예측함수: lm(종속변수~설명변수)

x=c(3.0,6.0,9.0,12.0) #설명변수
y=c(3.0,4.0,5.5,6.5) #
m=lm(y~x) #모델적합(학습):linear model regression
m #y=0.40*x+1.75 #Intercept:절편, 
plot(x,y)
abline(m,col='red')

coef(m) #coefficient 매개변수 값을 알려줌 
fitted(m) #훈련집합에 있는 sample에 대한 예측값 
residuals(m) #잔차:실제값-예측값 
deviance(m)#잔차 제곱의 합(+,-)때문에 제곱
deviance(m)/length(x)#평균제곱오차

summary(m)#모델의 상세분석 

###예측 
#predict()

#3개의 sample 새로 발생했을 떄 : 1.2,2.0,20.65
newx=data.frame(x=c(1.2,2.0,20.65))
predict(m,newdata = newx)

###########연습문제
X=c(10.0,12.0,9.5,22.2,8.0)
Y=c(360.2,420.0,359.5,679.0,315.3)

m=lm(Y~X)
m #y=25.59x+110.97
plot(X,Y)
abline(m,col='red')
deviance(m)#잔차 제곱의 합(+,-)때문에 제곱
deviance(m)/length(x)#평균제곱오차


newX=data.frame(X=c(10.5,25.0,15.0))
predict(m,newdata = newX)

##04. 단순선형회귀의 전용:cars 데이터
#cars:자동차의 속도(설명변수:x)에 따른 제동거리(반응변수:y)
cars
str(cars    )
head(cars)
plot(cars)

#단순선형회귀:lm()=>modeling
car_model=lm(dist~speed, data=cars)
coef(car_model)
abline(car_model, col="red")

#model:dist=3.9speed=17.58

##prediction(예측)
fitted(car_model)# 훈련집합에 있는 데이터에 대해 예측수행 
#=> speed가 7일떄 dist 가 21.7449~
residuals(car_model)


#데이터 하나 입력하는 경우
nx1=data.frame(speed=c(21.5))
predict(car_model,nx1)

#여러개의 데이터 추가입력
nx2=data.frame(speed=c(25.0,25.5,26.0,26.5,27.0,27.5,28.0))
predict(car_model,nx2)

#결과그래프그리기
nx=data.frame(speed=c(25.0,25.5,26.0,26.5,27.0,27.5,28.0))
plot(nx$speed,predict(car_model,nx),col='red',cex=2,pch=20)
abline(car_model)
plot(cars)

###고차 다항식을 적용하고 분산분석(ANOVA:Analysis Of Variance)
#anova(): 분산분석 모델을 평가하거나 모델비교를 위해서 사용
#lm():1차방정식, 직선사용
#lm(dist~poly(speed,i)) : speed i 항으로 갖는 i차방정식사용

plot(cars,xlab='속도',ylab='거리')
x=seq(0,25,length.out = 200)#예측할 지점
for(i in 1:4){
  m=lm(dist~poly(speed,i), data=cars)
  assign(paste('m',i,sep='.'),m)
  lines(x,predict(m,data.frame(speed=x)),col=i)
}

anova(m.1,m.2,m.3,m.4)

#########05.모델통계량의 해석(비교)
#비교를 통해서 통계량 해석 
women
cars 
str(women)
women_model=lm(weight~height, data=women)
coef(women_model)
# model : weight=3.45*height-87.51667

plot(women)
abline(women_model, col="red")
summary(women_model)


#cars모델
car_model=lm(dist~speed, data=cars)
summary(car_model)


###연습문제::단순선형회귀 
#women 데이터에 이상갑승로 height=65.5, weight=121이라는 샘플 추가 .새로운 데이터를 훈련집합으로 사용. lm으로 모델링하고 모델 그리기
women_test<-women
women_test
wo1=data.frame(height=c(65.5),weight=c(121))
women_test<-rbind(women_test,wo1)

women_test_model=lm(weight~height, data=women_test)
coef(women_test_model)
# model : weight=3.45*height-87.51667

plot(women_test)
abline(women_test_model, col="red")
summary(women_test_model)

#####t-value:각 독립변수의 유의성을 확인하기 위한 통계량 

##car 데이터에서 20,22,23번째 샘플을 제거하라
#새로운 데이터를 훈련집합으로 사용하여 lm으로 모델링하고 모델을 위 그림처럼 그려라 .
#이 데이터에 대해 통계량 분석을 하고 원래 cars데이터와 비교하고 해석하라.

car_test<-cars
car_test<-car_test[c(-20,-22,-23),]
str(cars)
str(car_test)

cars_test_model=lm(dist~speed, data=car_test)
coef(women_test_model)


plot(car_test)
abline(cars_test_model, col="red")
summary(cars_test_model)

summary(car_model)

#Pr(> |t|)열은 t 분포를 사용하여 각 변수가 얼마나 유의한지를 알려준다.
#0.0123 * - 원래의 cars 데이터의 Pr(> |t|)
#0.00288 ** - 3개의 데이터를 제거한 cars데이터의 Pr(> |t|)

#=>dist의 Pr(> |t|)이 더 줄어들었다.(더 유의해짐)

##########06.다중선형회귀분석
#(Multiple Linear Regression Analysis)
# 다중선형회귀::y=ax+bz+1
#             :설명변수가 2개이상인 선형회귀
#단순선형회귀: y=ax+1

#(예)전기자극에 대해서 물체의 이동거리를 모델링
#전기량:x, 물체의 무게:u, 이동거리:y
#x={(3.0,10.0),(6.0,10.0),(3.0,20.0),(6.0,20.0)}
#y={4.65,5.9,6.7,8.02}

library(scatterplot3d)
x=c(3.0,6.0,3.0,6.0)
u=c(10.0,10.0,20.0,20.0)
y=c(4.65,5.9,6.7,8.02)


scatterplot3d(x,u,y,xlim=2:7,ylim =7:23, zlim = 0:10, pch = 20, type = 'h' )

m=lm(y~x+u)
coef(m)

#y=0.4x+0.2u

s=scatterplot3d(x,u,y,xlim=2:7,ylim =7:23, zlim = 0:10, pch = 20, type = 'h' )
s$plane3d(m) #적합도
fitted(m)  #잔차
residuals(m)#잔차의 제곱합
deviance(m)/length(x) #평균제곱오차 

#추가해서 예측하기
nx=c(7.5,5.0)
nu=c(15.0,12.0)
new_data=data.frame(x=nx,u=nu)
ny=predict(m,newdata = new_data)
ny

s=scatterplot3d(nx,nu,ny,xlim=0:10,ylim =7:23, zlim = 0:10, pch = 20, type = 'h' ,angle = 60,color = 'red')
s$plane3d(m) #적합도


##############07.다중선형회귀의 적용:: trees
trees
str(trees)
#trees dataset:: 벚나무 31개 각각에 대해 지름(Girth), 키, 목재의 부피 변수
#trees: 지름(설명변수)과 키(설명변수)를 가지고 부피(반응변수)예측하기

##다중선형회귀
summary(trees)
scatterplot3d(trees$Girth, trees$Height, trees$Volume,color = 'blue',angle = 60)
m=lm(Volume~Girth+Height, data=trees)
m
coef(m)
#y=4.7x+0.3z-57.99

s=scatterplot3d(trees$Girth, trees$Height, trees$Volume,color = 'blue',angle = 20,pch = 20,type = 'h')

ndata=data.frame(Girth=c(8.5,13.0,19.0), Height=c(72,86,85))
predict(m,newdata = ndata)




s$plane3d(m) #적합도
fitted(m)  #잔차
residuals(m)#잔차의 제곱합
deviance(m)/length(trees$Girth) #평균제곱오차 





























































































































