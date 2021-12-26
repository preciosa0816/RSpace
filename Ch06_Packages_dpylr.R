####ch06.Packages::'dpylr' (데이터가공마법사)
###6-1 데이터전처리 (교재:125) - 이전파일

###6-7 데이터 합치기 
library(dplyr)
exam<-read.csv("C:\\RSpace\\dataSet\\csv_exam.csv")
View(exam)


#가로로합치기(152P)
##중간고사 데이터 생성
test1<-data.frame(id=c(1,2,3,4,5),midterm=c(60,80,70,90,85))
test1
##기말고사 데이터 생성
test2<-data.frame(id=c(1,2,3,4,5),final=c(70,83,65,95,80))
test2
##left_join을 활용한 가로로 합치기
total<-left_join(test1,test2,by="id")
total

##다른 데이터를 활용해 변수 추가하기(153P)
name<-data.frame(class=c(1,2,3,4,5),teacher=c("kim","lee","park","choi","jung")) ##담임선생님 추가하기 
name
exam_new<-left_join(exam,name,by="class")
View(exam_new)


#세로로합치기(154P)
##학생 1-5번 시험데이터 생성
group_a<-data.frame(id=c(1,2,3,4,5),test=c(60,70,80,90,85))
group_a
## 학생 6-10번시험 데이터 생성
group_b<-data.frame(id=c(6,7,8,9,10),test=c(70,83,65,95,80))
group_b

##bind_rows()를 활용하여 세로로합치기 
group_all<-bind_rows(group_a,group_b)
group_all

##mpg데이터를 이용해 분석문제 해결하기(156p)
mpg<-as.data.frame(ggplot2::mpg)
View(mpg)
fuel<-data.frame(fl=c("c","d","e","p","r"),price_f1=c(2.35,2.38,2.11,2.76,2.22),stringsAsFactors = F)
fuel
### mpg에 price_fl 변수추가하기
mpg<-left_join(mpg,fuel,by="fl")

### 연료가격변수확인하기 ,
mpg %>% select(model,fl,price_f1) %>% head(5)

##분석 도전 160P
midwest_test<-as.data.frame(ggplot2::midwest)
head(midwest_test)

###전체인구대비 미성년 인구 백분율 변수 추가 
midwest_test$popkid<-(midwest_test$poptotal-midwest_test$popadults)/midwest_test$poptotal

###미성년 인구 백분율이 가장 높은 상위 5개 country(지역)의 미성년 인구 백분율 출력 
midwest_test %>% select(county,popkid)%>% arrange(desc(popkid)) %>% head(5)

###미성율 비율 등급변수 추가 등급별 지역 갯수 출력 
midwest_test$conlevel<-if_else(midwest_test$popkid>=0.4,"large",
                               if_else(midwest_test$popkid>=0.3,"middle",
                               if_else(midwest_test$popkid<0.3,"small","NA")))
midwest_test %>% group_by(conlevel) %>% summarise(countkid=n())
table(midwest_test$conlevel)#미성년 비율등급표

head(midwest_test) 


#전체인구대비 아시아인 인구백분율만들고  출력
midwest_test$perAsian<-midwest_test$popasian/midwest_test$poptotal
midwest_test %>% mutate(perAsian=(popasian/poptotal)*100) %>% arrange(desc(perAsian)) %>% select(state,county,perAsian) %>% tail(10)
r







































