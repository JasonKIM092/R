# 실습문제
getwd()
# 1. emp.csv 데이터를 활용하여
emp <- read.csv('emp.csv', stringsAsFactors = F)
str(emp)
emp
# 1) 1월에 입사한 직원의 이름, 입사일, 연봉 출력 
emp$HIREDATE <- as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M') ; emp$HIREDATE
as.character(emp$HIREDATE, '%m') == '01'  # '01' : 문자처리가 되어 있어서 문자로 표현해야 한다.
emp[as.character(emp$HIREDATE, '%m') == '01', c('ENAME', 'HIREDATE', 'SAL')]

emp[as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'), '%m')=='01',]

# 형 변환 함수
as.numeric('1')
as.character(날짜, format=변경할포멧)
as.Date(날짜, format = 파싱할포멧)

# 2) 다음의 계산식으로 퇴직금 계산 후 R_PAY 컬럼으로 추가
# (퇴직금 = 현재 SAL * trunc(근속년수/12))
w_year <- trunc((Sys.Date() - emp$HIREDATE)/365) ; w_year  # 근속년수
emp$R_PAY <- emp$SAL * trunc(w_year/12)
emp$R_PAY <- as.numeric(emp$R_PAY)
emp
str(emp)

# 3) empno 컬럼값을 rowname으로 설정
# step1) rowname 변경
rownames(emp) <- emp$EMPNO

# step2) 변경한 컬럼 삭제
# sol1) 컬럼 위치를 아는 경우
emp <- emp[ , -1] ; emp

# sol2) 컬럼 위치를 모르는 경우
emp[ , colnames(emp) != 'EMPNO']  # ename컬럼의 위치를 모를때 해당 컬럼을 제외할때. colnames대신 names라고만 써도 갠춘.

# 참고 : 여러개 컬럼 동시 제외(%in% 사용)
emp[ , !names(emp) %in% c('EMPNO', 'JOB','SAL')]

# 4) KING 행 삭제
# sol1) 행 위치를 아는 경우
emp <- emp[ -9, ] ; emp

# sol2) 행 위치를 모르는 경우
emp[ emp$ENAME != 'KING', ]


# 2. 다음의 데이터 생성 
# no  name  price   qty  
# 1   apple   500     5  
# 2   banana  200     2  
# 3   peach   200     7  
# 4   berry    50     9

no <- 1:4
name <- c('apple','banana','peach','berry')
price <- c(500,200,200,50)
qty <- c(5,2,7,9)
fr <- data.frame(no = no,
                 name = name,
                 price = price,
                 qty = qty,
                 stringsAsFactors = F)
fr

# 1) 5번째 과일 추가 (5, mango, 100원, 10개)
str(fr)
fr <- rbind(fr, c(5,'mango',100,10))
fr
fr$no <- as.integer(fr$no)
fr$price <- as.numeric(fr$price)
fr$qty <- as.integer(fr$qty)
fr$name <- as.factor(fr$name)


# data.frame 함수.
#1)
head(emp,2)
emp[1:2,]  # head(emp,2) = emp[1:2,] 같은 기능...
#2)
tail(emp,2)
#3)
View(emp)

class(emp) # 객체의 종류 혹은 데이터 타입 확인(벡터의 경우는 데이터 타입을 출력하고, 벡터가 아닌 다른 데이터의 경우는 객체의 종류가 나온다.)
v1 <- 1:10
class(v1)

# Array
# - 다차원
# - 동일한 데이터 타입만 허용

# -            R              Python
# - 2차원   (행, 열)         (행, 열)
# - 3차원   (행, 열, 층)     (층, 행, 열)


#1. Array 생성
a1 <- array(1:12, c(2,2,3))

#2. Array 색인
a1[,,1]          # 1층 선택. 차원축소발생
a1[,,1,drop=F]   # 1층 선택. 차원축소방지
a1[1,,1]         # 1층, 1행 선택. 차원축소발생
a1[1,,1,drop=F]  # 1층, 1행 선택. 차원축소방지


#[연습문제]
# emp.csv 파일을 읽고
emp <- read.csv('emp.csv', stringsAsFactors = F)
emp
str(emp)

# 1) smith와 allen의 이름과 sal을 출력
emp[emp$ENAME %in% c('SMITH','ALLEN'), c('ENAME','SAL')]

# 2) 10번 부서 직원의 평균 sal 출력
mean(emp[emp$DEPTNO == 10,'SAL'])

# 3) sal이 1000이상이면서 job이 MANAGER인 직원 출력
emp[(emp$SAL >= 1000) & (emp$JOB == 'MANAGER'), ]

# 4) comm의 NA를 0으로 치환
is.na(emp$COMM)
emp$COMM[is.na(emp$COMM)] <- 0 ; emp   # 벡터로 수정
emp[is.na(emp$COMM), 'COMM'] <- 0 ; emp   # 데이터 프레임으로 수정
ifelse(is.na(emp$COMM),0,emp$COMM)






# if문 : 조건에 따른 치환 및 명령어의 실행을 위한 문장
s1 <- 10
v1 <- c(10,20,10)

# 예제 : 10이면 인사부 그 외는 총무부로 치환
if (v1 == 10) {    # if문은 여러개의 조건의 결과에 대한 치환 불가. 단 한개의 조건만 써야한다. 조건문의 반복처리 불가.
  '인사부'         # for문과 함께 사용, ifelse문을 사용해야 반복적 처리가 가능하다. 반복문을 사용해야 반복리턴이 가능.
} else {
  '총무부'
} 


if (emp$DEPTNO == 10) {    # 전체컬럼에 대한 치환은 if문으로 불가능하다.
  '인사부'
} else {
  '총무부'
}

# ifelse
# - oracle의 decode와 비슷
# - 조건문의 반복처리 가능
# - 리턴만 가능(조건에 따른 명령어 처리 불가)
# - 마지막 인자(거짓리턴값) 절대 생략 불가

ifelse(조건,참리턴,거짓리턴)
ifelse(v1==10,'인사부','총무부')
ifelse(emp$DEPTNO == 10, '인사부','총무부')

c1 <- c(10,NA,20,30)
ifelse(is.na(c1),0,c1)

# [참고 : in oracle]
# decode(s1,10,'인사부','총무부')
# case when s1 = 10 then '인사부'
#                   else '총무부'
# end

# 예제 : 10이면 인사부 20이면 총무부로 그 외는 재무부로 치환
if (s1 == 10) {
  '인사부'
} else if (s1 == 20) {     # else if가 들어가도 벡터등과 같은 여러개의 데이터가 포함된 데이터타입은 여전히 처리가 원하는 결과로 나오지 않는다.
  '총무부'
} else {
  '재무부'
}


ifelse(v1 == 10, '인사부',
                 ifelse(v1 == 20, '총무부','재무부'))


No <- 1:4
Name <- c('홍길동','김길동','최길동','박길동')
pay <- c(3000,2000,2500,1000)
data1 <- data.frame(No = No,
                    Name = Name,
                    pay = pay,
                    stringsAsFactors = F)
data1
grade <- ifelse(data1$pay>=3000,'A',ifelse(data1$pay>=2000,'B','C')) ; grade
data1$grade <- grade ; data1

# for문(반복문) - 횟수기반
for (i in 1:10){
  print(i)
}

i <- 1
while (i <= 10) {
  print(i)
    i <- i + 1
}

i <- 1
while (i <= 9) {
  i <- i + 1
  print(i)
}
  
emp$SAL*1.1

for (i in emp$SAL) {
  print(i*1.1)  # 실행문에 emp$SAL 대신 i 사용함에 주의
}

emp$NEW_SAL <- for (i in emp$SAL){
                    print(i*1.1)
                          }   # 컬럼으로 저장이 안되는 이유 : 벡터가 아니다. 컬럼의 원소의 묶음은 벡터이다. 그러므로 컬럼 생성시에도 벡터형태로 생성을 해야 한다. 벡터는 데이터가 저장된 형태이다. 프린트는 출력역할이지 벡터저장역할이 아니다. 따라서 프린트를 사용하면 벡터형태가 아니므로 컬럼으로 추가될 수 없다. for문 자체 결관과는 벡터가 될 수 없으며, for문 내부에서 벡터를 생성해줘야 한다.
                              # 컬럼생성 불가 : for문의 결과는 벡터가 아님.

emp

for (i in emp$SAL){
  NEW_SAL <- i*1.1   # 벡터생성이 안되는 이유 : 매 반복마다 NEW_SAL에 연산의 결과가 덮어씀.
}

NEW_SAL2 <- c()  # 빈 벡터 생성
for (i in emp$SAL){
  NEW_SAL2 <- c(NEW_SAL2, i*1.1)   # NEW_SAL2 자체가 선언되지 않은 상태이므로. 일단 NEW_SAL2를 빈 벡터로 선언을 먼저 해줘야 한다. NEW_SAL2 <- c(). for문은 그냥 연산만 하는 기능이지 벡터 저장의 기능이 없다. 
}
NEW_SAL2
emp$NEW_SAL2 <- NEW_SAL2 ; emp

# 예제 : 10이면 인사부 그 외는 총무부로 치환 (if + for)
for (i in emp$DEPTNO) {  # 컬럼생성 불가. 벡터선언 안해줌.
  if (i == 10) {
    print('인사부')
  } else {
    print('총무부')
  }
}  # for문은 리턴값을 직접 출력하지 않는다. 그래서 print, 벡터명령어(빈벡터 선언 후 벡터선언)를 사용하는 것. for문은 명령수행역할이다. if문은 리턴값을 출력한다.

v_dname <- c()
for (i in emp$DEPTNO) { 
  if (i == 10) {
    v_dname <- c(v_dname,'인사부')  # c() 대신 append() 사용 가능.
  } else {
    v_dname <- c(v_dname,'총무부')
  }
}
emp$v_dname <- v_dname ; emp

# [ 연습문제 ]
# 1. 부서번호가 10이면 인사부, 20이면 총무부, 그 외는 재무부로 변경된
# 부서명을 dname2 컬럼으로 추가
dname3 <- c()
for (i in emp$DEPTNO) {
  if (i == 10) {
    dname3 <- c(dname3, '인사부')  # c()사용
  } else if (i == 20) {
    dname3 <- c(dname3, '총무부')
  } else {
    dname3 <- c(dname3, '재무부')
  }
}
emp$dname3 <- dname3 ; emp

dname4 <- c()
for (i in emp$DEPTNO) {
  if (i == 10) {
    dname4 <- append(dname4, '인사부')  # append() 사용
  } else if (i == 20) {
    dname4 <- append(dname4, '총무부')
  } else {
    dname4 <- append(dname4, '재무부')
  }
}
emp$dname4 <- dname4 ; emp

dname2 <- ifelse(emp$DEPTNO == 10, '인사부', ifelse(emp$DEPTNO == 20,'총무부','재무부')) ; dname2
emp$dname2 <- dname2 ; emp

# 2. NEW_SAL3 컬럼 추가, 아래 조건과 같다.
# (연봉이 2000미만 연봉인상률 10%,
#  2000이상 3000미만 연봉인상률 9%,
#  3000이상 8%)
NEW_SAL3 <- ifelse(emp$SAL < 2000, emp$SAL*1.1, ifelse(emp$SAL < 3000, emp$SAL*1.09, emp$SAL*1.08));NEW_SAL3
emp$NEW_SAL3 <- NEW_SAL3; emp

NEW_SAL4 <- c()
for (i in emp$SAL) {
  if (i < 2000) {
    NEW_SAL4 <- c(NEW_SAL4, i*1.1)
  } else if (i < 3000) {
    NEW_SAL4 <- c(NEW_SAL4, i*1.09)
  } else {
    NEW_SAL4 <- c(NEW_SAL4, i*1.08)
  }
}
emp$NEW_SAL4 <- NEW_SAL4; emp

student <- read.csv('student.csv')
str(student)
format(student$var, scientific = FALSE)
student
# while문(반복문) - 조건기반
