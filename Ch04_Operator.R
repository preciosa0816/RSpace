###Ch04. 연산자
#1. 산술연산
  #사칙연산 (+,-,*,/)
  1+2 
  -20-3
  
 # 나머지연산(%%)
  5%%2
  
 # 몫 연산(%/%)
  5%/%2
  
 # 승구하기
  5**2 
  5^3
  
 #비교연산(>,<,=,<=,>=,!=,==)
  
 #논리연산자(&,|)
  !3 #False, 참이아님
  !0 #True, 거짓이 아닌 것이라서
  !1 #False, 참이아니라서 거짓 
#2. Vector 연산
 x<-c(1,2,3,4)
 x+1
 
 '1'+'2' #error
 as.numeric('1')+as.numeric('2') #3 / 강제적으로 숫자 형변환
 class('1') #class() : Data타입검색 . 'character'
 class(1) #numeric

#3. NA연산(Not Available)
 cat(1,NA,2) #NA가 그대로 출력 
 cat(1,NULL,2) #NULL입력시 NULL제거후 출력됨
 
 sum(c(1,2,3,NA)) #NA
 sum(c(1,2,3,NULL)) #6
 sum(c(1,2,3,NA), na.rm = T) #na.rm = TRUE : NA를 remove(rm)함























































































