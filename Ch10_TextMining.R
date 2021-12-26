###Ch10. Text Mining

###10-1. HipHop Text Mining 
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

library(KoNLP)
library(dplyr)
useNIADic()
useSejongDic()
useSystemDic()
txt<-readLines("dataSet/hiphop.txt")
head(txt)

#특수문자 제거하기
install.packages("stringr")
library(stringr)
#\W(대문자):단어가 아닌 것, 같은 표현으로 [A-z0-9]
#\w[소문자]: 단어문자, 같은 표현으로  [A-z0-9]
txt<-str_replace_all(txt,"\\W"," ")

#가장 많이 사용된 단어 알아보기
#(1) 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

#가사에서 명사추출
nouns<-extractNoun(txt)
View(nouns)
#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount<-table(dddddddddddns))
View(wordcount)
#데이터 프레임으로 변환
df_word<-as.data.frame(wordcount,stringsAsFactors = F)
View(df_word)
#변수명 수정
df_word<-rename(df_word, word=Var1, freq=Freq)
View(df_word)
#(3)자주사용된 단어 빈도표 만들기
## 두글자 이상 단어 추출
df_word<-filter(df_word, nchar(word)>=2)

#빈도순 정렬 후 단어 추출 #%>%:함수연결연산자 
top_20<-df_word %>% arrange(desc(freq)) %>% head(20)
top_20

#워드클라우드 만들기
##(1)패키지 준비하기
install.packages("wordcloud")
library(wordcloud2)
library(wordcloud)
library(RColorBrewer)

##(2)단어 색상 목록 만들기
###Dark2색상 목록에서 8개 색상 추출
pal<-brewer.pal(8,"Dark2")
#난수를 이용해 다른 모양의 워드 클라우드 만들어 내기
set.seed(1234)
#워드클라우드 만들기
wordcloud(df_word)
wordcloud(words=df_word$word, 
           freq=df_word$freq,  
           min.freq=2,       
           max.words=200,    
           random.order=F,    
           rot.per=.1,        
           scale=c(4,0.3),    
           colors=pal)       


#단어 #빈도   #최소 단어 빈도  #표현단어 수 #고빈도 단어 중앙 배치 #회전단어비율  #단어크기범위  #색상 목록

#단어 색상 바꾸기 
pal<-brewer.pal(8,"Blues")[5:9] #색상목록 생성
set.seed(1234)
wordcloud(words=df_word$word, 
           freq=df_word$freq,  
           min.freq=2,       
           max.words=200,    
           random.order=F,    
           rot.per=.1,        
           scale=c(4,0.3),    
           colors=pal)       


##########10-2. 국정원 트윗 텍스트 마이닝

twitter<-read.csv("dataSet/twitter.csv",header=T, stringsAsFactors = F, fileEncoding = "UTF-8")

#변수명 수정
twitter<-rename(twitter, no=번호, id=계정이름, date=작성일, tw=내용 )

#특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W"," ")
head(twitter$tw)

#단어 빈도표 만들기
#트윗에서 명사추출
nouns<-extractNoun(twitter$tw)
#추출한 명사 list를 문자열 벡터로 변환 , 단어별 빈도표 생성
wordcount<-table(unlist(nouns))
#데이터프레임으로 변환
df_word<-as.data.frame(wordcount,stringsAsFactors = F)
#변수명수정
df_word<-rename(df_word, word=Var1, freq=Freq)

#두글자 이상 단어만 추출
df_word<-filter(df_word, nchar(word)>=2)
#상위 20개 추출
top20<-df_word %>% arrange(desc(freq)) %>% head(20)
top20

library(ggplot2)
order<-arrange(top20,freq)$word

#scale_x_discrete(limit=order): 빈도순 막대정렬
#geom_text(aes(label=freq), hjust=-0.3) 빈도표시 
ggplot(data=top20, aes(x=word, y=freq))+ylim(0,2500)+geom_col() +coord_flip()+scale_x_discrete(limit=order)+geom_text(aes(label=freq), hjust=-0.3)

pal<-brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(words=df_word$word, 
           freq=df_word$freq,  
           min.freq=10,       
           max.words=200,    
           random.order=F,    
           rot.per=.1,        
           scale=c(6,0.2),    
           colors=pal)    
#색상바꾸기 
pal<-brewer.pal(9,"Blues")[5:9]
set.send(1234)
wordcloud(words=df_word$word, 
           freq=df_word$freq,  
           min.freq=10,       
           max.words=200,    
           random.order=F,    
           rot.per=.1,        
           scale=c(6,0.2),    
           colors=pal)    



































