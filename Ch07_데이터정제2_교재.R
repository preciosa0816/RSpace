###Ch7 데이터 정제 , 빠진 데이터 이상한 데이터 제거하기

##07-1 결측치 정제하기

#결측치 찾기
df<-data.frame(sex=c("M","F",NA,"M","F"),score=c(5,4,3,4,NA))
df

#결측치 확인하기
is.na(df)
#결측치 빈도 출력 (true의 갯수가 결측치의 갯수)
table(is.na(df))
table(is.na(df$sex))
#결측치가 포함된 데이터 함수적용해보기
mean(df$score)
sum(df$score)
#=>NA

#결측치가 있는 행 제거하기
library(dplyr)
##score가 NA인 데이터만 출력
df %>% filter(is.na(score))

##score 결측치 제거
df %>% filter(!is.na(score))

#추출한 행으로 새 데이터프레임 만들기 //score만 결측치 제거됨
df_nomiss<-df %>% filter(!is.na(score))
mean(df_nomiss$score)

#여러 변수 동시에 결측치없는 데이터 추출하기
df_nomiss<-df %>% filter(!is.na(score)&!is.na(sex))
df_nomiss

#결측치가 하나라도 있으면 제거하기
df_nomiss2<-na.omit(df)
df_nomiss2

#함수의 결측치 제외 기능 
mean(df$score, na.rm=T)

#요약통계량 산출시 na.rm 적용해보기
exam<-read.csv("dataSet/csv_exam.csv")
exam[c(3,8,15),"math"]<-NA #3,8,15행의 math에 NA할당 #[]데이터 위치지정역할
exam

#math 결측치 제외하고 평균 산출
exam %>% summarise(mean_math=mean(math,na.rm=T))

#평균값으로 결측치 대체하기
mean(exam$math, na.rm=T) #55.23529

exam$math<-ifelse(is.na(exam$math),55,exam$math) #math가 NA면 55로 대체
table(is.na(exam$math)) #ALL FALSE

mean(exam$math)
library(ggplot2)
mpg<-as.data.frame(ggplot2::mpg)
table(is.na(mpg))
mpg[c(65,124,131,153,212),"hwy"]<-NA # NA할당하기

## drv별로 hwy 평균을 구하기 위해두 변수의 결측치 알아보기 (170P)
table(is.na(mpg$drv))
table(is.na(mpg$hwy)) #결측치 존재
## filter()을 사용해 hwy의 결측치를 제외하고 어떤 구동방식의 hwy 평균이 높은지 알아보기 
mpg %>% filter(!is.na(hwy)) %>% group_by(drv) %>% summarise(meanhwy=mean(hwy))

##07-2이상치 정제하기
outlier<-data.frame(sex=c(1,2,1,3,2,1),score=c(5,4,3,4,2,6))
outlier

#이상치확인하기 
table(outlier$sex)
table(outlier$score)

#결측 처리하기 
##sex가 3이면 NA할당
outlier$sex<-ifelse(outlier$sex==3,NA,outlier$sex)
outlier

##score가 5보다 크면 NA할당
outlier$score<-ifelse(outlier$score>5,NA,outlier$score)
outlier

#결측치를 제외한 score평균 출력
outlier %>% filter(!is.na(sex)&!is.na(score)) %>% group_by(sex) %>% summarise(mean_score=mean(score))

#이상치 제거하기-극단적인 값
boxplot(mpg$hwy)

#상자그림통계치 출력
boxplot(mpg$hwy)$stats

#결측처리하기(12~37벗어나면 NA할당)
mpg$hwy<-ifelse(mpg$hwy<12|mpg$hwy>37,NA,mpg$hwy)
table(is.na(mpg$hwy))

#결측치 제외한 평균
mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy,na.rm=T))

##mpg데이터를 이용한 분석문제 해결하기
mpg<-as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"]<-"k" #drv이상치 할당
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42) #cty이상치 할당

#drv 이상치 확인. 이상치 결측처리후 이상치가 사라졌는지 확인하기 (%in%)
table(mpg$drv)
mpg$drv<-ifelse(mpg$drv%in%c("4","f","r"),mpg$drv,NA)
table(mpg$drv)

#상자그림을 이용해 cty에 이상치가 있는지 확인하고 결측처리한 후 상자그림으로 이상치 사라졌는지 확인
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty<-ifelse(mpg$cty<9|mpg$cty>26,NA,mpg$cty)
boxplot(mpg$cty)

#drv별로 cty평균 분석 
mpg %>% filter(!is.na(mpg$drv)&!is.na(mpg$cty)) %>% group_by(drv) %>% summarise(mean_cty=mean(cty))




























