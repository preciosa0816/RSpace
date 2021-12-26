###Ch7 데이터 정제 , 빠진 데이터 이상한 데이터 제거하기

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












