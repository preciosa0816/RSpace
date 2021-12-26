#Ch03_데이터 수집(Collection)

## 작업경로 살펴보기
getwd()#wd:working directory의 약자, 경로확인 
setwd("C:\\RSpace")#저장될 경로 변경,linux운영체제제
setwd("C:/RSpace")#window운영체제

###1. 원시자료입력 (R에서 직접입력) 및 엑셀파일 가져오기
#원시자료 입력하기
ID<-c(1,2,3,4)
MF<-c("M","F","M","F")
DATA <-data.frame(IDS=ID,MFS=MF)#관측치 개수=변수 개수 
View(DATA) #v:대문자 

### 엑셀파일(xls, xlsx) 불러오기
# 1)불러오기 방법1
install.packages("readxl") #download
library(readxl) #load to RAM

#데이터 불러오기
excel_data_ex<-read_excel("C:\\RSpace\\data_ex.xls")#절대경로 
View(excel_data_ex)

excel_data_ex2<-read_excel("C:/RSpace/data_ex.xls")
View(excel_data_ex2)

excel_data_ex3<-read_excel("data_ex.xls")
View(excel_data_ex3)

excel_data_ex4<-read_excel("dataset/data_ex.xls") #상대경로 
View(excel_data_ex4)

# 2)불러오기 방법2
##File-import dataset-from excel

#다시시작시 경로가 본래의 경로로 재설정됨
getwd()#C:\Users\wnddkd\Documents\RSpace
#현재 경로로 바꾸기 (more-set as working directory)
getwd()#"C:/RSpace"
#readxl 재설치 후 library 설정하기 
library(readxl)
excel_data_ex4<-read_excel("dataset/data_ex.xls",sheet = 1) #상대경로 
View(excel_data_ex4) #성공적으로 열림 #sheet=1은 default

library(readxl)
ex_data<-read.table("dataset/data_ex.txt") #txt file #Header로 V1, V2를 사용함
View(ex_data) 

ex_data2<-read.table("dataset/data_ex.txt", header = TRUE) #ID와 FM이 Header가 됨
View(ex_data2) 

ex_data3<-read.table("dataset/data_ex.txt", header = TRUE,skip = 2) #2개 row삭제
View(ex_data3) 

##[참고] txt문서 작성저장시 반드시 'Encoding: ANSI'로 저장한 후에 R에서 옵션으로 encoding="utf-8"
ex_data4<-read.table("dataset/data_ex2.txt", sep = ",", header = TRUE, encoding = "utf-8")
View(ex_data4) 

varname<-c("ID","MF","AGE","AREA")
ex_data5<-read.table("dataset/data_ex2.txt", sep = ",", col.names = varname,skip = 1,encoding = "utf-8")
View(ex_data5) 

#직관적인 메뉴로 원시 데이터를 가져오기 
#1) R studio 메뉴를 통해 txt문서를 가져오기
##    file-import dataset-from text(base)-setting(option)
###      > data_ex <- read.csv("C:/RSpace/dataSet/data_ex.txt", sep="")


#3. CSV(comma) 불러오기 
File-importDataSet-from text(base)옵션
##> data_ex <- read.csv("C:/RSpace/dataSet/data_ex.csv")
#>   View(data_ex)
#이와 같은 함수 자동 호출

#4. R데이터(*.rda)를 저장하고 불러오기 

ID<-c(1,2,3,4,5)
MF<-c("F","M","F","M","F")
data_ex<-data.frame(IDS=ID, MFS=MF)
data_ex

save(data_ex,file = "data_ex.rda")
load("data_ex.rda")
View(data_ex)

#5. CSV, TXT파일로 저장하기 

#CSV 저장 
ID<-c(1,2,3,4,5)
MF<-c("F","M","F","M","F")
data_ex<-data.frame(IDS=ID, MFS=MF)
data_ex

write.csv(data_ex,file="dataset/data2_ex.csv")

#TXT 저장 
ID<-c(1,2,3,4,5)
MF<-c("F","M","F","M","F")
data_ex<-data.frame(IDS=ID, MFS=MF)
data_ex

write.table(data_ex,file="dataset/data3_ex.txt")

##########################################################################
#R에서 데이터수집 요약(예측)
library(help="datasets")
data()
#quakes(earthquake)::Locations of Earthquakes off Fiji
#                 ::R에 내장된 quakes 데이터 세트 출력 

quakes
head(quakes, 10)#일부데이터 관측 (데이터 앞부분 10개행 보기(default:6))
tail(quakes,10) #데이터의 뒷부분 일부보기(default:6)
names(quakes)   # 데이터셋의 변수명보기
str(quakes)   #데이터 구조(속성(타입), 갯수)
dim(quakes) #dataset의 차원구조 (1000 행, 5열)

summary(quakes)

#quakes 저장하고 불러오기
write.table(quakes,file="dataset/quakes.txt")
write.table(quakes,file="dataset/quakes.txt",sep = ",")#데이터간 ',' 넣기
#내가한 읽는 방법
read.table("dataset/quakes.txt", header = TRUE,sep = ",")
q<-read.table("dataset/quakes.txt", header = TRUE,sep = ",") 
View(q) 
#csv로 읽기
x<-read.csv("dataset/quakes.txt", header = TRUE);x

x<-read.csv(file.choose(), header = T);x 

########################################################################

#웹사이트의 데이터 파일 읽기
url<-"https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv"
x<-read.csv(url);x

write.csv(x, file = "dataSet/titanic.csv")
read.csv("dataSet/titanic.csv")
dim(x)
str(x)
summary(x)
















