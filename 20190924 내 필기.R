# apply 계열 함수(적용함수)
# - 그룹별(행별, 열별, 그룹별) 함수의 반복 적용 가능
# - 벡터의 원소별 반복 적용 가능
# - 출력 결과는 벡터, 리스트, 행렬
# - 데이터프레임 출력 불가(plyr패키지 활용)

# 1. apply(data,      -- 적용대상(주로 2차원) 
#          margin,    -- 적용방향(행별(1), 열별(2), 원소별(c(1,2)))
#          func,      -- 적용함수
#          ...)       -- 가변인자(함수의 추가 인자 나열 부분)
# ** 참고 : 파이썬 apply도 이와 유사하나 원소별 적용은 불가능
# ** 참고 : 파이썬에서는 원소별(c(1,2))가 applymap으로 적용가능하다.

df_iris <- iris[,1:4]
apply(df_iris, 2, mean)    # 출력결과 벡터
apply(df_iris, 1, sum)     # 출력결과 벡터

df_iris2 <- apply(df_iris, c(1,2), mean)  # 출력결과 행렬(2차원)
as.data.frame(df_iris2)
as.data.frame(apply(df_iris, 1, sum))

card <- read.csv('card_history.csv', stringsAsFactors = F)
card

library(stringr)
str_replace_all(card,',','')  # 2차원에 적용시 출력결과 2차원 유지 안됨.

f_replace <- function(x) {
  v1 <- as.numeric(str_replace_all(x,',',''))
  return(v1)
}
df_card <- as.data.frame(apply(card,c(1,2),f_replace)) ; df_card
df_card$total <- apply(df_card[,-1],1,sum) ; df_card

# apply 함수에 추가적 인자의 전달 방법
f_replace2 <- function(x,y) {
  v1 <- as.numeric(str_replace_all(x,y,''))
  return(v1)
}

apply(card,c(1,2),f_replace2,',')
apply(card,c(1,2),f_replace2,'[:punct:]')

# 2. 원소별 적용 함수(1차원 적용함수)
# - lapply(list, function) : 출력결과 주로 리스트
# - sapply(list, function) : 출력결과 주로 벡터
# - mapply(function, ...) : 출력결과 주로 벡터, 함수의 위치가 맨 앞에

v1 <- c(10,20,30)

f_add <- function(x) {
  return(x+10)
}

lapply(v1, f_add)   # 출력결과 리스트.
sapply(v1, f_add)   # 출력결과 벡터.
mapply(f_add, v1)   # 출력결과 벡터.
apply(v1, c(1,2), f_add)  # apply 적용은 2차원 데이터만 가능하다. 벡터는 불가능하다. 벡터 적용 불가.

# 3. 그룹별 적용 함수 : tapply()
# - oracle의 group by 기능과 유사(그룹별 함수 적용)
# - tapply(vector,  -- 연산대상
#           index,  -- 그룹벡터(group by 컬럼)
#        function)  -- 적용함수(주로 그룹함수)

# 예제) 부서별 sal의 총합
tapply(emp$SAL, emp$DEPTNO, sum)

# 연습문제1) 5이상이면 10을 곱하고, 미만이면 20을 곱하는 함수 생성,
# 아래 벡터 적용
v_2 <- 1:10
f_sub <- function(x) {
  if (x >= 5) {
    return(x*10)
  } else {
    return(x*20)
  }
}
lapply(v_2, f_sub)
sapply(v_2, f_sub)
mapply(f_sub,v_2)

f_sub2 <- function(x) {
  f0 <- c()
  for (i in x) {
    if (i >= 5) {
      f0 <- c(f0, i*10)
    } else {
      f0 <- c(f0, i*20)
    }
  }
  return(f0)
}

f_sub2(v_2)

# 연습문제2) professor 테이블에서 학과별 교수연봉의 평균
pr <- read.csv('professor.csv', stringsAsFactors = F)
tapply(pr$PAY, pr$DEPTNO, mean)  # aggregate, plyr::ddply  -- tapply보다 기능들이 좀 더 세분화 된 함수들.
aggregate(PAY ~ DEPTNO, data = pr, mean)
ddply(pr, .(DEPTNO), summarise, avg_PAY = mean(PAY))


# 연습문제3) 2000-2013년_연령별실업율_40-49세 파일을 읽고
# 2005년~2009년에 대해 각 월별, 년도별 실업률 평균
# 단, 년도 선택은 년도만 사용하여 표현, 예) year >= 2005
df3 <- read.csv('2000-2013년_연령별실업율_40-49세.csv', stringsAsFactors = F)

n1[-1] <- substr(colnames(no_job)[-1],2,5)    # 첫번째 컬럼 제외할때 덮어쓰는 대상에도 제외를 해준다. [-1]
n3[-1] <- str_sub(colnames(no_job)[-1], 2,5)  # 첫번째 컬럼 제외할때 덮어쓰는 대상에도 제외를 해준다. [-1]
n_1<- str_remove_all(colnames(no_job), '[X년]')
n2 <- no_job[, c(n1 >= 2005 & n1 <= 2009)]

n2$월별 <- apply(n2, 1, mean)
n2 <- rbind(n2,apply(n2, 2, mean))


colnames(df3) <- str_remove_all(colnames(df3), '[X년]')
colnames(df3)[-1] <- as.numeric(str_sub(colnames(df3)[-1],2,5)) # 첫번째 컬럼 제외할때 덮어쓰는 대상에도 제외를 해준다. [-1]. 
                                                                # 근데 컬럼이름은 숫자로 못바꾼다. 파이썬에선 가능.
df4 <- df3[ ,(colnames(df3) >= '2005') & (colnames(df3) <= '2009')]
apply(df4, 1, mean)  # 월별 평균
apply(df4, 2, mean)  # 년도별 평균

# [참고] sapply와 mapply 비교
# 1. 인자의 전달 순서
# sapply(list, function)   :  반드시 적용 데이터가 앞에 배치. 데이터가 반드시 있어야 한다.
# mapply(function, ...)    :  데이터가 없는 함수의 적용도 가능

# 2. 인자의 반복
# sapply(list, function, c(1,2), c(1,2))   :  4번 반복. f(1,1), f(1,2), f(2,1), f(2,2)
# mapply(function, c(1,2), c(1,2))         :  2번 반복. f(1,1), f(2,2)

# 예제) 정규분포를 따르는 다음의 집합을 생성
# set1) 평균이 0, 표준편차가 1인 5개 집합
# set2) 평균이 10, 표준편차가 2인 10개 집합
# set3) 평균이 100, 표준편차가 3인 15개 집합
rnorm(n=5, mean = 0, sd = 1)
rnorm(n=10, mean = 10, sd = 2)
rnorm(n=15, mean = 100, sd = 3)

mapply(rnorm, c(5,10,15), c(0,10,100), c(1,2,3))    # f(5,0,1), f(10,10,2), f(15,100,3)으로 수행

# 다음의 벡터에서 ab, BC 출력
v1 <- c('abc','ABC')
sapply(v1, str_sub, c(1,2), c(2,3))  # 인자의 반복 전달 불가
mapply(str_sub,v1,c(1,2),c(2,3))     # 인자의 반복 전달 가능. f(1,2), f(2,3)






