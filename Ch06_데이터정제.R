#######Ch07 - 데이터정제 

#결측치(Not Available)

###1.데이터 정제를 위한 조건문과 반복문 
test<-c(15,20,30,NA,45)
test
test [test<40]
test[test%%3!=0]
test[is.na(test)]
test[!is.na(test)]

#2의 배수이면서 na가 아닌 요소
test[test%%2==0&!is.na(test)]
characters =data.frame(name=c("kil1","kil2","kil3"),
                       age=c(30,31,33),
                       gender=factor(c("M","F","M")))
View(characters)
characters
#성별이 F인 행 추출
characters[characters$gender=="F",]
#31세 미만 남성행 추출
characters[characters$gender=="M" & characters$age<31,]

####2. 조건문
x=5
if (x%%2==0) {
  print("x는 짝수")
}else{
  print("x는 홀수")
}

x=-1
if(x>0){
    print("x is positive value")
}else if(x<0){
  print("x is negative value")
}else{
  print("x is zero")
}

x=c(-5:5)
options(digits =3)#숫자표현시에 유효자리수를 3자리로 고정
sqrt(x)

#nan이 발생하지 않도록(Not a number) 음수면 NA로 표시 
sqrt(ifelse(x>0,x,NA))

students=read.csv("C:/RSpace/dataSet/students.csv")
students[,2]=ifelse(students[,2]>=0&students[,2]<=100,students[,2],NA)
students[,3]=ifelse(students[,3]>=0&students[,3]<=100,students[,3],NA)
students[,4]=ifelse(students[,4]>=0&students[,4]<=100,students[,4],NA)
students


####3. 반복문 
##1) repeat{반복수행할 문장}
i=1
repeat{
  if(i>10){
    break
  }else{
    print(i)
    i=i+1
  }
}

##2) while(조건식){}
#while 문을 통해서 1~10까지 수 증가시키기
i=1
while(i<=10){
  print(i)
  i=i+1
}

##3) for(변수 in data){}
for(i in 1:10){
  print(i)
  i=i+1
}

#while문으로 구구단(2단)만들기
i=1
while(i<10){
  print(paste(2,"x",i,"=",2*i))
  i=i+1
}

#for문으로 구구단(2단)만들기
for(i in 1:9){
  print(paste(2,"x",i,"=",2*i))
  i=i+1
}

#repeat으로 구구단(2단)만들기
i=1
repeat{
  if(i<10){
    print(paste(2,"x",i,"=",2*i))
    i=i+1
  }else{
    break
  }
}

##2. 조건반복을 사용한 결측치 처리 
students=read.csv("C:/RSpace/dataSet/students.csv")
students[,2]=ifelse(students[,2]>=0&students[,2]<=100,students[,2],NA)
students[,3]=ifelse(students[,3]>=0&students[,3]<=100,students[,3],NA)
students[,4]=ifelse(students[,4]>=0&students[,4]<=100,students[,4],NA)
students


for(i in {2:4}){
    students[,i]=ifelse(students[,i]>=0&students[,i]<=100,students[,i],NA)
}
students

##4.사용자 정의 함수
#:원하는 기능을 묶기 
#함수명=function(parameter1,parameter2,,,){
#  함수 수행코드 
#   return(반환값)
#}

#10!=10*9*8*...*1
fact=function(x){
  fa=1
  while(x>1){
    fa=fa*x
    x=x-1
  }
  return(fa)
}
fact(5)

fact<-function(x){
  if(x>1){
    return(x*fact(x-1))
  }else{
    return(1)
  }
}
fact(6)

#사용자정의함수이름 
my.is.na<-function(x){
  table(is.na(x))
}

str(airquality)

#두 문장은 같은값을 리턴함 
my.is.na(airquality)
table(is.na(airquality))


#####5.Missing Value(결측치)
#:통계에서 누락된 데이터 또는 데이터 수집단계에서 변수의 값이 저장되지않아 발생한 값
#결측값 처리방법 : is.na() ::NA가 T, 없으면 F
#                   na.omit():NA가 포함된행제거 
#                 함수의 속성 이용:na.rm=True(결측치제거)

#1)is.na()함수이용 
str(airquality)
head(is.na(airquality))
table(is.na(airquality))
table(is.na(airquality$Temp))
table(is.na(airquality$Ozone))

#Temp 평균
mean(airquality$Temp)

#Ozone속성에서 NA가 없는 값을 추출하고 평균 구하기
#1)
air_naram=airquality[!is.na(airquality$Ozone),]
mean(air_naram$Ozone)

#2)na.omit()을 이용한 결측값 처리하기
air_naram1=na.omit(airquality)
mean(air_naram1$Ozone)

#3)na.rm()을 이용한 결측값 처리하기 
mean(airquality$Ozone,na.rm = TRUE)

table(is.na(airquality))
table(is.na(airquality$Ozone))
table(is.na(airquality$Solar.R))

air_naram2<-airquality[!is.na(airquality$Ozone)&!is.na(airquality$Solar.R),]
mean(air_naram2$Ozone)
mean(air_naram2$Solar.R)

####5.Outlier(이상치)
  #:다른 관측값과 멀리 떨어진 값
patients=data.frame(
          name=c("환자1","환자2","환자3","환자4","환자5"),
        age=c(22,23,24,25,26),
        gender=factor(c("M","F","M","K","F")),
        blood.type=factor(c("A","O","B","AB","c"))
)
patients 
library(dplyr)
#성별에서 이상값 제거
patients_outrm=patients[patients$gender=="M"|patients$gender=="F",]
patients_outrm
#성별과 혈액형에서 이상값 제거
patients_outrm=patients[(patients$gender=="M"|patients$gender=="F")&patients$blood.type%in%c("A","B","O","AB"),]
patients_outrm

#이상값이 포함된 환자 데이터 
patients=data.frame(
  name=c("환자1","환자2","환자3","환자4","환자5"),
  age=c(22,23,24,25,26),
  gender=c(1,2,1,3,2),
  blood.type=factor(c(1,3,2,4,5))
)
patients

#성별에 있는 이상값 => 결측값으로 변경 

patients$gender=ifelse(patients$gender<1|patients$gender>2,NA,patients$gender)
patients$blood.type=ifelse(patients$blood.type%in%c(1,2,3,4),patients$blood.type,NA)
patients

#결측값을 모두 제거
  #1)방법1
patients[!is.na(patients$gender)&!is.na(patients$blood.type),]

  #)방법2
##patients<-na.omit(patients)

str(airquality)
boxplot(airquality[,c(1:4)])
boxplot(airquality[,1])$stats #ozone의 boxplot 통계값 계산 
boxplot(airquality[,c(1:4)])$stats
#임시저장변수에 데이터복사 
air=airquality
table(is.na(air$Ozone))

air$Ozone<-ifelse(air$Ozone<1|air$Ozone>122,NA,air$Ozone)
boxplot(air$Ozone)

#NA제거
air_naram=air[!is.na(air$Ozone),]
mean(air_naram$Ozone)
boxplot(air_naram$Ozone)











































































