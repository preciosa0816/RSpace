###Ch09_project_한국인의 삶의 질

###9-1 한국패널데이터 분석 준비하기 

install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

#데이터 불러오기 
raw_welfare<-read.spss(file="doit/Koweps_hpc10_2015_beta1.sav",
                       to.data.frame = T)
# 복사본 만들기
welfare<-raw_welfare

#데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#변수명 바꾸기
welfare<-rename(welfare, sex=h10_g3, birth=h10_g4, marriage=h10_g10, religion=h10_g11, income=p1002_8aq1,code_job=h10_eco9,code_region=h10_reg7)

####9-2 성별에 따른 월급 차이
#1. 변수 검토하기 
class(welfare$sex)

table(welfare$sex)

#2. 전처리
## 이상치확인
table(welfare$sex)
##이상치 결측처리
welfare$sex<-ifelse(welfare$sex==9, NA, welfare$sex)

#결측치 확인
table(is.na(welfare$sex))

## 성별 항목 이름 부여
welfare$sex<-ifelse(welfare$sex==1, "male","female")
table(welfare$sex)

qplot(welfare$sex)

###########월급 변수 검토 및 전처리
###변수검토
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income)+xlim(0,1000)

### 전처리
#이상치 확인
summary(welfare$income)
#이상치 결측 처리
welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
#결측치 확인
table(is.na(welfare$income))

####성별에 따른 월급 차이 분석하기
sex_income<-welfare %>% filter(!is.na(income)) %>% group_by(sex) %>% summarise(mean_income=mean(income))
sex_income

##그래프 만들기
ggplot(data=sex_income, aes(x=sex, y=mean_income))+geom_col()

######09-3 나이와 월급의 관계 -"몇살 때 월급을 가장 많이 받을까?
#####나이변수 검토 및 전처리
##변수 검토하기
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth) #birth: 태어난 연도 변수

##전처리
summary(welfare$birth)
table(is.na(welfare$birth))

##이상치 결측 처리
welfare$birth<-ifelse(welfare$birth==9999, NA, welfare$birth)
table(is.na(welfare$birth))

##파생변수 만들기-나이
welfare$age<-2015-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)


##############나이와 월급의 관계 분석하기 
##나이에 따른 월급 평균표 만들기
age_income<-welfare %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income=mean(income))
head(age_income)

##그래프 만들기
ggplot(data=age_income, aes(x=age, y=mean_income))+geom_line()

###########9-4 연령대에 따른 월급 차이
#####연령대 변수 검토 및 전처리 하기
## 파생 변수 만들기 - 연령대
welfare<-welfare %>% mutate(ageg=ifelse(age<30,"young",
                                        ifelse(age<=59,"middle","old")))
table(welfare$ageg)
qplot(welfare$ageg)

###연령대에 따른 월급 차이 분석하기
ageg_income<-welfare %>% filter(!is.na(income)) %>% group_by(ageg) %>% summarise(mean_income=mean(income))
ageg_income

##그래프 만들기 
ggplot(data=ageg_income, aes(x=ageg, y=mean_income))+geom_col() #막대변수의 알파벳순 정렬

ggplot(data=ageg_income, aes(x=ageg, y=mean_income))+geom_col()+scale_x_discrete(limits=c("young","middle","old")) ## 나이순 정렬로 바꾸기 

##########9-5 연령대 및 성별 월급 차이
####연령대 및 성별 월급 차이 분석하기
## 1. 연령대 및 성별 월급 평균표 만들기
sex_income<-welfare %>% filter(!is.na(income)) %>% group_by(ageg,sex) %>% summarise(mean_income=mean(income))
sex_income

##2. 그래프 만들기 
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill=sex))+geom_col()+scale_x_discrete(limits=c("young","middle","old"))# 각성별의 월급이 연령대 막대에 함께 표현

ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill=sex))+geom_col(position="dodge")+scale_x_discrete(limits=c("young","middle","old")) #용이한 비교를 위해 막대 분리 (dodge)

###나이 및 성별 월급 차이 분석하기
sex_age<-welfare %>% filter(!is.na(income)) %>% group_by(age,sex) %>% summarise(mean_income=mean(income))
head(sex_age)
ggplot(data=sex_age, aes(x=age, y=mean_income, col=sex))+geom_line()
##=>남성의 월급은 50세 전후까지 지속적으로 증가하다 급격하게 감소하는 반면 여성은 30세전후까지 약간 상승하다 그 이후로는 지속적으로 완만하게 감소 

##############09-6 직업별 월급 차이 - 어떤 직업이 월급을 가장 많이 받을까
#####직업 변수 검토 및 전처리 하기
##1. 변수 검토하기 
class(welfare$code_job)
table(welfare$code_job)

##2.전처리 하기
library(readxl)
list_job<-read_excel("doit/Koweps_Codebook.xlsx", col_name=T, sheet=2)
head(list_job)
dim(list_job)

##3. 변수 결합하기 (code_job기준)
welfare<-left_join(welfare,list_job,id="code_job")
welfare %>% filter(!is.na(code_job)) %>% select(code_job,job) %>% head(10)

####직업별 월급 차이 분석하기 
##1. 직업별 월급 평균표 만들기 
job_income<- welfare %>% filter(!is.na(job)&!is.na(income)) %>% group_by(job) %>% summarise(mean_income=mean(income))
head(job_income)

##2. 월급 내림차순 정렬. 상위 10개 출력
top10<-job_income %>% arrange(desc(mean_income)) %>% head(10)
top10

##3.그래프 만들기 
ggplot(data=top10, aes(x=reorder(job, mean_income), y=mean_income))+geom_col()+coord_flip() #coord_flip() : 막대 90도 회전 

##4. 월급 하위 10개 직업추출
##하위 10위 추출
bottom10<-job_income %>% arrange(mean_income) %>% head(10)
bottom10

##그래프 만들기
ggplot(data=bottom10, aes(x=reorder(job,-mean_income), y=mean_income))+geom_col()+coord_flip()+ylim(0,850)


##############9-7 성별 직업 빈도 
###성별 직업 빈도 분석하기 
#남성 직업 빈도 상위 10개 추출
job_male<-welfare %>% filter(!is.na(job)&sex=="male") %>% group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_male

##여성 직업 빈도 상위 10개 추출
job_female <-welfare %>% filter(!is.na(job)&sex=="female") %>% group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_female

##그래프 만들기 
#남성 직업 빈도 상위 10개 직업
ggplot(data=job_male, aes(x=reorder(job,n),y=n))+geom_col()+coord_flip()
#여성 직업 빈도 상위 10개 직업
ggplot(data=job_female, aes(x=reorder(job,n),y=n))+geom_col()+coord_flip()

#geom_col(): 요약표를 이용해 막대 그래프를 만들 때
#goem_bar(): 원자료를 이용해 막대그래프 만들 때


############09-8 종교 유무에 따른 이혼율
#####종교 변수 검토 및 전처리 하기
##1. 변수 검토하기 
class(welfare$religion)
table(welfare$religion)

#전처리
##종교 유무 이름 부여
welfare$religion<-ifelse(welfare$religion==1, "yes","no")
table(welfare$religion)
qplot(welfare$religion)

######혼잉상태 변수 검토 및 전처리 하기
##1.변수 검토하기
class(welfare$marriage)
table(welfare$marriage)

##2.파생변수 만들기 - 이혼여부
#이혼 여부 변수 만들기 
welfare$group_marriage<-ifelse(welfare$marriage==1,"marriage", ifelse(welfare$marriage==3,"divorce",NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)


#####종교 유무에 따른 이혼율 분석하기
##1. 종교 유무에 따른 이혼율 표 만들기 
religion_marrage<-welfare %>% filter(!is.na(group_marriage)) %>% group_by(religion,group_marriage) %>% summarise(n=n()) %>% mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100,1))

religion_marrage

religion_marrage <-welfare %>% filter(!is.na(group_marriage)) %>% count(religion,group_marriage) %>% group_by(religion) %>% mutate(pct=round(n/sum(n)*100,1))

##2.이혼율 표 만들기 
##이혼 추출
divorce<-religion_marrage %>% filter(group_marriage=="divorce") %>% select(religion,pct)
divorce

##3. 그래프 만들기 
ggplot(data=divorce, aes(x=religion, y=pct))+geom_col()

######연령대 및 종교 유무에 따른 이혼율 분석하기
##1. 연령대별 이혼율 표 만들기
ageg_marriage<-welfare %>% filter(!is.na(group_marriage)) %>% group_by(ageg,group_marriage) %>% summarise(n=n()) %>% mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100,1))
ageg_marriage

ageg_marriage<-welfare %>% filter(!is.na(group_marriage)) %>% count(ageg,group_marriage) %>% group_by(ageg) %>% mutate(pct=round(n/sum(n)*100,1))

##2.연령대별 이혼율 그래프 만들기
#초년제외, 이혼추출
ageg_divorce<-ageg_marriage %>% filter(ageg!="young" &group_marriage=="divorce") %>% select(ageg,pct)
ageg_divorce

#그래프 만들기
ggplot(data=ageg_divorce,aes(x=ageg,y=pct))+geom_col()

###3. 연령대 및 종교유무에 따른 이혼율 표 만들기
#연령대, 종교 유무, 결혼 상태별 비율표 만들기
ageg_religion_marriage<-welfare %>% filter(!is.na(group_marriage)&ageg!="young") %>% group_by(ageg,religion,group_marriage) %>% summarise(n=n()) %>% mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100,1))
ageg_religion_marriage

ageg_religion_marriage<-welfare %>% filter(!is.na(group_marriage)&ageg!="young") %>% count(ageg,religion,group_marriage) %>% group_by(ageg,religion) %>% mutate(pct=round(n/sum(n)*100,1))

#연령대 및 종교 유무별 이혼율 표 만들기
df_divorce<-ageg_religion_marriage %>% filter(group_marriage=="divorce") %>% select(ageg,religion,pct)
df_divorce

####4. 연령대 및 종교 유무에 따른 이혼율 그리기
ggplot(data=df_divorce, aes(x=ageg, y=pct, fill=religion))+geom_col(position="dodge")
#=> 무교인 중년의 사람들의 이혼율이 가장 높음 

##########9-9 지역별 연령대 비율 - 노년층이 많은 지역
##1.변수 검토하기
class(welfare$code_region)
table(welfare$code_region)

##2.전처리
#지역 코드목록 만들기
list_region<-data.frame(code_region=c(1:7),
                        region=c("서울",
                                 "수도권(인천/경기)",
                                 "부산/경남/울산",
                                 "대구/경북",
                                 "대전/충남",
                                 "강원/충북",
                                 "광주/전남/전북/제주도"))
list_region

#지역명 변수 추가
welfare<-left_join(welfare,list_region,id="code_region")

welfare %>% select(code_region,region) %>% head

####지역별 연령대 비율 분석하기
#1.지역별 연령대 비율표 만들기
#방법1)
region_ageg<-welfare %>% group_by(region,ageg) %>% summarise(n=n()) %>% mutate(tot_group=sum(n)) %>% mutate(pct=round(n/tot_group*100,2))
head(region_ageg)

#방법2)
region_ageg<-welfare %>% count(region,ageg) %>% group_by(region) %>% mutate(pct=round(n/sum(n)*100,2))

##2. 그래프 만들기
ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg))+geom_col()+coord_flip()

##3. 노년층 비율 높은 순으로 막대 정렬하기
#노년층 비율 내림차순 정렬
list_order_old<-region_ageg %>% filter(ageg=="old") %>% arrange(pct)
list_order_old

#지역명 순서변수 만들기
order<-list_order_old$region
order

#노년층비율이 높은 순으로 정렬하기 
ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg))+geom_col()+coord_flip()+scale_x_discrete(limits=order)

##4.연령대 순으로 막대 색깔 나열하기
class(region_ageg$ageg)
levels(region_ageg$ageg)

region_ageg$ageg<-factor(region_ageg$ageg, level=c("old","middle","young"))
class(region_ageg$ageg)
levels(region_ageg$ageg)

ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg))+geom_col()+coord_flip()+scale_x_discrete(limits=order)









