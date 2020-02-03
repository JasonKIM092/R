getwd()

df1 <- data.frame(col1 = 1:5, col2 = 6:10)
df1
write.csv(df1, 'df1.csv')  # working directory에 저정이 된다.
getwd()

# 바이너리 형식의 파일 입출력
v1 <- 1
v2 <- 2
v3 <- 3
ls()
save(list = ls(), file='var_list')
rm(list = ls())
v1  # 지워버리게 되면 v1이 실행이 안된다. 존재하지 않는 객체. 이유 : rm처리
load(file = 'var_list')
v1  # load로 불러오면 다시 실행 됨. load 이후 다시 생성된 것 확인.

# 외부파일 입출력
# 1. read.csv(sep=',')   -- sep옵션만 잘 조절해주면 csv파일 이외의 text파일도 불러올 수 있다.
read.csv('test1.txt', header=F, sep='')
read.csv('test1.txt', header=F)  # sep 옵션이 ','라서 컬럼이 1개로만 구성된다. 
                                 # 외부파일을 데이터프레임으로 저장.

# 2. read.table(sep='')  -- sep옵션만 잘 조절해주면 csv파일 이외의 text파일도 불러올 수 있다.
read.table('test1.txt', header=F)  # sep 옵션이 공백('')이라서.
                                   # 외부파일을 데이터프레임으로 저장.

# 3. scan : 외부파일 혹은 사용자 입력값을 벡터로 저장하는 입력함수. 
#           외부 파일 또는 사용자 입력 값을 벡터로 저장
scan()   # 숫자 입력값 대기. 사용자 입력 값 대기 중. 입력값 대기. readline과는 달리 여러번 입력이 가능.
scan(what='')   # 문자 입력값 대기
scan('test1.txt')    # 외부파일을 벡터로 저장
scan('test1.txt', what ='')   # 외부파일을 문자벡터로 저장
                              # 외부파일을 숫자로 저장하는 것이 디폴트 이기때문에
                              # 문자로 저장한 외부파일을 허용하지 않는다.
                              # 문자외부파일 불러오기 옵션 what = ''


# 4. readLines : 외부파일을 벡터로 저장
readLines('test1.txt')  # 각 라인을 벡터의 하나의 원소로 저장. 라인별로 벡터의 원소로 저장.

# 5. readline : 한 번의 입력을 사용자로 부터 요구하는 상황, 문자로 저장.
readline()

ans <- readline('정말 삭제하겠습니까? (Y|N) : ')

if (ans == 'Y') {
  rm(list = ls())
} else {
  print('프로그램을 종료하겠습니다')
}

# apply 계열 함수 특징
apply(iris[,-5],2,sum)   # apply를 통한 컬럼별, 행별 적용 처리
colSums(iris[,-5])       # colSums, rowSums으로 컬럼별, 행별 적용 처리

# sapply, lapply, mapply
# - 주목적 벡터연산(벡터 원소별로 함수의 적용)
# - key별 적용도 가능(리스트, 데이터프레임에 적용시). 데이터프레임에서 key = column.
# - 적용데이터가 2차원일대는 key별, 1차원일때는 원소별로 결과값이 나온다.

sapply(iris[,-5], mean)   # 2차원 데이터셋의 적용시 key(컬럼)별 적용
lapply(iris[,-5], mean)   # 2차원 데이터셋의 적용시 key(컬럼)별 적용
mapply(mean, iris[,-5])   # 2차원 데이터셋의 적용시 key(컬럼)별 적용

# 2차원 구조의 원소별 적용은 apply로 수행!
# sapply, lapply, mapply는 2차원 데이터를 적용하면 key별로 적용됨.
# 1차원에 대한 벡터의 원소별 반복 연산 적용은 sapply, lapply, mapply. apply는 불가능.
apply(iris[,-5], c(1,2), mean)   # 원소별 적용 후 2차원 데이터 셋(행렬) 리턴
sapply(iris[,-5], mean)          # key별 적용 후 1차원 데이터 셋(벡터) 리턴

# 예제) 2차원 데이터 셋의 전체 적용 예
df1 <- data.frame(col1=1:5, col2=6:10)
df1[1,1] <- NA
f1 <- function(x) {
  if (is.na(x)) {
    return(100)
  } else {
    return(x*10)
  }
}

f1(df1)
apply(df1, c(1,2), f1)   # 2차원 적용 가능, 2차원 전체 반복 적용은  apply로만 가능하다. 1차원은 적용 불가능.
sapply(df1,f1)           # 불가, 2차원 데이터셋 전달시 key별 적용으로 바뀜. 
                         # 1차원일때 적용가능. 1차원에 대한 벡터의 원소별 반복 연산 적용.


# apply - 연습문제
# apply_test.csv 파일을 읽고
# 부서별 판매량의 총 합을 구하세요.
# 단, 각 쉘이 -인 경우는 0으로 치환 후 계산(치환함수의 적용으로 풀이)
ap <- read.csv('apply_test.csv', stringsAsFactors = F)

# step1) - NA값 동시 0으로 치환
ifelse(is.na(ap),0,ap)        # 2차원 적용 불가
str_replace_all(ap,'-','0')   # 2차원 적용 불가

f1 <- function(x) {
  if (is.na(x) | x=='-') {
    return(0)
  } else {
    return(x)
  }
}

f1(ap)                       # 2차원 적용 불가
ap <- apply(ap, c(1,2),f1)   # 2차원 적용 가능
sapply(ap[,-1],f1)           # 2차원 적용 불가


# step2) 연산 컬럼 숫자 컬럼으로 변경

ap <- as.data.frame(apply(ap, c(1,2),f1))
str(ap)

# sol1) 컬럼 하나씩 변경
ap$x2010 <- as.numeric(ap$X2010)
ap$x2011 <- as.numeric(ap$X2011)
ap$x2012 <- as.numeric(ap$X2012)
ap$x2013 <- as.numeric(ap$X2013)

# sol2) 동시에 여러 컬럼 숫자로 변경(2차원 적용)
as.numeric(ap[,-1])  # 형변환 함수는 2차원 데이터에 적용 불가. 1차원에만 적용 가능
ap[,-1] <- apply(ap[,-1], c(1,2), as.numeric)

# step3) 행별 총 합 출력
ap$total <- apply(ap[,-1],1,sum)

# step4) 부서번호 추출
str_split(ap$deptno.name,'-')[1]  # 층마다 첫번째 원소 추출 불가
f2 <- function(x) {
  str_split(x,'-')[[1]][1]
}

f2(ap$deptno.name)  # 벡터연산 불가
sapply(ap$deptno.name, f2)  # 벡터연산 가능
apply(ap$deptno.name, c(1,2), f2)  # 벡터연산 불가(2차원 적용 불가)

ap$deptno <- sapply(ap$deptno.name, f2)

# step5) 부서별 그룹연산 수행
ap
tapply(ap$total, ap$deptno, sum)


# doBy : 그룹별 연산을 수월하게 하는 함수
# sampleBy, orderBy, summaryBy
install.packages('doBy')
library(doBy)

# 1. 정렬 : order, sort, doBy::orderBy 
order(...,                  # 정렬 컬럼 또는 벡터
      na.last = TRUE,       # NA 배치 순서
      decreasing = FALSE)   # 정렬 순서

# 벡터의 정렬 : order보다는 sort 사용.
v1 <- c('a','f','d','c')
order(v1)       # 정렬된 값이 아닌 각 위치값이 순서대로 리턴
v1[order(v1)]   # 색인으로 처리해야 정렬된 값을 얻을 수 있음

sort(x,
     decreasing = F,
     ...)
sort(v1)  # 즉시 벡터의 정렬된 값을 얻을 수 있음

# 데이터 프레임의 정렬 : order사용이 데이터프레임을 그대로 출력함. 
#                        sort는 벡터의 정렬만 출력함. 
#                        sort는 절대로 데이터프레임 정렬 안된다.
emp <- read.csv('emp.csv', stringsAsFactors = F)

sort(emp$ENAME)
emp[order(emp$ENAME), ]   # Oracle에서 order by의 기능과 동일.

# 문제) emp에서 deptno 순으로 정렬하되, 같은 부서내에서는
# 연봉이 큰 순서대로 정렬하여 데이터프레임을 출력
emp[order(emp$DEPTNO, emp$SAL, decreasing = c(F,T)), ]   # decreasing 옵션은 각각 컬럼에 설정할 수 있는데, 
                                                         # 그럴경우는 컬럼순서에 맞추고 벡터로 묶어준다.
# in Oracle : order by deptno asc, sal desc

orderBy(formula = ,    # Y ~ X | Y ~ X1 + X2 + ... | ~ 정렬 컬럼(물결표시 뒤에 정렬컬럼 기입) : 컬럼의 방향 수식
        data = )       # 데이터 프레임
orderBy(~ DEPTNO + SAL, emp)     # SAL 오름차순(+ SAL)
orderBy(~ DEPTNO - SAL, emp)     # SAL 내림차순(- SAL). 컬럼앞에 +/-를 붙이면 각각 오름차순, 내림차순 설정이 된다.
orderBy(~ - DEPTNO - SAL, emp)   # DEPTNO, SAL 둘 다 내림차순.

# 연습문제) student.csv 파일을 읽고
# 남여 순서대로 데이터를 정렬하고, 같은 성별내에서는 키가 높은 순.
std <- read.csv('student.csv', stringsAsFactors = F)
gender <- ifelse(substr(std$JUMIN,7,7)==1,'1','2')
std$gender <- gender
std

# sol1) order
std$gender <- as.numeric(std$gender)
std[order(std$gender, std$HEIGHT, decreasing=c(F,T)), ]
str(std)

# sol2) orderBy
orderBy(~ gender - HEIGHT, std)

# 2. 요약 : summary, doBy::summaryBy
summary(iris)

summaryBy(formula = ,   # ~
          data = )      # 요약데이터

summaryBy(formula = Species ~ iris$Sepal.Length,
          data = iris)   # 평균만 출력

# 3. 추출 : sample, doBy::sampleBy









