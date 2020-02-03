# merge
# - database의 join 기법
# - 단 두개의 데이터의 조인만 가능(여러개 조인 시 merge의 중복 사용 필요)
# - equi join만 가능(내부에 조인 조건을 나열하는 부분 존재 x)

merge(x,          # 조인할 첫 번째 데이터(왼쪽 데이터)
      y,          # 조인할 두 번째 데이터(오른쪽 데이터)
      by = ,      # 조인컬럼(양쪽 동일 이름일 경우)
      by.x = ,    # x(왼쪽) 데이터의 조인컬럼
      by.y = ,    # y(오른쪽) 데이터의 조인컬럼
      all = ,     # full outer join 여부
      all.x = ,   # x(왼쪽) 기준 outer join 여부(left outer join)
      all.y = ,   # y(오른쪽) 기준 outer join 여부(right outer join)
      ... )

# 예제) emp.csv파일과 dept.csv파일을 불러와서 조인 수행
emp <- read.csv('emp.csv', stringsAsFactors = F)
dept <- read.csv('dept.csv', stringsAsFactors = F)

merge(emp, dept, by = 'DEPTNO')

# 예제) emp.csv파일을 사용하여 각 직원의 상위관리자 이름 출력
# select e1.enams AS 사원명, e2.ename AS 상위관리자명
#   from emp e1, emp e2
#  where e1.mgr = e2.empno + ;
 
merge(emp, emp, by.x = 'MGR', by.y = 'EMPNO', all.x = T)[,c('ENAME.x','ENAME.y')]
# 아우터 조인 및 컬럼 설정하여 출력.
# 아우터 조인 : 기준이 되는 테이블에 따라 첫번째 테이블이면 all.x  = T,
#두번째 테이블이면 all.y = T로 쓴다.
# by.x = : 첫번째 테이블
# by.y = : 두번째 테이블

# 출력결과
# ~.x = : 첫번째 테이블의 컬럼
# ~.y = : 두번째 테이블의 컬럼


# 연습문제) student.csv 파일과 exam_01.csv 파일을 읽고
st <- read.csv('student.csv', stringsAsFactors = F)
ex <- read.csv('exam_01.csv', stringsAsFactors = F)
# 1) 각 학생의 이름과 학년 성적을 출력
std2 <- merge(st,ex,by='STUDNO')[,c('NAME','GRADE','TOTAL')]

# 2) 학년별 최고 점수를 갖는 학생 이름, 학년, 성적 출력
df_jumsu <- as.data.frame(tapply(std2$TOTAL, std2$GRADE ,max))
df_jumsu$grade <- as.numeric(rownames(df_jumsu))
colnames(df_jumsu)[1] <- 'JUMSU'
df_jumsu
merge(std2, 
      df_jumsu, 
      by.x = c('GRADE','TOTAL'), 
      by.y = c('grade','JUMSU'))

# [연습문제]
# gogak, gift 테이블 데이터를 사용하여 각 고객의 포인트별 최대상품을 출력
# get_query <- function(...)   # 사용자 정의함수 생성
# non-equi join 이므로 merge못씀
library(RJDBC)
save(list = 'get_query', file = 'func1')
load('func1')
go <- get_query('select * from gogak')
gi <- get_query('select * from gift')


get_query <- function(x) {
  jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver", 
                     classPath = "C:/app/kitcoop/product/11.2.0/client_2/ojdbc6.jar")
  con <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@192.168.0.84:1521:testdb","scott","oracle")
  query <- "select * from gogak"
  result <- dbGetQuery(con, query)
}

get_query <- function(x) {
  jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver", 
                     classPath = "C:/app/kitcoop/product/11.2.0/client_2/ojdbc6.jar")
  con <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@192.168.0.84:1521:testdb","scott","oracle")
  query <- "select * from gift"
  result <- dbGetQuery(con, query)
}

## go$POINT between gi$G_START and gi$G_END. 선생님풀이...
gi[(gi$G_START <= 980000) & (gi$G_END >= 980000), 'GNAME']

f1 <- function(x) {
  return(gi[(gi$G_START <= x) & (gi$G_END >= x), 'GNAME'])
}
sapply(go$POINT, f1)

### 사용자 정의함수
f_1 <- function(x) {
  v_check <- c()
  for (j in 1:NROW(go)) {
    for ( i in 1:NROW(gi)) {
      if ( (go$POINT[j]>=gi$G_START[i])&(go$POINT[j] <gi$G_END[i])) {
        v_check <- c(v_check, gi$GNAME[i])
      }
    }
  }
  return(v_check)
}
f_1(go)

### 오라클 쿼리
library(RJDBC)
query <- "select go.GNAME, gi.GNAME from gogak go, gift gi where go.POINT between gi.G_START and gi.G_END"
result <- dbGetQuery(con, query)
result


# which.max, which.min : 최대 최소를 갖는 행 직접 선택(위치값 리턴)
max(emp$SAL)    # 5000
emp[emp$SAL == max(emp$SAL),]

which.max(emp$SAL)   # 9
emp[which.max(emp$SAL),]

v_num <- tapply(emp$SAL, emp$DEPTNO, which.max)
emp[v_num,]
tapply(emp$SAL, emp$DEPTNO, which.max)  # 10번 부서 내에서 두번째 사람, 
                                        # 20번 부서에서 3번째 사람, 
                                        # 30번 부서에서 4번째 사람이 부서내에서 가장 많은 sal을 받는다.

# aggregate() : group by 표현식
aggregate(x,        # 연산대상(벡터 또는 데이터프레임)
          by,       # group by 컬럼(리스트 전달)
          FUN)      # 함수
aggregate(fomular,  # X(연산 컬럼) ~ Y(group by 컬럼)
          data,     # data
          fun)      # 함수

# 1) 연산 컬럼 1개, group by 컬럼 1개
# 예제) emp에서 부서별 평균연봉 구하기
aggregate(emp$SAL, by = list(emp$DEPTNO), mean)
aggregate(SAL ~ DEPTNO, data = emp, mean)

## group by 연산 = tapply, aggregate, ddply(디디플라이)

# 2) 연산 컬럼 2개, group by 컬럼 1개
# 예제) student에서 학년별 평균키, 평균몸무게 구하기
std <- read.csv('student.csv', stringsAsFactors = F)
aggregate(std[,c('HEIGHT','WEIGHT')], by = list(std$GRADE), mean) # 데이터 프레임으로 표현
aggregate(HEIGHT + WEIGHT ~ GRADE, data = std, mean)         # 불가. 연산방향이므로 +를 넣으면 2개 컬럼의 각각의 평균이 안구해지고 두 컬럼의 합이 구해짐.
aggregate(cbind(HEIGHT, WEIGHT) ~ GRADE, data = std, mean)   # 가능. cbind

# 3) 연산 컬럼 1개, group by 컬럼 2개
# 예제) emp에서 부서별, job별 평균연봉 구하기
aggregate(emp$SAL, by = list(emp$DEPTNO, emp$JOB), mean)
aggregate(SAL ~ DEPTNO + JOB, data = emp, mean)   # 연산방향이 아니므로 +로 컬럼을 추가.


# stack, unstack : 데이터의 구조 변경
# - stack(x) : tidy(long) data 형식으로 변경
# - unstack(x,formula) : wide data 형식으로 변경

# 예제) 년도별 상품별 판매량을 정리..
# 1) wide 형식
# - 교차테이블 형식
# - 행별, 열별 산술연산 용이
# - 조인 수행 불가
# - 데이터 형태변경(컬럼 추가/삭제)에 따른 데이터구조가 변경된다는 것이 단점

#    2000  2001  2002  2003
# A
# B
# C
# D


# 2) long형식
# - database data 형식으로 하나의 행동이 컬럼으로 표현
# - 조인 수행 가능
# - group by 연산 가능

# 상품  년도  판매량
#  A   2000    100
#  B   2000    120
#  C   2000
#  D   2000
#  A   2001

df1 <- data.frame('apple'=c(100,120), 
                  'banana'=c(150,160), 
                  'mango' = c(90,80))
df1

# 1. stack(x) : wide -> long
# values : 컬럼이 가진 값
# ind    : 컬럼이름
df2 <- stack(df1)

# 2. unstack(x, value ~ index) : long -> wide
unstack(df2, values ~ ind)

emp
unstack(emp, SAL ~ DEPTNO)   # 데이터 프레임으로 출력이 안되는 이유 : 데이터 갯수가 각각 달라서...


# 연습문제) 
# melt_ex.csv 파일을 읽고 라떼의 수량에 대해 아래의 교차 테이블 완성
#        1   2   3   4   5 ... 12
# 2000 400 401 402
# 2001 412

melt <- read.csv('melt_ex.csv', stringsAsFactors = F)
df2 <- unstack(melt, latte ~ mon)
rownames(df2) <- c(2000,2001)
df2