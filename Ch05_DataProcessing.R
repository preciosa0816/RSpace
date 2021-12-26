##Ch05_Data preprocessing(데이터 전처리)

#데이터 일부추출, 니누기, 합치기 등 가공의 목적
###dplyr() : 패키지사용
##  :Data Manupulation(데이터 가공), Data Handling
##  dplyr:Data Wrangling, Data Munging

install.packages("dplyr")
library("dplyr")

##1.변수명바꾸기 (110p)
df_raw<- data.frame(var1=c(1,2,1) , var2=c(2,3,2))
df_raw

df_new<-rename(df_raw, v2=var2) #var2를 v2로 변경
df_new

install.packages("readxl")
library(readxl)

exdata1<-read_excel("dataSet/Sample1.xlsx")
exdata1
View(exdata1)

#데이터 파악하기(100p)
str(exdata1)
summary(exdata1)
dim(exdata1)
ls(exdata1)#열이름(변수, header)만 출력

exdata1<-rename(exdata1,Y17_AMT=AMT17,Y16_AMT=AMT16)
View(exdata1)

##파생변수 만들기(113p)
exdata1$AMT<-exdata1$Y16_AMT+exdata1$Y17_AMT
exdata1$CNT<-exdata1$Y16_CNT+exdata1$Y17_CNT
View(exdata1)

#변환방식
exdata1$AGE50_YN<-ifelse(exdata1$AGE>=50,"Y","N")
View(exdata1)

#exdata1의 AGE값이 50이상이면 "A1.50++", 40 이상시 "A2.4049",30 이상시 "A3.3039",20 이상시 "A4.2029" 나머지는 "A5.0019"
exdata1$AGE50_YN<-ifelse(exdata1$AGE>=50,"A1.50++",
                         ifelse(exdata1$AGE>=40,"A1.4049",
                                ifelse(exdata1$AGE>=30,"A1.3039",
                                       ifelse(exdata1$AGE>=20,"A1.2029",
                                              "A5.0019"))))

#######################dplyr(데이터전처리,가공)########################
?dplyr
#  %>% :: ctrl+shift+M, 파이프연산자 
#      :: 여러번 실행해야하는 복잡한 코드를 한번에 처리할수있게 연결해주는 연산자

#(1)select():원하는 데이터의 변수 선택
exdata1 %>% select(ID,SEX)
exdata1 %>% select(ID,Y17_AMT,Y17_CNT)
exdata1 %>% select(-AREA,-Y17_CNT) #선택변수만 제외하고 추출 

#(2)filter():필요한 조건 추출
exdata1 %>%  filter(AREA=="서울")
exdata1 %>%  filter(AGE50_YN=="A1.50++")
exdata1 %>%  filter(AREA=="서울"&Y17_CNT>=10)

#(3)arrange():변수를 크기순으로 정렬
exdata1 %>%  arrange(AMT) #기본값: 오름차순 
exdata1 %>%  arrange(desc(AMT)) #내림차순
exdata1 %>%  arrange(desc(AGE),Y17_AMT)#중첩정렬

#(4)summaris(): 데이터요약
exdata1 %>% summarise(TOT_Y17_AMT=sum(Y17_CNT))
##참고 : A tibble: 1 x 1 ::출력된 dataset이 1행1열
View(exdata1)

#(5)group_by():데이터 요약, 그룹별요약
exdata1 %>% group_by(AREA) %>% summarise(SUM_Y17_AMT=sum(Y17_CNT))

#(6)join :2개 이상의 데이터셋을 결합해서 한개의 데이터셋으로 만드는 과정
#        :데이터결합
#세로결합: bind_rows()
#가로결합: left_join(), inner_join(),full_join()

#113~149P
#데이터조합으로 파생변수 만들기 
df<-data.frame(var1=c(4,3,8),var2=c(2,6,1))
df$var_sum<-df$var1+df$var2
df

df$var_mean<-(df$var1+df$var2)/2
df

#데이터추출
exam<-read.csv("dataSet/csv_exam.txt")
exam

exam %>% filter(class==1)
exam %>% filter(class==2)
exam %>% filter(class!=1)
exam %>% filter(class!=3)

exam %>% filter(math>50)
exam %>% filter(class==1&math>=50)
exam %>% filter(math>70|english>90)


exam %>% filter(class%in%c(1,3,5))#1,3,5반에 해당하는 학생 출력

class1<-exam %>% filter(class==1)
class2<-exam %>% filter(class==2)
mean(class1$math)
mean(class2$english)

#변수 추출하기
exam %>% select(math,english)
exam %>% select(-math)
exam %>% filter(class==1) %>% select(english)
exam %>% select(id, math) %>% head(10)

#순서대로 정렬하기
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class,math)

#파생변수 추가하기
exam %>% mutate(total=math+english+science) %>% head
exam %>% mutate(total=math+english+science,
         mean=(math+english+science)/3)%>% head
exam %>% mutate(test=ifelse(science>=60,"pass","fail")) #ifelse 적용
exam %>% mutate(total=math+english+science) %>% arrange(total)

#집단별 요약하기
exam %>% summarise(mean_math=mean(math)) #math평균산출
exam %>% group_by(class) %>% summarise(mean_math=mean(math))
exam %>% group_by(class) %>% summarise(mean_math=mean(math),
                                       sum_math=sum(math),
                                       median_math=median(math),
                                       n=n())
##mpg데이터를 이용한 분석
install.packages("ggplot2")
mpg<-as.data.frame(ggplot2::mpg)
mpg_test<-mpg
mpg_test<-rename(mpg_test,city=cty,highway=hwy)
mpg_test %>% head
mpg_test$total<-(mpg_test$city+mpg_test$highway)/2
head(mpg_test)
summary(mpg_test$total)
hist(mpg_test$total)
mpg_test$test<-ifelse(mpg_test$total>=20,"true","false")
head(mpg_test)

mpg_test$grade<-ifelse(mpg_test$total>=30,"A",
                 ifelse(mpg_test$total>=20,"B","c"))
head(mpg_test)

###################133p mpg 데이터 이용한 분석
#displ이 4이하 or 5이상인 자동차 중 어떤자동차의 hwy가 평균적으로 더 높은지
mpg %>% filter(displ<=4) %>% summarise(mean(hwy)) #25.96319
mpg %>% filter(displ>=5) %>% summarise(mean(hwy)) #18.07895

#audi 와 toyota 중 평균 cty(도시 연비)가 더높은곳
mpg %>% filter(manufacturer=="audi"|manufacturer=="toyota") %>% group_by(manufacturer) %>% summarise(mean(cty))
# =>toyota 연비가 더 높음

#세 기업중 자동차 고속도로연비 평균 hwy전체평균 구하기 
mpg_test<-mpg %>% filter(manufacturer%in%c("chevrolet","ford","honda"))
mean(mpg_test$hwy)

###################138p  mpg 데이터 이용한 분석
mpg %>% select(class, cty)
## suv와 compact인 자동차 중 어떤 자동차의 cty 평균이 더 높은지 알아보기 
mpg %>% group_by(class) %>% summarise(csuv=mean(cty)) %>% filter(class%in%c("suv","compact"))

###################141p  mpg 데이터 이용한 분석
#audi에서 생산한 자동차 중에 어떤 자동차 모델의 hwy가 높은지알아보기(1~5위)
mpg %>% filter(manufacturer=="audi") %>% select(model, hwy) %>% arrange(desc(hwy)) %>% head(5)

###################144p  mpg 데이터 이용한 분석
# mpg()복사본을 만들고 변수가 hwy, cty를 더한 "합산연비변수"추가
mpg_test<-mpg
mpg_test<-mpg %>% mutate(합산연비변수=hwy+cty)
head(mpg_test)

#앞서 만든 합산연비변수를 2로 나눠 평균 연비변수 추가
mpg_test<-mpg_test %>% mutate(평균연비변수=합산연비변수/2)
head(mpg_test)

#평균 연비변수가 가장 높은 자동차 3종의 데이터 출력
mpg_test %>% arrange(desc(평균연비변수)) %>% head(3)

#위의 1~3을 정리하여 하나의 코드 구무능로 만들기 
mpg %>% mutate(합산연비변수=hwy+cty, 평균연비변수=합산연비변수/2) %>%arrange(desc(평균연비변수)) %>% head(3)

###################150p  mpg 데이터 이용한 분석
# class 별 cty 평균 구하기("suv, compact")
mpg%>% group_by(class) %>% summarise(mean=mean(cty))

# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균 높은순 정렬
mpg %>% group_by(class) %>%summarise(mean=mean(cty)) %>% arrange(desc(mean))

#hwy평균이 가장 높은 회사 세곳 출력
mpg %>% group_by(manufacturer) %>% summarise(mean=mean(hwy)) %>% arrange(desc(mean)) %>% head(3)

# 회사별 compact 차종 수 내림차순정렬후 출력
mpg %>% filter(class=="compact") %>% group_by(manufacturer) %>% summarise(num=n()) %>% arrange(desc(num))
###########################분석도전(123p)
midwestT<-as.data.frame(ggplot2::midwest)
summary(midwestT)
dim(midwestT)
ls(midwestT)
str(midwestT)

  #전체인구대비 아시아인구 백분율 파생변수
midwestT<-rename(midwestT,total=poptotal,asian=popasian)
ls(midwestT)
midwestT$var<-midwestT$asian/midwestT$total*100
hist(midwestT$var)

  #아시아인구 백분율 전체 평균과 평균 초과시 "large" 미달시 "small"부여 
mean(midwestT$var)
midwestT$asianava <-ifelse(midwestT$var>mean(midwestT$var),"large","small")

  #large와 small에 해당하는 지역 빈도표와 빈도막대 그래프
table(midwestT$asianava)
library(ggplot2)
qplot(midwestT$asianava)












