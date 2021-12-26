####1. 변수(Variable)
#행(row):관측치(실데이터)-1000만원,여,4.5,대한민국
#열(column):변수-소득,성별,학점,국적
#DataSet:행과 열로 이루어진 데이터구조
#데이터값:관측된 값
#데이터가공: 데이터전처리=데이터핸들링=데이터마트
#package: 함수들을 모아놓은 collection
#library: R패키지가 저장된 폴더 이름
#library():패키지를 R에 로딩하기 위해 사용용


library(help=datasets)
#library(help=datasets)==data() 같은 내용
data()


library(help="base")

#(1)변수만들기
a<-1
a

#(2)여러값으로 구성된 변수만들기
var1<-c(1,2,5,7,8) #combine=column=concatenate
var1

var2<-c(1:5)
var2

var3<-seq(1:5) #seq:sequence
var3

var4<-seq(1,5,by=2) #seq:sequence
var4

var5 <-seq(10,1, by=-3)
var5

var1
var1+2

var1+var2

var6 <-c(10:15)
var6

var7<-"hi"
var7

var8 <-c("hello","hi","how are you?")
var8#글자가 가장 긴 것을 중심으로 해서 배열

var9<-c(1,2,"c","D")
var9

####2. 데이터구조
#(1)Scala:구성인자가 1개인 벡터
s1 <-c(10)

#(2)Vector : 동일한 유형의 데이터가 1차원으로 구성된 구조
v1<-c(1,2,3)
### 1)숫자형 벡터(Numberic Vector)
n1<-c(-1,0,1)
str(n1)      ###변수의 속성 확인(구조,갯수)
length(n1)   ###값의 수(길이)

### 2)문자형 벡터(Character Vector)
c1<-c("hong","dong","home")
str(c1)      ###변수의 속성 확인(구조,갯수)
length(c1)
### 3)논리형 벡터(Logical Vector)
lo<-c(TRUE,FALSE)
str(lo)      ###변수의 속성 확인(구조,갯수)
length(lo)

typeof(lo) ###형반환 
mode(lo)  ###형반환
remove(lo) ###메모리에서 제거
rm(c1)  ###remove
#(3)Factor:범주형 데이터를 표현하기 위한 구조(yes,no,남자,여자)
## 명목형 요인: 크기가 불가능한 요인(남자.여자)
## 순서형 요인: 순서가 있는 요인(대,중,소)
f<-factor("yes",c("yes","no"))
f

#<NA>: 결측치(not available)-why /factor(c(),c()) 앞 c()는 뒤c() 값중 하나를 써야함
f<-factor(c("why","yes","good"),c("yes","no","good"))
f

#순서형범주로 레벨순서를 줄수있다.
order1<-factor(1,c(1,2,3),ordered = TRUE,levels = c(3,2,1))
order1 


#(4)Matrixs : 행렬,동일한 유형의 데이터가 2차원으로 구성된 구조
M1<- matrix(1:12,nrow=3)
M1

M2<- matrix(1:12,ncol=3)
M2

M3<- matrix(1:12,nrow=4, ncol=3 )
M3

M4<- matrix(1:12,nrow=4, ncol=3, byrow = T) #byrow:T(true) 행우선배열
M4


#(5)Array : 배열, 동일한 유형의 데이터가 n차원으로 구성된 구조
#         : Matrix를 여러겹으로 표현한 것 
#dim: dimension(차원):c(행,열,갯수)
A1<- array(1:12, dim=c(2,2,3))
A1

##-------------------------------------------------------------------------------
#(6) List : 리스트
#         :서로다른 구조의 데이터를 모두 묶은 객체
#         : (키,값)으로 쌍으로 구성됨
list1<-list(x=1:4, y=c("Hong","Alphgo"))
list1

str(list1)

#(7) Data.frame(데이터프레임)
#         :서로다른 구조의 2차원 형태의 데이터구조, 가장 많이 사용
#         :table또는 엑셀의 Sheet과 같은 형태
#         :data.frame의 변수안에 관측치 갯수가 같아야함
df1<-data.frame(x=1:4, y=c("Hong2","Alphgo2"))
df1

ID<-c(1,2,3,4,5,6,7,8,9,10)
BloodType<-c("A","B","O","AB","A","B","O","A","B","O")
AGE<-c(30,40,20,10,60,70,80,14,26,36)
AREA<-c("seoul","daejeon","busan","daegu","seoul","daejeon","busan","daegu","busan","daegu")

df2<-data.frame(ID,BloodType,AGE,AREA)
df2

str(df2)
#10 obs. of  4 variables: 관측치10개(행), 변수4개(열)
##-------------------------------------------------------------------------------

##Ch04-2
##85P 데이터프레임만들기 - 시험성적데이터
name<-c("김지훈","이유진","박동현","김민지")
eng<-c(90,80,60,70)
mat<-c(50,60,100,20)

df3<-data.frame(name,eng,mat)
df3

##88P 가격과 판매량
product <-c("사과","딸기","수박")
price<-c(1800,1500,3000)
amount<-c(24,38,13)

df4<-data.frame(product,price,amount)
df4

avaragePrice<-mean(df4$price)
avarageAmount<-mean(df4$amount)
avaragePrice
avarageAmount
median(df4$price) #요소들 중 중앙에 위치하는 값



