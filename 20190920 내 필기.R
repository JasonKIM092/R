#산술함수
v1 <- c(1,2,3,NA,4,5,6,7,8)

sum(v1)   # NA리턴
mean(v1)  # NA리턴
sum(v1, na.rm = T)   # NA제외 후 계산
mean(v1, na.rm = T)  # NA제외 후 계산(3개의 평균)  != sum(v1, na.rm = T) / 4
mean(ifelse(is.na(v1),0,v1))  # 4개의 평균(/4). NA를 0으로 치환하는 방법은  ifelse.
sum(ifelse(is.na(v1),0,v1))

# 연습문제)
# 1) 다음의 벡터에 반복문을 사용하여 10% 인상된 가격의 총 합을 구하여라
v1 <- c(1000,1500,NA,3000,4000)
sum(v1*1.1, na.rm = T)
sum(ifelse(is.na(v1),0,v1*1.1))

v_sum <- 0
for (i in v1) {
  if (is.na(i)) {
    next
  }
  v_sum <- v_sum + i*1.1
}
v_sum

# 2) 위의 벡터에서 NA를 발견하기 전까지의 값만 출력
for (i in v1) {
  if (is.na(i)){    
    break
  } 
  print(i)      # 여기에 print(i)를 쓰면 NA출력 안됨
}


for (i in v1) {
  print(i)      # 여기에 print(i)를 쓰면 NA출력됨
  if (is.na(i)){
    break
  } 
}

# sum과 mean 주의사항
sum(..., na.rm = FALSE)   # 나열된 인자의 합 가능
mean(x, ...)              # 나열된 인자의 평균 불가, 벡터의 평균만 가능.
# ... : 가변인자.


sum(1,2,3)    # 1+2+3 가능
mean(1,2,3)   # 첫번째 인자의 평균만 리턴

sum(c(1,2,3))    # 1+2+3 수행
mean(c(1,2,3))   # 1,2,3 평균 리턴





# 사용자 정의 함수
함수명 <- function(인자1, 인자2, ...) {  #인자는 이름을 가질 수 있음
  cmd1
  cmd2
  ...
  return(출력값)  # 리턴하지 않으면 함수 수행 결과가 보이지 않음
}

# 예1) abs기능을 갖춘 f_abs 함수 생성
abs(1)
abs(2)
abs(-3)

f_abs <- function(x) {
  if (x >= 0) {
    return(x)
  } else {
    return(-1 * x)
  }
}

f_abs(4)
f_abs(0)


# 예2) 두 수를 전달받아 합을 리턴(만약 두번재 인자 생략시 0을 전달)
f_sum <- function(x,y=0) {
  return(x+y)
}

f_sum(1,10)
f_sum(x = 1, y = 10)
f_sum(y = 1, x = 10) # 인자의 순서를 바꾸고 싶을 시, 이렇게 선언해주면 된다.
f_sum(1)

# sign 함수의 기능을 갖춘 f_sign함수 생성
sign(10)
f_sign <- function(x) {
  if (x > 0) {
    return(1)
  } else if (x == 0) {
    return(0)
  } else {
    return(-1)
  }
}


# 연습문제1) 사용자 정의함수 if 3번
myf3 <- function(x,y) {
  if (x > y) {
    return(x-y)
  } else {
    return(y-x)
  }
}

# 연습문제2) 사용자 정의함수 if 5번
y_1 <- function(x) {
  if (x %in% c('Y','y')) {         # (x=='y' | x=='Y') 이렇게 써도 댐.
    return('Yes')
  } else {
    return('Not Yes')
  }
}

# 연습문제3) f_sum(10) = 1+2+3+...+10 수행되는 함수 생성
f_sum <- function(x) {
  v_sum <- 0
  for (i in 1:x) {
    v_sum <- v_sum +i
  }
  return(v_sum)
}


f_sum2 <- function(x) {
  if (x==1) {
    return(1)
  } else {
    return(f_sum2(x-1) + x)
  }
}


# [연습문제] f_fact(10) = 10*9*8*7*6*...*1 표현 (10!)
factorial(3)

#
f_fact <- function(x) {
  if (x==1) {
    return(1)
  } else {
    return(f_fact(x-1)*x)
  }
}
f_fact(3)

f1 <- function(x) {
  if (x == 1) {
    return(1)
  } else {
    return(f1(x-1)*x)
  }
}

#
f_fact2 <- function(x) {
  v_sub <- 1
  for (i in 1:x) {
    v_sub <- v_sub * i
  }
  return(v_sub)
}
f_fact2(3)

f2 <- function(x) {
  v_s <- 1
  for (i in 1:x) {
    v_s <- v_s * i
  } 
  return(v_s)
}


f1 <- function(x) {
  if(x==1) {
    return(1)
  } else {
    return(f1(x-1)*x)
  }
}
f1(3)


f2 <- function(x) {
  v_f <- 1
  for (i in 1:x) {
    v_f <- v_f * i
  }
  return(v_f)
}
f2(3)

# 실습) self call을 활용한 피보나치 수열의 출력
# i    1  2  3  4  5  6  7  8  9  10
# v    1  1  2  3  5  8  13 ...

f_fibo(1) = 1
f_fibo(2) = 1
f_fibo(3) = 1 + 1 = f_fibo(2) + f_fibo(1)
f_fibo(4) = 1 + 2 = f_fibo(3) + f_fibo(2)
...
f_fibo(10) = f_fibo(9) + f_fibo(8)


f_fibo <- function(x) {
  if (x==1) {
    return(1)
  } else if (x==2) {
    return(1)
  } else {
    return(f_fibo(x-1) + f_fibo(x-2))
  }
}
f_fibo(7)

f_fibo2 <- function(x) {
  if (x==1 | x==2) {
    return(1)
  } else {
    return(f_fibo(x-1) + f_fibo(x-2))
  }
}
f_fibo2(7)


# 가변인자
f_sum3 <- function(...) {
  v1 <- list(...)
  v_sum <- 0
  for (i in v1) {
    v_sum <- v_sum + i
  }
  return(v_sum)
}
f_sum3(1,2,7,8,10)

# 변수 삭제 및 확인
ls()   # 변수 목록 확인
rm(list='a')    # 메모리상에서 특정 변수 삭제
rm(list=ls())   # 메모리상에서 전체 변수 삭제








# 1. 사용자 정의 함수 생성

# 벡터연산이 불가한 경우 대체방법
# 1) for문
# 2) 적용함수 - apply계열함수 : 내부적으로 for문이 자동적으로 적용이 된다.
#               - sapply(list : 적용대상, function : 적용함수이름)

# 1) f_substr(data,start,n) : oracle 문법과 동일하게
v1 <- 'abcdef'
f_substr(v1,3,2) = 'cd'

f_substr <- function(data, start=1, n='NA') {     #  substr이 벡터연산이 가능한 함수이므로 해당 수식을 통해서 벡터연산이 가능하다.
  return(substr(data,start,start + n - 1))
}

f_substr1 <- function(data, start=1, n='NA') {
  if (n=='NA') {
    return(substr(data,start,str_length(data)))
  } else {
    return(substr(data,start,start + n - 1))
  }
}

f_substr(pr$ID,1,3)  # 벡터에서도 수행됨.
substr(pr$ID,1,3)

f_substr = function(data, start=1, n='NA') {
  if (n=='NA') {
    return(str_sub(data,start,str_length(data)))  # 스칼라에 대한 렝쓰 처리는 1이 나오는데, 
    # 전체의 길이를 구할때는 스트링 렝쓰를 쓴다. 
    # 스트링렝쓰는 벡터의 원소마다 원소의 길이, 
    # 렝쓰는 벡터원소의 갯수
    # (스칼라는 벡터에서 원소 1개가 됨. ex) 'abcd'는 벡터로 치면 원소 1개.)
    # str_length(v1)과 length(v1)의 차이.
  } else {
    return(str_sub(data,start,start + n - 1))
  }
}
# substr과 str_sub의 차이 : 두번째 인자에 -가 들어갈 수 있느냐 없느냐의 차이.
substr('abcdef',-4,4)
str_sub('abcdef',-4,4)
str_sub('abcdef',3)


f_substr(v1,-3,2)
substr(v1,3,4)

f_substr(v1,3,3)
substr(v1,3,3)

f_substr(v1,2,4)
substr(v1,2,4)

f_substr(v1,1,4)
substr(v1,1,4)
# R에서 substr의 세번째 인자의 숫자는 두번째 인자의 숫자보다 크면 안된다.



# 2) instr(data,pattern,start,n) : oracle 문법과 동일하게
v5 <- 'a#b#c#d#'
instr(v5,'#',3,1)  =  4
# 1) start부터 끝가지 문자열 우선 추출 => 'b#c#d#'
str_sub(v5,3)
# 2) 추출된 위치로부터 n번째 확인된 pattern의 위치 확인
str_locate('b#c#d#','#')[1,1] = 2
str_locate('b#c#d#','#')
str_locate_all('b#c#d#','#')[[1]][ ,1]
# 3) 위의 연산 결과로 함수의 리턴값 생성 => 3 + 2 - 1 = 4

instr <- function(data,pattern,start=1,n) {
  v_str <- str_sub(data,start)
  v_lo <- str_locate_all(v_str,pattern)[[1]][n,1]
  return(start+v_lo-1)
}

instr1 <- function(data,pattern,start=1,n) {
  v_str <- str_sub(data,start)
  v_lo <- str_locate_all(v_str,pattern)[[i]][n,1]    #  for문 i.
  return(start+v_lo-1)
}

str_locate_all(pr$EMAIL,'@')

instr(pr$EMAIL,'@')  # 벡터연산 불가능 : str_locate_all(v_str,pattern)[[1]][n,1]. [[1]]이것땜에 1층 값밖에 안나옴...
pr <- read.csv('professor.csv',stringsAsFactors = F)

sapply(pr$EMAIL, instr) # sapply에 적용하고자 하는 함수가 데이터 이외의 추가적 인자를 요구한다면 이렇게 하믄 안된다.
sapply(pr$EMAIL, instr, '@') # 이런식으로 해야 한다. 우리가 원하는 데이터는 '@'의 위치이므로. 가변형인자 허용됨.
sapply(pr$EMAIL, instr, '@')
# 벡터에 쉘이름 자동적으로 부여됨. 수정시 : names <-





# 3) f_mgr 함수를 생성하여 사번을 입력하면 해당 사원의 매니저 이름을 출력
#    (단, 매니저 번호가 없는 경우 본인 이름 출력되도록)
emp
f_mgr(7369) = 'FORD'
f_mgr(7839) = 'KING'
emp[emp$EMPNO == emp[emp$EMPNO ==7369,'MGR'], 'ENAME']


f_mgr <- function(x) {
  v_mgr <- c()
  for (i in x) {
    if (is.na(emp[emp$EMPNO == i,'MGR'])) {
      v_name <- emp[emp$EMPNO == i,'ENAME']
      v_mgr <- c(v_mgr, v_name)
    } else {
      v_name <- emp[emp$EMPNO == emp[emp$EMPNO == i,'MGR'], 'ENAME']
      v_mgr <- c(v_mgr, v_name)
    }
  }
  return(v_mgr)
}


f_mgr1 <- function(x) {
  v_mgr <- c()
  for (i in x) {
    if (is.na(emp[emp$EMPNO==i,'MGR'])) {
      v_name <- emp[emp$EMPNO==i,'ENAME']
      v_mgr <- c(v_mgr, v_name)
    } else {
      v_name <- emp[emp$EMPNO == emp[emp$EMPNO==i,'MGR'], 'ENAME']
      v_mgr <- c(v_mgr, v_name)
    }
  }
  return(v_mgr)
}

f_mgr(7369)
f_mgr(emp$EMPNO)
f_mgr(7839)

# 2. emp.csv 파일을 읽고
emp <- read.csv('emp.csv',stringsAsFactors = F) ; emp
st <- read.csv('student.csv',stringsAsFactors = F) ; st

# 1) SAL이 3000이상이면 SAL의 10%를, 미만이면 8%를 출력하는 함수 생성

s_sal <- function(x) {
  if (x >= 3000) {             # 벡터연산이 안되는 조건. if는 벡터연산이 되지 않음. if는 벡터연산 불가(첫번째 결과만 기억)
    return(x*1.1)
  } else {
    return(x*1.08)
  }
}

s_sal(1000)
s_sal(emp$SAL)   # 벡터 전달 시 첫번째 원소의 증가율(8%)에 맞게 계산됨.

# sol1) for문
s_sal2 <- function(x) {
  v_sal <-c()
  for (i in x) {
    if (i >= 3000) {
      v_sal <- c(v_sal, i*1.1)
    } else {
      v_sal <- c(v_sal, i*1.08)
    }
  }
  return(v_sal)
}
s_sal2(emp$SAL)

# sol2) 적용함수
sapply(list,funtion)  # 내부적으로 for문이 자동적용.
sapply(emp$SAL, s_sal)

# 3. professor.csv 파일을 읽고
pr <- read.csv('professor.csv', stringsAsFactors = F) ; pr
# 1) id에서 특수문자를 포함하는 직원은 삭제된 형태로 변환
# 1) id에서 특수문자 제외
str_remove_all(pr$ID,'[-_!@#]')
v_id <- c('a_1','b-c','c#','d@@')
str_remove_all(v_id,'[-_!@#]')
str_remove_all(v_id,'[:punct:]')    # '[:punct:]' : 모든특수문자라는 표현! 발생가능한 모든 특수문자를 표현하는 표현식이다.

# 2) id에 특수문자를 포함하는 행을 제외(삭제)
pr[!str_detect(pr$ID,'[:punct:]'), ]


###########################################################

#[참고] 대소문자 변경
toupper('abc')
tolower('ABC')

stringr::str_to_upper('abc')
stringr::str_to_lower('ABC')
stringr::str_to_title('abc')  # 맨 앞자리만 대문자로 치환. Oracle에서 initcap

str_replace('abcde','[ae]',str_to_upper)      # Abcde
str_replace_all('abcde','[ae]',str_to_upper)  # AbcdE
str_replace_all('abcde','[ae]',toupper)
str_replace('abcde','[ae]',toupper)

# 머신러닝
# 1. 지도학습(Y값 존재 : target)
# 1) 회귀 기반 모델(Y가 연속형)
# 2) 분류 기반 모델(Y가 Factor형(범주형))

# 2. 비지도 학습(Y값 존재 無 : target 無)

iris
str(iris)
