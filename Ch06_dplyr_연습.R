#Ch06_dplyr_연습

###1. 중간고사 성적파일(mid_exam.xlsx)을 mid_exam 변수에 저장합니다. 이어서 수학점수의 변수명을 MATH_MID,영어점수의 변수명을 ENG_MID로 변경하고 결과 확인하기
library(readxl)
library(dplyr)
mid_exam<-read_excel("dataprocessing/mid_exam.xlsx")

mid_exam<-rename(mid_exam,MATH_MID=MATH,ENG_MID=ENG)
View(mid_exam)
#2. 기말고사 성적파일(final_exam.xlsx)을 final변수에 저장합니다. 이어서 수학점수의 변수명을 MATH_FINAL, 영어점수의 변수명을 ENG_FINAL로 변경하기.
final_exam<-read_excel("dataprocessing/final_exam.xlsx")
final_exam<-rename(final_exam,MATH_FINAL=MATH,ENG_FINAL=ENG)
View(final_exam)

#3. 중간고사(mid_exam)와 기말고사(final_exam) 성적 데이터 중 중간고사와 기말고사 성정이 모두 있는 데이터를 가로 결합한후 total_exam 변수에 저장하기.
total_exam<-left_join(mid_exam,final_exam,by="ID")
total_exam<-na.omit(total_exam)
View(total_exam)


#4. 중간고사와 기말고사를 결합한 total_exam 변수를 활용해 수학점수와 영어 점수의 개별 평균을 각각 구한후 MATH_AVG변수와 ENG_AVG변수에 추가하기
total_exam$MATH_AVG<-(total_exam$MATH_MID+total_exam$MATH_FINAL)/2
total_exam$ENG_AVG<-(total_exam$ENG_MID+total_exam$ENG_FINAL)/2
total_exam

#5. 성적이 모두 입력된 9명의 학생별 평균을 구한후 TOTAL_AVG변수에 추가하기
total_exam$TOTAL_AVG<-(total_exam$MATH_AVG+total_exam$ENG_AVG)/2 
total_exam

#6. 통합 성적(total_exam)에서 수학점수와 영어점수의 전체 평균을 구하기
total_exam %>% summarise(math_toAVG=sum(MATH_AVG,na.rm = T)/9,eng_toAVG=sum(ENG_AVG,na.rm = T)/9)

#7. 중간고사 수학점수가 80점 이상이고 중간고사 영어 점수가 90점 이상인 학생을 선별하기(%>%)
total_exam %>% filter(MATH_MID>=80 & ENG_MID>=90)


#8. 수학점수 평균과 영어점수 평균에 대한 상자 그림을 그리기(boxplot)
library(ggplot2)
boxplot(total_exam$MATH_AVG,total_exam$ENG_AVG)








