# sqldf 패키지
#  - R에서 sql 문법을 사용하여 데이터를 처리할 수 있는 함수
#  - ansi표준, oracle 표준 모두 허용

install.packages("sqldf")
library(sqldf)

install.packages('googleVis')   # 연습 데이터 셋 저장되어 있는 패키지
library(googleVis)

# 예제) Orange의 sales와 profit을 이름과 함께 출력
Fruits
Fruits[Fruits$Fruit =='Oranges', c('Fruit','Sales','Profit')]

## select Fruit,Sales,Profit from Fruits where Fruit = 'Oranges';
sqldf('select Fruit,Sales,Profit from Fruits where Fruit = \'Oranges\'')
sqldf("select Fruit,Sales,Profit from Fruits where Fruit = 'Oranges'")

# 예제) 앞의 3개 데이터만 출력
Fruits[1:3, ]
sqldf("select * from Fruits Limit 3")   # sqldf 문법 가능
sqldf("select * from Fruits where rownum <= 3")   # oracle 문법 가능, sqldf 문법 불가.

# 연습문제) emp 데이터를 읽고 다음과 같이 표현
# deptno  ename
#   10    CLARK KING MILLER
#   20    SMITH JONES ...
#   30    ALLEN WARD ...

emp <- read.csv('emp.csv', stringsAsFactors = F)
emp

aggregate(ENAME ~ DEPTNO, data = emp, sort)
aggregate(ENAME ~ DEPTNO, data = emp, str_c, collapse = ' ')   # sep 옵션이 안되는 이유
                                                               # : CLARK, KING, MILLER 이 형식이 벡터로 묶여서 전달된 형태이다. 
                                                               # 그래서 collapse를 사용...
aggregate(ENAME ~ DEPTNO, data = emp, paste, collapse = ' ')
library(stringr)
as.data.frame(tapply(emp$ENAME, emp$DEPTNO, paste))
as.data.frame(tapply(emp$ENAME, emp$DEPTNO, str_c))

# [참고 : ORACLE 표현식]
# listagg 함수 : list aggregate(결합)의 약자로
# group 별로 한 행에 데이터를 나열하고자 할때 사용
# sqldf에는 적용이 불가한 함수이다.
#
# select deptno, listagg(ename,   -- 나열할 값
#                        ' ')     -- 각 값의 분리기호
#                within group(order by sal desc) -- 한 행 내에 정렬 순서
#   from emp
#  group by deptno;


# plyr 패키지
# - 적용함수
# - 출력결과 데이터프레임
# - --ply 형식의 다양한 함수 제공
#   (입력형식)(출력형식)
# - adply : array 입력, data frame 출력, apply 함수와 비슷
# - ddply : data frame 입력, data frame 출력, 그룹연산 수행
install.packages('plyr')
library(plyr)

# 1. adply(data, margin, fun, ...)
apply(iris[,-5],1,sum)  # 벡터로 나열
adply(iris[,-5],1,sum)  # margin이 1일 경우 기존 데이터 유지 표현. 기존의 데이터 형식을 지켜주면서 컬럼추가

apply(iris[,-5],2,sum)
adply(iris[,-5],2,sum)  # margin이 2일 경우 기존 데이터 제외 후 표현

apply(iris[,-5],c(1,2),sum)
adply(iris[,-5],c(1,2),sum)   # 원소별 적용은 가능, 기존 2차원 유지 못함

# [참고 : adply는 mean을 데이터 프레임 형태로 전달 할 수 없음]
# adply는 행별, 열별로 묶어서 전달 시 데이터 프레임 형태로 전달(adply는 data.frame형태)
# mean함수는 자체가 데이터 프레임을 전달 할 수 없게 만들어져 있음(mean함수는 data.frame 허용안함)
apply(iris[,-5],1,mean)   # 수행 가능
adply(iris[,-5],1,mean)   # 수행 불가

v1 <- 1:10
df1 <- as.data.frame(v1)

sum(v1)    # 55, 벡터 전달 가능
sum(df1)   # 55, 데이터 프레임 전달 가능

mean(v1)    # 5.5, 벡터 전달 가능
mean(df1)   # NA, 데이터 프레임 전달 불가
# In mean.default(df1) : 인자가 수치형 또는 논리형이 아니므로 NA를 반환합니다.

adply(iris[,-5],1,mean)              # 데이터 프레임은 mean 연산 불가
adply(as.matrix(iris[,-5]),1,mean)   # matrix는 mean 연산 가능. 출력 결과 : data.frame

# 2. ddply
ddply(data,         # 적용 데이터프레임
      .variables,   # group by 컬럼, .(col1, col2, col3 ...) 형식 전달
      ddply-func,   # ddply 내부 함수
      func(x))         # 최종 적용 함수(sum, mean, ...), x = 적용컬럼

# ddply 내부 함수
# 1) summarise : group by 연산 결과만 요약해서 출력, 기존 데이터 표현 x.
# 2) transfrom : group by 연산 결과를 기존 데이터와 함께 표현
# 3) mutate : transform과 비슷, 연속적 함수의 적용 가능
# 4) subset : group by 연산 후 조건에 맞는 데이터 선택 시 사용

# 예제) emp데이터에서 부서별 연봉평균
# 1) summarise
# 10  2156
# 20  2500
# 30  3100

tapply(emp$SAL, emp$DEPTNO, mean)
aggregate(SAL ~ DEPTNO, data = emp, mean)
ddply(emp, .(DEPTNO), summarise, max_SAL = mean(SAL))   # mean 뒤에 적용 컬럼 기입.
ddply(emp, .(DEPTNO), summarise, max_SAL = mean(SAL),
                                 max_EMPNO = max(EMPNO))

# 2) transfrom, mutate
# empno     deptno  max_AVG
#  7369 ....  20      2500
#  7499 ....  30      3100

ddply(emp, .(DEPTNO), transform, avg_SAL = mean(SAL))
ddply(emp, .(DEPTNO), mutate, avg_SAL = mean(SAL))

# mutate가 transform보다 상위개념. deptno별로 sal평균을 구한 후 10% 상승된 sal을 구할때.
# mutate는 아래와 같이 재연산이 가능하다.(연속적 연산이 가능)
ddply(emp, .(DEPTNO), mutate, avg_SAL = mean(SAL), v1 = avg_SAL*1.1)
# transform은 재연산 불가능하다.(연속적 연산이 불가능)
ddply(emp, .(DEPTNO), transform, avg_SAL = mean(SAL), v1 = avg_SAL*1.1)


# 연습문제) emp에서 각 부서별 최대연봉을 받는 사람을 출력
# sol1)
emp2 <- ddply(emp, .(DEPTNO), transform, MAX_SAL = max(SAL))
emp2[emp2$SAL == emp2$MAX_SAL, ]

#sol2)
ddply(emp, .(DEPTNO), subset, SAL == max(SAL))


# 연습문제) student 데이터를 읽고
std <- read.csv('student.csv', stringsAsFactors = F)
# 1) 각 학년별 몸무게의 최대값 출력
tapply(std$WEIGHT, std$GRADE, max)
aggregate(WEIGHT ~ GRADE, data = std, max)

ddply(std, .(GRADE), summarise, max_WEIGHT = max(WEIGHT))

std2 <- ddply(std, .(GRADE), transform, max_WEIGHT = max(WEIGHT))
std2[std2$WEIGHT == std2$max_WEIGHT, ]

ddply(std, .(GRADE), subset, WEIGHT == max(WEIGHT))

# 2) 키가 학년별 평균 키보다 작은 학생 출력
std2 <- ddply(std, .(GRADE), transform, avg_HEIGHT = mean(HEIGHT))
std2[std2$HEIGHT < std2$avg_HEIGHT, ]

ddply(std, .(GRADE), subset, HEIGHT < mean(HEIGHT))


# 3) 각 학년별 몸무게, 키의 최대값 출력(그룹연산 컬럼 두 개 이상인 경우)
tapply(cbind(std$WEIGHT, std$HEIGHT), std$GRADE, max)   # tapply 불가

aggregate(cbind(WEIGHT, HEIGHT) ~ GRADE, data = std, max)   # aggregate는 cbind로 수행가능

ddply(std, .(GRADE), summarise, max_WEIGHT = max(WEIGHT),
                                max_HEIGHT = max(HEIGHT))


# [참고 : 그룹연산 컬럼 별 서로 다른 그룹함수 적용 시]. ddply로만 가능.
aggregate(cbind(WEIGHT, HEIGHT) ~ GRADE, data = std, c(max,mean))   # 여러개 function 적용은 불가능. function을 묶을 수 있는 기능이 없다.

ddply(std, .(GRADE), summarise, max_WEIGHT = max(WEIGHT),
                                mean_HEIGHT = mean(HEIGHT))   # 가능.


