####Ch08. Graph

##8-1산점도
library(ggplot2)
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point()

#범위설정
ggplot(data=mpg,aes(x=displ,y=hwy))+geom_point()+xlim(3,6)+ylim(10,30)

######188p mpg 데이터와 midwest데이터 분석하기
#mpg데이터로 x축이 cty y 축이 hwy로 된 산점도 만들기
ggplot(mpg,aes(x=cty,y=hwy))+geom_point()

#midwest 데이터로 x축은 poptotal, y축은 popasian으로 된 산점도 만들고 전체인구는 50만명이하, 아시아인구는 1만명이하로
ggplot(midwest,aes(x=poptotal,y=popasian))+geom_point()+xlim(0,500000)+ylim(0,10000)

##8-2 막대 그래프 

# 평균막대그래프
library(dplyr)
#집단별 평균표 만들기
df_mpg<-mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))
df_mpg
#그래프 생성하기 
ggplot(data=df_mpg,aes(x=drv,y=mean_hwy))+geom_col()
#크기순 정렬
ggplot(data=df_mpg,aes(x=reorder(drv,-mean_hwy),y=mean_hwy))+geom_col()
#빈도 막대 그래프 만들기
ggplot(data=mpg,aes(x=drv))+geom_bar()
ggplot(data=mpg,aes(x=hwy))+geom_bar()

### mpg 데이터 분석하기(193P)
#suv 차종을 대상으로 평균 cty가 가장 높은 회사 다섯곳을 막대그래프로 표현하기 (막대는 연비가 높은순으로 정렬)
mpgplot<-mpg %>% filter(class=="suv") %>% group_by(manufacturer) %>% summarise(meancty=mean(cty)) %>% arrange(desc(meancty)) %>% head(5)
mpgplot
ggplot(data=mpgplot,aes(x=reorder(manufacturer,-meancty),y=meancty))+geom_col()

# 자동차 중 어떤 class가 가장 많은지 알아보기 자동차 종류별 빈도막대그래프 
ggplot(data=mpg,aes(x=class))+geom_bar()

#8-3상자그림
ggplot(data=mpg,aes(x=drv,y=hwy))+geom_boxplot()

##mpg를 이용한 분석문제 (198P)
mpg_plot<-mpg %>% filter(class%in%c("compact","subcompact","suv"))
ggplot(data=mpg_plot,aes(x=class,y=cty))+geom_boxplot()
##

