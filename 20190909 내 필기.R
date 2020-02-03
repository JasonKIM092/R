# working directory 확인 및 설정
getwd() #"C:/Users/KITCOOP/Documents"
#R은 저장공간이 없다. 메모리만 갖고 있는 소프트웨어이다. 반면 sql 오렌지는 저장공간이 있다.
read.csv('test1.txt', header = F)
# 외부파일을 경로명 없이 파일 이름만을 통해 불러올 것이면 working directory에 데이터를 넣거나 or 파일을 경로와 같이 기입한다.read.csv('C:/Users/KITCOOP/Document/test1.txt', header = F)
# header = F 맨 윗 줄의 데이터를 컬럼으로 사용하지 않음. header = T 맨 윗줄의 행의 값을 컬럼으로 사용한다.
# 컬럼이름은 숫자로 시작할 수 없다. 그래서 데이터에 숫자가 있을 경우 프로그램 내에서 앞에 임의로 문자를 붙인다.
# 컬럼명이 입력되지 않으면 임의로 프로그램 내에서 컬럼명을 설정한다. ex)v1 v2 v3

setwd('C:/Users/') #working directory를 바꾸는 명령어이나, 재접속할 경우 setwd로 설정한 디렉토리를 사용하는 것이 아니라 다시 본래의 워킹디렉토리로 넘어간다.
read.csv('test1.txt', header = F) # 오류가 난다. 이유 : setwd로 워킹디렉토리 변경함,
read.csv('C:/Users/KITCOOP/Documents/test1.txt', header = F) # 파일의 위치를 선언해줘야 오류가 안난다.

# 워킹디렉토리를 영구적으로 변경시키고 싶으면 tools -> global options -> default working directory로 바꾼다.
# 아니면 속성창에 들어가서 바로가기 -> 시작위치 에 원하는 위치로 선언해준다.00

data1 <- read.csv('C:/Users/KITCOOP/Documents/test1.txt', header = F) #변수설정. 메모리 내에 저장시키는 방법. 디스크 내부 아니다. R은 디스크에 저정되는 소프트웨어가 아니다.
data1
# 예약어(명령어, sum과 같은 예약어)는 절대로 변수설정을 하면 안된다. 명령어 본래의 기능 수행 불가.
# c : 예약어라서 변수설정을 안해주는 것이 좋다. 그냥 하지 말것!
# 알파벳 명으로만 구성되어 있는 변수설정은 안해주는 것이 좋다. a1, b1과 같이 뒤에 숫자를 같이 붙여서 사용하는 습관을 들일것!

#변수의 할당
v1 <- 1
v2 <- 2
v1 + v2
v3 <- 'a'
v4 <- Sys.Date()
v4
v4 + 1  # 날짜의 산술연산 가능(기본단위 "일(day)")
# Oracle, R에서는 날짜의 산술연산이 가능하나, Python에서는 불가능

# 벡터 : 여러 상수를 묶기 위한 최소단위. 최소단위 데이터구조. 1차원. 서로 다른 데이터 타입 허용 X. data frame을 구성하기 위한 구성요소. 특정컬럼을 만들기 위한 단위.
var1 <- c(1,2)
var1

var2 <- c(1,'a') 
var2 # 숫자를 문자열로 바꾼다. 서로 다른 데이터 타입을 허용하지 않는다. 만약 서로다른 데이터 타입을 강제로 넣으면 삽입은 가능하나 형이 변경되어 출력이 된다.

# 평균함수 : mean. cf) 오라클에서는 avg

class(var1)
class(var2)
class(v4)
# class : 변수에 저장되어 있는 데이터 타입을 확인해 볼 수 있는 함수.


# 숫자와 문자와의 산술연산 불가(묵시적 형 변환 X)
1 + '1' # non-numeric argument to binary operator 에러발생
1 + as.numeric('1')

# 시퀀스
1:10 # 숫자의 시퀀스 배열 생성
seq(from=1,to=10,by=2) # seq 함수로도 시퀀스 배열 생성 가능
seq(1,10,2)
seq(by=10,from=1,to=100) # 각 인자별로 알맞는 전치사를 붙여주게 되면 순서를 구애 받지 않는다. 전치사 없이 사용할 경우는 순서를 꼭 지켜줄것!
'a' : 'c' # 문자의 시퀀스 배열 생성 불가

help(seq) # help() 함수를 통해 각 함수의 인자순서 및 함수에 대한 정보를 얻을 수 있다.
#seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
#    length.out = NULL, along.with = NULL, ...)

# 2019년 9월 9일 ~ 2019년 9월 19일 연속적 날짜 출력
seq('2019/09/09', '2019/09/19') # by값은 1이다. 1은 생략 가능하다. 
                                # 시퀀스 배열은 연속적인 날짜, 숫자를 배열해주는 함수라서 문자가 들어갈 수 없다.
seq(as.Date('2019/09/09'), as.Date('2019/09/19')) # Error in seq.Date(as.Date("2019/09/09"), as.Date("2019/09/19")) : 정확하게 두개의 'to', 'by' 그리고 'length.out' / 'along.with'가 반드시 지정되어야 합니다
# (by =) 1 반드시기록!!

seq(as.Date('2019/09/09'), as.Date('2019/09/19'), 1) #일

# 2019년 9월 9일 ~ 2020년 9월 19일까지 매월 증가되는 날짜 출력
seq(as.Date('2019/09/09'), as.Date('2020/09/19'), 'month') #월(month)

# 형 변환 함수
as.numeric('1')
as.character(날짜, format=변경할포멧)
as.Date(날짜, format = 파싱할포멧)

help("as.Date")
as.Date(x, format, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"),
        optional = FALSE, ...)

class('2019/09/09')
as.Date('2019/09/09')+1
as.Date('2019/09/09','%Y/%m/%d') # 날짜함수 포멧!! Python과 동일.'%Y/%m/%d'
as.Date('2019/09/09',format='%Y/%m/%d')
strptime('2019/09/09',format='%Y/%m/%d') # "2019-09-09 KST" : 표준이 되는 시간대도 같이 출력. Python에서도 사용.

#strptime : 문자 -> 날짜. p:파싱
#strftime : 날짜 -> 문자. f:포멧

as.character('2019/09/09', '%Y') # '2019/09/09' 얘가 문자임. 날짜형태로 만들어줘야함.
as.character(as.Date('2019/09/09'), '%Y')
as.character(Sys.Date() + 100, '%A') #'%A'는 요일!!
strftime(Sys.Date(), '%A')

# 날짜 포맷 확인
help("strptime")
help("strftime")


# 연습문제 1 : 2019년 매월 15일의 요일 출력
as.character(seq(as.Date('2019/01/15'), as.Date('2019/12/31'), 'month'),'%A')

date1 <- seq(as.Date('2019/01/15'), as.Date('2019/12/31'), 'month')
class(date1)
as.character(date1,'%A')

# 연습문제 2 : 세명의 입사일이 다음과 같을때 세명의 입사일로 부터
# 100일 뒤의 날짜를 동시에 출력하여라.
# 2010년 12월 12일, 2000년 6월 20일, 2011년 02월 04일
a1 <- c(as.Date('2010/12/12'), as.Date('2000/06/20'), as.Date('2011/02/04'))
a1+100

a2 <- c('2010/12/12', '2000/06/20', '2011/02/04')
as.Date(a2,'%Y/%m/%d')+100
strptime(a2,'%Y/%m/%d') + 100 # 100 = 100초.시간으로 계산됨.. 그냥 파싱용도만.


# 생성된 변수의 확인 및 제거
objects() # 생성변수 확인
objects(all.names = T) # 숨김변수까지 출력

rm(list='date1') # 특정 변수의 삭제
rm(list=ls()) # 현 세션에 선언된 모든 변수의 삭제

objects()

# 산술연산
10/3   # 나누기
10%/%3 # 몫
10%%3  # 나머지
2^6    # 승수
2**6   # 승수


# NULL과 NA의 차이 : 존재의 유무.
# NULL, NA 둘 다 반드시 대문자로!!
cat(1,NA,7)   # 1 NA 7
cat(1,NULL,7) # 1 7

NA + 3   # NA : 대상 존재. 하지만 잘못된 값
NULL + 3 # numeric(0) : 대상 존재안함.

sum(1,NA,2)   # NA
sum(1,NA,2,na.rm=T) # 3
sum(1,NULL,2) # 3(NULL은 무시되고 나머지 수끼리 연산)
sum(c(1,NULL,2)) # 3(굳이c안묶어도 댐)
help(sum)
sum(..., na.rm = FALSE) # ... : numeric or complex or logical vectors.
                        # na.rm : NA가 있으면 무시하겠다.(T or TRUE = 무시o, F or FALSE = 무시x)

mean(1,NULL,2)
mean(1,3,2)
mean(c(1,3,2)) # 이렇게 c묶어줘야 된다.
mean(c(1,NA,2))
mean(c(1,NULL,2)) # 1.5 : NULL값을 계산에 포함하지 않음.
help(mean)
mean(x, ...) # x : An R object.

is.na(1)
is.na(NA)
is.na(NULL)      # logical(0) : 논리값일 것 같은데 실제 데이터는 저장되어 있지 않다./데이터는 없다.
is.na(c(1,2,NA)) # FALSE FALSE  TRUE : 벡터는 각 요소마다 확인을 해준다.

is.null(1)
is.null(NULL)
is.null(c(1,2,NULL)) # FALSE : 벡터의 각 요소가 아니라 벡터 자체가 NULL인지를 확인한다.
                     # 벡터에 NULL이 들어가면 무시가 되고 숫자만 출력이 된다. 그래서 NULL체크가 안된다.
                     # 벡터의 원소별 NULL 체크 불가(NULL은 무시되므로)

var1 <- c(1,2,NULL,3)
var1                   # NULL은 아예 백터 내 저장되지 않음

# Oracle에서 NULL값은 R에서는 NA로 취급한다.
# R에서 NULL값은 0byte임. 반면 Oracle에서 NULL값은 존재하는 값임.


# 논리 연산자
# 1. and 연산자 : &, &&
TRUE & TRUE
TRUE & FALSE
1 & 1 # 1: 참, 0: 거짓
1 & 0
1 & 3 #0을 제외한 나머지 숫자들은 TRUE값을 갖는다.

# 2. or 연산자 : |, ||
TRUE | TRUE
TRUE | FALSE
1 | 1
1 | 0

# 3. not 연산자 : !
!TRUE

# 스칼라(boolean)의 논리 연산 : &, && 결과 동일
a1 <- 15
(a1 > 10) & (a1 > 0)
(a1 > 10) && (a1 > 0)

# 벡터의 논리 연산
c(T,T,F) & c(T,T,T)   # 원소마다 연산. 벡터의 각 원소별 논리 연산 수행.
c(T,T,F) && c(T,T,T)  # 맨 앞에 있는 원소만 연산. 벡터의 첫번째 원소만 논리 연산 수행

# 예제) 아래와 같은 컬럼 값이 있을 경우 clerk이면서 sal이 900이하인 대상은 몇번째인지 확인
sal <- c(800,1000,1200,1500)
job <- c('clerk','clerk','manager','manager')

#where job = 'clerk'
#  and sal >= 600
  
(sal >= 900) && (job == 'clerk')  # = 변수의 대입, 변수의 비교시엔 == 두개 사용.
                                  # && : 첫번째 데이터만 수행. 첫번째 (sal >= 900) 이것만 연산하고 두번째 (job == 'clerk')는 연산 안함. 
(sal >= 900) & (job == 'clerk')   # & : 모든 원소 수행. 첫번째 두번째 조건 모두 연산함.

# 날짜 관련 외무 패키지
install.packages("lubridate")
library(lubridate)

date1 <- now() # 현재 날짜시간
year(date1)
month(date1)            # 월(숫자).영문설정으로 출력해도 숫자로 출력된다.

month(date1, label = T) # factor형 변수로 출력
                        # 숫자로 출력되는 이유 : 한국어로 언어가 설정이 되어 있어서.
                        # 월(이름 : 영문일때). 영문설정시 영문으로 출력됨

# 시스템 날짜 언어 변경 : 해당 세션에서만 유효하다.
Sys.setlocale('LC_TIME','C')      # 영문
Sys.setlocale('LC_TIME','KOREAN') # 한글
 
day(date1)
wday(date1)            # 요일(숫자)
wday(date1, label = T) # 요일(이름). factor.

hour(date1)
minute(date1)
second(date1)

# libridate 패키지를 사용한 날짜의 연산
date2 <- Sys.Date()
date2 + 31
date2 + months(1)

date2 + 31*3      # 3개월 후 날짜의 연산의 정확도가 떨어짐
date2 + months(3) # 정확한 계산 가능

# **참고 : 여러 줄 동시 주석 처리 => 드래그 후 ctrl + shift + c

# 연습문제
# 2019년 9월의 일별 데이터를 출력,
# 그 중 v_year라는 컬럼(변수)에 년도만,
# v_month라는 컬럼(변수)에 월만, v_day라는 컬럼(변수)에 일만 분리저장
# v_bonus_date 컬럼에 6개월 후 데이터를 입력
v1 <-seq(as.Date('2019/09/01'),as.Date('2019/09/30'),1)
as.character(v1,'%Y') # 문자로 리턴
year(v1)              # 숫자로 리턴
v_year <- year(v1)
v_month <- month(v1)
v_day <- day(v1)
v_bonus_date <- v1 + months(6)
v_bonus_date


# 벡터 : 1차원, 동일 데이터 타입으로만 구성되는 최소 단위

# 1. 벡터의 생성 및 수정
v1 <- c(1,2,3,4,5)
v2 <- c(10,20,30,40,50)
v1 <- c(v1,6)  # 벡터의 원소 추가(맨 끝). 덮어쓰는 작업까지 해야지만 원소가 완벽하게 추가 되는 것이다.
               # 중간에 삽입 불가. 맨끝에만 가능.
v2 <- append(v2,60)  # 벡터의 원소 추가(맨 끝). 중간에 삽입 불가, 맨 끝에만 가능.

v10 <- c() # 비어있는 벡터의 생성.

# 벡터의 산술연산
v1 + 100  # 스칼라 산술 연산 가능
v1 + v2   # 동일 크기의 벡터끼리 산술 연산 가능
v3 <- c(100,200,300)
v1 + v3 # 101 202 303 104 205 306
        # 크기가 다른 벡터의 연산은 작은 벡터를 반복하여 연산

v4 <- c(100,200,300,400)
v1 + v4 # 101 202 303 404 105 206



# 벡터의 원소 추출 : 색인은 오라클에서 where절 조건과 비슷한 개념.
# 1. 정수색인 : 위치값 기준 색인 및 추출
v1[3]
v1[-3]  # 3번째 값을 제외하고. -를 통한 특정값 제외.

# 2. 이름색인 : 이름으로 추출
names(v1) # 원소이름 확인 함수
names(v1) <- c('a','b','c','d','e','f')  # 원소이름 부여/변경. 이름이 있는 벡터로 변경됨. 쉘이름 설정.
v1
v1['c']
v1[-'c'] # 이름색인일 경우 -를 통한 제외 불가!

# 3. 벡터색인
v1[1,3]                 # 2차원 데이터일때 첫번째 행, 세번째 컬럼 선택. 2차원 데이터 셋. 해석 : 1행의 3컬럼의 데이터 선택.
v1[1,3,6]               # 3차원 데이터 셋.
v1[c(1,3,6)]            # 벡터로 묶기. 1,3,6번째 데이터를 추출하는 쿼리.
v1[-c(1,3,6)]           # 숫자벡터에도 -를 통한 제외 가능
v1[c(1,2,3)] = v1[1:3]  # 연속적 범위 추출은 슬라이스 객체(v1[1:3], 시퀀스 배열) 사용
v1[-1:3]                # -1이라는 위치값으로 해석됨. 슬라이스 객체(시퀀스)에는 적용 불가능. -1부터 3까지로 해석됨(에러)
v1[-c(1:3)]             # 이렇게 사용해야 적용됨. 슬라이스 객체를 벡터로 만들어 -전달 가능

# 4. 불리언색인(조건색인)
v1[c(T,F,F,F,F,F)] # 해석 : 첫번째 원소만 추출하라. 즉, TRUE에 매칭되는 원소만 추출하라.
v1[c(F,T,F,F,F,F)]

v1 < 3 # 조건의 기능은 있지만, 추출의 기능은 없다. 오라클에서 where절은 조건+추출의 기능이 있다.
v1[v1 < 3]  # where v1 < 3
            # 추출의 기능은 색인 기호.[]:색인기호.
            # 색인은 추출의 기능이 있다.

# 연습문제
# 각 직원의 이름과 연봉이 다음과 같이 순차적으로 저장되어 있을 때
# sal이 1500 이상인 사람의 이름을 출력하여라.
v_ename <- c('smith','allen','word','scott','ford')
v_sal   <- c(1200,2000,2300,500,800)

v_ename[v_sal >= 1500]  # select v_ename
                        #   from ??????
                        #  where v_sal >= 1500;