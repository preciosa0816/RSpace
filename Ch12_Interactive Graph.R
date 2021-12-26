####Ch12_Interactive Graph

########인터랙티브 그래프 만들기 
#####12-1 plotly 패키지로 인터렉티브그래프 만들기 
##1. 패키지 준비하기
install.packages("plotly")
library(plotly)

##2.ggplot2 로 그래프 만들기
library(ggplot2)
p<-ggplot(data=mpg, aes(x=displ , y=hwy, col=drv))+geom_point()

##3.인터랙티브 그래프 만들기
ggplotly(p) ##드래그해서 영역확대, 더블클릭-원래대로 돌아오기 

##4. HTML로 저장하기
#[Viewer]->[Export->Save as Web Page...]

##5. 인터랙티브 막대 그래프 만들기
p<-ggplot(data=diamonds, aes(x=cut, fill=clarity))+geom_bar(position = "dodge")
ggplotly(p)

#####12-2 dygraphs패키지로 인터랙티브 시계열그래프 만들기 

#####인터랙티브 시계열 그래프 만들기 
#1. 패키지설치 
install.packages("dygraphs")
library(dygraphs)
##2. 데이터 불러오기
##economics:실업자수, 저축률 등 1967~2015년 미국의 월별 경제지표 
economics<-ggplot2::economics
head(economics)
str(economics)
##3. xts타입 만들기 
library(xts)# xts: 시계열그래프를 만들기 위해 데이터가 시간순서의 속상을 지니는 xts데이터 타입으로 되어 있어야함.
eco<-xts(economics$unemploy, order.by = economics$date) #
head(eco)

##4.인터랙티브 시계열 그래프 만들기 
dygraph(eco)#그래프 생성 

##5. 날짜 범위 선택기능 추가하기 
dygraph(eco) %>% dyRangeSelector()

##6. 여러 값 표현하기
#저축률
eco_a<-xts(economics$psavert, order.by = economics$date)
#실업자수
eco_b<-xts(economics$unemploy/1000, order.by = economics$date) #100만명단위로 수정

##7. cbind()를 이용한 가로 결합과 변수명 바꾸기 
eco2<-cbind(eco_a,eco_b)
colnames(eco2)<-c("psavert","unemploy") #변수명바꾸기
head(eco2)

##8. 그래프만들기
dygraph(eco2) %>% dyRangeSelector()




































































































































