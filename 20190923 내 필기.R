# [사용자 정의 연습문제] 스칼라, 벡터 적용 모두 고려
# 1. nvl함수와 똑같은 f_nvl함수를 생성
nvl(column, value)
f_nvl <- function(x, y) {
  v_nvl <- c()
  for (i in x) {
    if (is.na(i)) {   #### 벡터 연산이 불가한 원인
      v_nvl <- c(v_nvl,y)
    } else {
      v_nvl <- c(v_nvl,i)
    }
  }
  return(v_nvl)
}


str_repl

v1 <- c(NA,1,2,3)
f_nvl(v1, 0)

nvl <- function(x,y) {
  if (is.na(x)) {
    return(y)
  } else {
    return(x)
  }
}

nvl(999,0)
nvl(NA,0)
nvl(emp$COMM,0)  # 벡터연산 불가.

sapply(emp$COMM, nvl, 0)

nvl1 <- function(x,y) {
  v_comm <- c()
  for (i in x) {
    if (is.na(i)) {
      v_comm <- c(v_comm,y)
    } else {
      v_comm <- c(v_comm,i)
    }
  }
  return(v_comm)
}

nvl1(v1,0)

 
# 2. f_split(data,sep=',',n=1) 생성
# data를 sep로 나눈 n번째 값 리턴
# f_split('a/b/c/d','/',2) = b
str_split('a/b/c/d','/')[[1]][2]

f_split <- function(data,sep=',',n=1) {
  return(str_split(data,sep)[[1]][n])   #### 벡터연산이 불가한 이유
}
f_split('a/b/c/d','/',2)

v1 <- c('a/b/c/d','aa/bb/cc/dd')
f_split(v1,'/',2)

# sol1)
sapply(v1, f_split, '/', 2)

# sol2)
str_split(v1,'/')   # 벡터연산이 되는 함수이지만, 추출결과값이 리스트라서 for문이 반드시 필요한 함수이다. 
                    # str_split은 벡터연산이 잘되나 추출(색인)이 불가.
f_split2 <- function(data,sep=',',n=1) {
  v_split <- c()
  for (i in 1:length(data)) {   # 렝쓰가 리스트를 만나면 층의수, 벡터를 만나면 벡터원소의 갯수
  v_split <- c(v_split,str_split(data,sep)[[i]][n])
  }
  return(v_split)
}
f_split2(v1,'/',2)
str_length(v1)

# 3. f_bonus라는 함수를 생성, 각 직원의 보너스를 출력
# (입사일이 1985년 이전인 경우는 근속년수 * 100, 이후인 경우는 90으로 계산)
emp[as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'), '%Y') == '1980', ]
str(emp)
trunc((Sys.Date()-emp$HIREDATE)/365)

f_bonus('2011-09-21') = 8 * 90

trunc((Sys.Date() - '2011-09-21') / 365)
as.Date('2011-09-21')

f_bonus <- function(x) {
  x <- as.Date(x,'%Y-%m-%d')
  v_year <- as.numeric(trunc((Sys.Date() - x) / 365))
  if (x < as.Date('1985-01-01')) {   #### 벡터연산이 불가한 이유
    return(v_year * 100)
  } else {
    return(v_year * 90)
  }
}
f_bonus('2011-09-21')
f_bonus(emp$HIREDATE)

# sol1)
sapply(emp$HIREDATE, f_bonus)

# sol2)
f_bonus2 <- function(x) {
  v_bonus <- c()
  for (i in x) {
    i <- as.Date(i,'%Y-%m-%d')
    v_year <- as.numeric(trunc((Sys.Date() - i) / 365))
    if (i < as.Date('1985-01-01')) {
      v_bonus <- c(v_bonus, v_year * 100)
    } else {
      v_bonus <- c(v_bonus, v_year * 90)
    }
  }
  return(v_bonus)
}


f_bonus2 <- function(x) {
  v_bonus <- c()
  for (i in x) {
    i <- as.Date(i)
    v_year <- as.numeric(trunc((Sys.Date() - i) / 365))
    if (i < as.Date('1985-01-01')) {
      v_bonus <- c(v_bonus, v_year * 100)
    } else {
      v_bonus <- c(v_bonus, v_year * 90)
    }
  }
  return(v_bonus)
}

f_bonus2(emp$HIREDATE)

emp <- read.csv('emp.csv', stringsAsFactors = F)

f_add <- function(x) {
  return(x+100)
}
v1 <- 1:10
f_add(v1)


# 외부 파일 불러오기
# 1. read.csv : ','로 구분된 파일(csv파일)을 불러오기 위한 함수
# 1) header = TRUE : 맨 첫 줄을 컬럼화 할지 여부(디폴트값 : TRUE)
# 2) sep = "," : 탭 분리구분기호
read.table('test1.txt', header=T, sep = ",")

# 3) na.strings = "NA" : NA처리(인식)가 필요한 문자열 지정
df1 <- read.csv('test1.txt')
str(df1)  # c컬럼 문자('-'때문에)

df1 <- read.csv('test1.txt', na.strings=c('-','.'))
str(df1)  # c컬럼 숫자('-'가 NA커리 됨)

# 4) nrows = -1 : 일부 행의 수만 불러오는 옵션. 일부 행의 수만 불러오기
read.csv('emp.csv', nrows = 4)

# 5) skip = 0 : 일부 행을 스킵하여 불러오기
read.csv('test1.txt', skip=1)

# 6) stringsAsFactors

# 7) encoding = 'cp949' : 타 외국어 깨지는거 방지하는거 

help('read.csv')
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = default.stringsAsFactors(),
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)


read.table('test1.txt', header=T, sep = ",")
df1 <- read.csv('test1.txt')
str(df1)

# 특수기호가 들어간 숫자컬럼은 문자가 된다.

# 적용함수
# apply(array, margin, ...)
# lapply(list, function)
# tapply(vector, index, function)
# sapply(list, function)
# mapply(function, ...)
