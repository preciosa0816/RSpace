#######Ch06::Packages::reshape2(데이터가공)

#데이터의 행을 열로, 열을 행으로 

install.packages("reshape2")
library(reshape2)
#melt(): 가로로 긴 데이터를 세로로 전환하는 함수 
melt(data, ..., na.rm = FALSE, value.name = "value")
  # na.rm = False : not available.remove: 결측치 제외 
  # value.name = "value" : 행으로 바꾸고 싶은 열 

#dataset:airquality
head(airquality)

#변수명을 소문자로 바꾸어 내용 저장 
names(airquality)<-tolower(names(airquality))
head(airquality)

melt_test<-melt(airquality)
head(melt_test)
tail(melt_test)
View(melt_test)

#월과 바람에 따른 오존 확인하기 
melt_test2<-melt(airquality,id.vars = c("month","wind"),measure.vars="ozone")
head(melt_test2)
View(melt_test2)
#(2)cast():세로로 긴 데이터모양을 가로로 변환
##acast():vector,Matrix,Array 형태 변환
##dcast():dataFrame형태변환

#1)dcast(dataset,기준열~반환열)
#변수명을 소문자로 변경
names(airquality)<-tolower(names(airquality))
head(airquality)
#melt()함수 호출
aq_melt<-melt(airquality,id=c("month","day"),na.rm = TRUE) #결측치제거 
head(aq_melt)
View(aq_melt)
#dcast()호출
aq_dcast<-dcast(aq_melt, month+day ~ variable) #month와 day를 기준으로 나머지 변수쓰기
head(aq_dcast)
View(aq_dcast)

#acast(dataset,기준열~반환열~분리기준열) :기준열이 행의 값이 되고 반환열이 열값이 된후 나머지 값들 출력 
###항목별로 분류
acast(aq_melt,day~month~variable)

###평균으로 요약 (각 변수의 월별 평균값)
acast(aq_melt,month~variable,mean)











