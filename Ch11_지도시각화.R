##Ch11 지도 시각화
########미국 주별 강력 범죄율 단계 구분도 만들기

##1. 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)

##2. 미국 주별 범죄데이터
str(USArrests)
head(USArrests)
View(USArrests)

##3. 주별 변수명 생성하고 소문자로 바꾸기
library(tibble)
crime<-rownames_to_column(USArrests, var="state")
crime$state<-tolower(crime$state)
view(crime)
str(crime)

##4. 미국 주 지도 데이터 준비하기
library(ggplot2)
install.packages("maps")
library(maps)
states_map<-map_data("state")
str(states_map)

##5. 단계 구분도 만들기
install.packages("mapproj")
library(mapproj)
ggChoropleth(data=crime, #지도에 표현할 데이터
             aes(fill=Murder,  #색깔로 표현할 변수
                 map_id=state), #지역기준변수
             map=states_map) #지도데이터

##6.인터랙티브 단계 구분도 만들기
ggChoropleth(data=crime,
             aes(fill=Murder,
                 map_id=state),
             map=states_map,
             interactive = T) #마우스 움직임에 반응하는 인터렉티브

##########11-2 대한민국 시도별 인구, 결핵환자 수 단계구분도 만들기 
#######대한민국 시도별 인구 단계 구분도 만들기
##1. 패키지 준비하기
install.packages("stringi")
library(stringi)
install.packages("devtools")
library(devtools)
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

##2.대한민국 시도별 인구 데이터준비
str(changeCode(korpop1))
library(dplyr)

##3. 한글변수명 영문으로 바꾸기 
korpop1<-rename(korpop1, pop=총인구_명,name=행정구역별_읍면동)

##4. 대한민국 시도지도 데이터 준비하기
str(changeCode(kormap1))

##5.단계구분도 만들기
install.packages("ggiraphExtra")
library(ggiraphExtra)
ggChoropleth(data=korpop1, #지도에 표현할 데이터
             aes(fill=pop, #색깔로 표현할 변수
                 map_id=code,# 지역기준변수
                 tooltip=name),#지도위에 표시할 지역명
             map=kormap1,#지도데이터
             interactive=T)#인터렉티브

###대한민국 시도별 결핵환자 수 단계구분도 만들기

str(changeCode(tbc)) #한글깨짐 방지
ggChoropleth(data=tbc,
             aes(fill=NewPts, #결액환자수 
                 map_id=code,
                 tooltip=name),
             map=kormap1,
             interactive = T)

























































































































































































































































