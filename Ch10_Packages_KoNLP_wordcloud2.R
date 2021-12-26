########Ch10. Packages::KoNLP & wordcloud2
# Text Mining(글자 채굴)
# 한글로 wordcloud를 만들 때, 한국어를 분석하는 KoNLP(Korea Natural Language Process) 필요
#영문분석하는 wordcloud: openNLP, REKA, Snowball

#KoNLP는 자바의 의존성으로 인해 사전에 자바가 설치된 후에 패키지사용(rJava) 

#1. KoNLP & Wordcloud2 설치
#오른쪽 하단 packages install 누르고 검색후 설치
library("KoNLP")
library("wordcloud2")



#2.애국가를 형태소로 분석하기
#형태소(Morpheme): 언어의 뜻을 가진 가장 작은 단위 
#  예)사랑 : 사+랑(x) 사랑(0) 
# 애국가:구글 "행정안전부"-애국가 검색

#(1) 사전 설정
useSystemDic() #시스템 사전 설정
useSejongDic() #세종사전 
useNIADic() #NIC사전설정 

#(2) 애국가(가사).txt를 변수에 저장하기 
word_data<-readLines("dataSet/애국가(가사).txt")
word_data

#(3) 명사만 추출
#extraNoun() :명사분리
#USE.NAMES:열 이름
#sapply(): 행렬형태를 wordcloud에변수에서 모든 행에적용하기 위해서 사용

word_data2<- sapply(word_data,extractNoun, USE.NAMES = F)
View(word_data2)
  #=>제대로 추출 되지 않음 ::세종사전에 등록이 안되어 있기 때문

#(4) 단어를 사용자 정의 사전에 별도로 등록
  #rep():repeat
  #ncn:KAIST 품사 태그를 기준으로 비서술성 명사 설정 
  #replace_usr_dic:기존 사전의 내용에 대체 
add_words<-c("백두산","남산","철갑","가을","하늘","달")
buildDictionary(user_dic = data.frame(add_words, rep("ncn",length(add_words))),replace_usr_dic = T)

#(5) 확인 
word_data2<- sapply(word_data,extractNoun, USE.NAMES = F)
View(word_data2)

#(6) 행렬을 vector로 변환하기
  #:unlist(): 데이터를 백터로 변환
undata<-unlist(word_data2)
View(undata)

#(7) 사용빈도 확인
  #: table() : 사용빈도에 따라서 wordcloud에 글자가 크고 굵게 표시하기 위해서 
word_table<-table(undata)
View(word_table)
#(8) filtering 
  #Filter() : <대문자주의> 공백이나 한글자는 제외하고 2글자이상인 단어 선별
undata2<-Filter(function(x){nchar(x)>=2},undata)
word_table2<-table(undata2)
View(word_table2)

#(9) 데이터 정렬
# : sort()
sort(word_table2,decreasing = T)

#(10) wordcloud2 
#기본형
wordcloud2(word_table2)

#배경, 색상 변경
wordcloud2(word_table2,color = 'random-dark',backgroundColor = "black")

wordcloud2(word_table2,color = 'random-dark',backgroundColor = "white",shape = 'star')

#[참고]
#선택하는 색상만 반복
wordcloud2(demoFreq,size=0.8, color = rep_len(c("red","blue"),nrow(demoFreq)))

#일정방향으로 정렬 
wordcloud2(demoFreq,size=0.8, minRotation = -pi/6,maxRotation = pi/6, rotateRatio = 0.6)

#원하는 이미지에 워드클라우드 표시하기
###wordcloud2(demoFreq,figPath = "dataSet/peace.png")




























































