####Ch07_데이터 정제_연습문제
library(MASS)
#1.(1)Cars93의 결측값은 몇개인가?
table(is.na(Cars93)) # 13
str(Cars93)

for(i in c(1:ncol(Cars93))){
  print(i)
  print(table(is.na(Cars93[,i])))
}

table(is.na(Cars93$Luggage.room))#11
table(is.na(Cars93$Rear.seat.room))#2

#1.(2)Cars93 데이터에서 Luggage.room항목의 결측값을 제거한후 평균 짐싣는 공간(Luggage Capacity)을 계산하여 리터 단위로 나타내기
Luggage_Capacity<-Cars93[!is.na(Cars93$Luggage.room),]
table(is.na(Luggage_Capacity$Luggage.room))
mean(Luggage_Capacity$Luggage.room)*28.316847#393.3279

#2.(1)car데이터에서 dist의 이상값을 제거한후 dist의 평균값을 계산하기
str(cars)
boxplot(cars)
boxplot(cars)$stat
cars$dist<-ifelse(cars$dist<2|cars$dist>93,NA,cars$dist)
boxplot(cars)
mean(cars$dist,na.rm = T) #42.98

#ChickWeight 데이터에서 병아리 무게(weight)의 이상값을 제거한후 병아리의 평균 무게를 구하라
boxplot(ChickWeight$weight)
boxplot(ChickWeight$weight)$stat
ChickWeight$weight<-ifelse(ChickWeight$weight<35|ChickWeight$weight>309,NA,ChickWeight$weight)#309적용후 307이상값으로 인해 다시 한번적용하게됨
ChickWeight$weight<-ifelse(ChickWeight$weight<35|ChickWeight$weight>307,NA,ChickWeight$weight)

boxplot(ChickWeight$weight)
table(is.na(ChickWeight$weight))
mean(ChickWeight$weight,na.rm = T)#118.0915

#3.(1) 1학년 중간고사 파일(middle_mid_exam.xlsx)을 middle_mid_exam 변수에 저장하고 결과 확인하기
library(readxl)
middle_mid_exam<-read_excel("dataSet/middle_mid_exam.xlsx")
View(middle_mid_exam)
middle_mid_exam
#(2) dcast( )함수를 활용하여 반별 수학 점수(MATHEMATICS)와 영어점수(ENGLISH)를 각각 나타내기.
MATHMATICS<-middle_mid_exam %>% select(CLASS,ID,MATHEMATICS)
MATHMATICS<-dcast(MATHMATICS, ID~CLASS)
MATHMATICS
ENGLISH<-middle_mid_exam %>% select(CLASS,ID,ENGLISH)
ENGLISH<-dcast(ENGLISH, ID~CLASS)
ENGLISH

#(3) 위 1번에서 저장한 middle_mid_exam 변수를 활용하여 반별 영어점수의 평균과 합계,  반별 수학점수의 평균과 합계를 각각 구하기
library(dplyr)
middle_mid_exam %>% group_by(CLASS) %>%summarise(Eng_mean=mean(ENGLISH),Eng_sum=sum(ENGLISH),Math_mean=mean(MATHEMATICS),Math_sum=sum(MATHEMATICS)) 

#(4) MATHEMATICS 데이터 세트를 활용하여 수학점수가 80점 이상인 1반의 학생 수를 구하기
middle_mid_exam %>% filter(CLASS=="class1",MATHEMATICS>=80) %>% summarise(count=n())

#(5) middle_mid_exam 변수를 활용하여 수학 점수는 내림차순으로 정렬하고 영어 점수는 오름차순으로 정렬하기
middle_mid_exam %>% arrange(desc(MATHEMATICS),ENGLISH)
#(6) middle_mid_exam 변수를 활용하여 수학점수가 80점이상이고 영어 점수가 85점이상인 학생수를 구하기
middle_mid_exam %>% filter(MATHEMATICS>=80&ENGLISH>=85) %>% summarise(count=n())
























