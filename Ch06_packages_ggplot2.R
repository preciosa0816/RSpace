######## Ch06_packages_ggplot2
#::데이터 분석의 시각화
#gglot()함수를 이용해서 틀을 만들고, 그 안에 다양한 이미지 객체레이어를 포개는 방식으로 그래프 표현 

#[1] 기본그래프
#그래프 기본 틀(x,y 축 매핑)
###=>ggplot(dataset,aes(데이터속성))...
library(ggplot2)
str(airquality)
ggplot(airquality,aes(x=day,y=temp))

#1.Scatter plot(산점도):geom_point() ::두변수의 관계를 파악하기 위해서 평면에 관측점을 찍어서 표현하는 그래프 
#작성방법1
ggplot(airquality,aes(x=day,y=temp))+geom_point()

#작성방법2
ggplot(airquality,aes(x=day,y=temp))+
  geom_point()

#작성방법3
ggplot(airquality,aes(x=day,y=temp))+
geom_point()

#작성방법4 =>작성불가 
ggplot(airquality,aes(x=day,y=temp))
+geom_point()

#예) 크기:3, 색상:빨강
ggplot(airquality,aes(x=day,y=temp))+geom_point(size=3, colour="red")
#예)x 축, y축 범위 지정
ggplot(airquality,aes(x=day,y=temp))+geom_point()+xlim(0,10)+ylim(70,90)


#2. 꺾은선 그래프 
#:점과 점을 순서대로 이어서 선으로 표현 산점도에 비해 관찰하기 쉬움 
ggplot(airquality,aes(x=day,y=temp))+geom_line()+geom_point()



#3. 막대그래프
### 빈도막대 그래프:geom_bar()
#: 하나의 변수에서 각 값의 빈도를 파악할때사용(x축만 지정)
str(mtcars)
ggplot(mtcars,aes(x=cyl))+geom_bar(width = 0.6)

##빈 범주를 제외하고 실린더 종류별 빈도수 
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(width = 0.6)

### 누적막대그래프: 
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill=factor(gear)),width=0.6)
View(mtcars)
#누적막대 그래프로 선버스트차트그리기
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill=factor(gear)),width=0.6)+coord_polar()

#누적막대 그래프로 선버스트를 원그래프로 변환
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar(aes(fill=factor(gear)),width=0.6)+coord_polar(theta = "y")


### 평균막대 그래프: geom_col()
ggplot(airquality,aes(x=day,y=temp))+geom_col()



#4-1.상자그림:geom_boxplot()
#:분포를 비교할 떄 사용 
ggplot(airquality, aes(x=day,y=temp,group=day))+geom_boxplot()

#4-2. 히스토그램(histogram):geom_histogram
#: 도수 분포를 기둥모양의 그래프로 표현 

ggplot(airquality,aes(temp))+geom_histogram()


#[2] 그래프에 개체추가하기 
str(economics)

##1. 직선그리기 
# 1)사선: geom_abline()
##psavert:날짜별 개인저축률 #intercept:절편 #slope:기울기
ggplot(economics,aes(x=date,y=psavert))+geom_line()+geom_abline(intercept = 12.18671,slope=-0.0005444)

















