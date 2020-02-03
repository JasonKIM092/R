# substr 함수 오라클과 R의 차이 substr(a,b,c)
# 오라클에서는 세번째 인자(c)가 문자의 갯수이고,
# R에서는 세번째 인자(c)가 해당문자의 위치이다.

install.packages('stringr')
library('stringr')

# stringr : 문자포함여부 확인 함수

# 1. str_detect()
# - 패턴 포함 여부 확인 
# - oracle에서 like 연산자와 비슷
# - 정규식 표현식 사용가능(^:시작, $:끝, .:하나문자, []:포함 ...)
str_detect(string = 문자열 또는 문자열벡터, pattern = '패턴')
v1 <- c('abc','bcd','Abcd', 'bac','bcda')
str_detect(v1,'a')   # 'a'를 포함하는(like '%a%')
                     # 대소문자 구분함!!
v1[str_detect(v1,'a')]
str_detect(v1,'^a')  # 'a'로 시작하는(like 'a%')
v1[str_detect(v1,'^a')]
str_detect(v1,'a$')  # 'a'로 끝나는(like 'a%')
v1[str_detect(v1,'a$')]
str_detect(v1,'.a')  # '?a'를 포함하는(like '%_a%')
str_detect(v1,'^.a') # 두번째가 'a'인(like '_a%'). '.a': 위치상관없이 a가 두번째가 아니더라도 a 앞에 어떤 글자가 몇개 상관없이와도 된다. 그래서 '^.a'요로케 써줘야 댐.
v1[str_detect(v1,'.a')]
v1[str_detect(v1,'^.a')]
str_detect(v1,'^[a,A]') # 'a' 또는 'A'로 시작하는 (대소문자 둘다 추출하는 방법)
str_detect(v1,'^[a,A][b,B]') # 대소상관없이 a가 첫번째글자, b가 두번째글자. 첫번째글자가 'a' or 'A', 두번째가 'b' or 'B'
str_detect(v1,'^[a,A,b,B]') # 첫글자가 대소상관없이 a 또는 b. 'a' or 'A' or 'b' or 'B'로 시작하는. [] 대괄호 자체가 한 단어를 뜻한다.

# 2. str_count
# - 특정 문자열의 포함 횟수 출력(갯수도 함께 출력)
str_count(v1,'a')

# 3. str_c
# - 문자열 결함함수
# - 오라클의 concat 또는 연결연산자(||)와 비슷
# - 옵션 sep = ';' : 결합시 연결기호. 일반 결합시 사용. 인자별 결합.
# - 옵션 collapse = ';' : 결합시 연결기호. 벡터 내부 원소결합 시. 벡터 내부 결합시 사용. 
#                         컬럼 결합시에도 컬럼의 결과값을 한개로 만들기 위해서는 collapse = '' 혹은  collapse = ' '를 꼭 써야 한다.

str_c('a','b','c') # abc
str_c('a','b','c', sep = ';') # a;b;c
str_c('a','b','c', sep = ' ')
str_c(c('a','b','c'),' is...')  # "a is..." "b is..." "c is..."
str_c(c('a','b','c'), sep = ';') # 벡터 내부에서는 적용이 안됨. 벡터 내부 결과는 수행안함.
str_c(c('a','b','c'),' is...',sep = ';')  # ,(컴마)사이에 적용이 되는 것임.
str_c(c('a','b','c'), collapse = ';')  # 벡터 내부의 결합에는 collapse 옵션사용!  a;b;c

v_name <- c('smith','allen','hong')
#1)
#smith+
#allen+
#hong+
str_c(v_name,'+')

#2) smith+allen+hong
str_c(v_name, collapse = '+')


# 연습문제)
# emp 테이블을 사용하여 각 행마다 다음과 같이 출력
# smith의 연봉은 800입니다.
emp
str_c(emp$ENAME,'의 연봉은 ',emp$SAL,'입니다.')

# 4. str_length
# - 벡터의 각 원소의 크기

length(v1)   # v1의 원소의 개수
str_length(v1)   # v1의 원소별 문자열의 크기

# 5. str_locate
# - 특정 문자열의 위치를 리턴
# - 오라클의 instr과 비슷
# - 출력결과는 matrix
str_locate(v1,'a')
str_locate(v1,'ab')

str_locate('a#b#c#','#')
str_locate_all('a#b#c#','#')   # 출력결과 리스트.
a1 <- str_locate_all(c('a#b#c#','aa#bb#cc#'),'#')   # 출력결과 리스트. 1층은 벡터의 첫번째 원소 결과값, 2층은 두번째 원소 결과값.

# 연습문제) 아래 변수에서 지역번호 추출(위치값 출력 함수 사용)
v_tel <- '02)345-6789'
str_locate(v_tel,'\\)')
v_lo <- str_locate(v_tel,'\\)')[1,1] - 1 ; v_lo   # 결과값이 메트릭스이기 때문에 색인을 이용하여 위치를 스칼라값으로 만들어줘야 한다.
                                                  # 지역번호가 여러개 있을 경우(예를들어 02, 031, 033, ...) [1,1] 이 표현을 [ ,1]로 해준다!!
substr(v_tel,1,v_lo)
# ')'가 오류가 난 이유 : )가 함수를 닫는 기능이 있어서 ')'를 특수기호로 인식을 해버린다. 
#  그래서 일반기호 즉 문자로 해석시키기 위해서는 '\\)'로 입력하면 일반기호로 파싱한다.

# 6. str_replace
# - 치환함수
# - replace(내부함수)로도 사용 가능
# - oracle에서의 replace와 비슷
str_replace('abcdaa','a','A')       # 출력결과 벡터
str_replace_all('abcdaa','a','A')   # 출력결과 벡터
replace('abcd','a','A')             # 출력결과 matrix
v1 <- c('abc','vad','ded')
str_replace(v1,'a','A')   # 출력결과 벡터
replace(v1,'a','A')       # 출력결과 matrix. 첫번째 인자가 벡터로 확장되면 사용을 거의 안하는 것이 좋다.

# 삭제처리
v1 <- c('abc','vad','ded',NA)
str_replace('abcd','a','')  # 세번째 인자 ''으로 입력
str_replace(v1,NA,0)        # 실행불가. NA를 str_replace함수로 치환할 수 없다. NA치환 불가
str_replace(v1,'a',NA)      # 실행불가. str_replace함수로 NA로 치환할 수 없다. NA로 치환 불가
str_replace(v1,'a',0)       # 문자치환 함수 이므로 숫자로 치환 불가하다. 문자 이외의 데이터 타입으로 치환 불가. 데이터 타입 꼭 지켜줄것! 문자 외 데이터 타입으로 치환 불가
ifelse(is.na(v1),'k',v1)

v2 <- c('aabc','vada','ded',NA)
str_replace(v2,'a','A')       # str_replace : 발견되는 모든 패턴 치환 불가.
str_replace_all(v2,'a','A')   # str_replace_all : 발견되는 모든 패턴 치환.


# 연습문제) 다음의 변수의 10% 인상된 값 출력
v_sal <- c('1,200','5,000','3,300')
sal <- str_replace(v_sal,',','')
as.numeric(sal)*1.1
as.numeric(str_replace(v_sal,',','')) * 1.1

# 7. str_split
# - 분리 함수
# - 출력 결과 리스트
str_split('a#b','#')
v1 <- c('a#b','c#d','e#f')
str_split(v1,'#')
l1 <- str_split(v1,'#')
l1[2,1,2]  # 리스트는 각 층마다 각 원소, 즉, 2층의 1열의 2컬럼에 있는 원소를 옆과 같은 방법으로 추출이 불가하다. for문을 통하여 추출해야 한다.
l1[[2]][2]


# 연습문제) v1 벡터에서 '#'으로 구분된 두번째 기호 추출
l1[1]
l1[[1]][2]
l1[[2]][2]
l1[[3]][2]
v_1 <- c()
for (i in 1:length(l1)){     # 리스트의 층의 갯수는 length로 가능하다.
  v_1 <- c(v_1,l1[[i]][2])
}
v_1

# 연습문제)
# professor.csv 파일을 읽고
prof <- read.csv('professor.csv', stringsAsFactors = F) ; prof
str(prof)
# 1) 교수번호가 40으로 시작하는 교수의 이름, 교수번호, pay 출력
prof[str_detect(prof$PROFNO,'^40'), c('NAME','PROFNO','PAY')]

# 2) email_id라는 각 교수의 이메일 아이디를 담는 컬럼 생성
# 2-1) '@' 위치 기반 추출
pr_e <- str_locate(prof$EMAIL,'@')[,1] - 1 ; pr_e
prof$email_id <- substr(prof$EMAIL, 1, pr_e) ; prof
# 2-2) '@'로 분리 추출
str_split(prof$EMAIL,'@')[[1]][1]
pr_e2 <- c()
for (i in 1:NROW(prof)) {   # 데이터 프레임에서 length는 컬럼수가 출력된다. 그래서 nrow를 씀..
  pr_e2 <- c(pr_e2,str_split(prof$EMAIL,'@')[[i]][1])
}
pr_e2

l2 <- str_split(prof$EMAIL,'@')
pr_e3 <- c()
for (i in 1:length(l2)) {   # length를 쓰려면 현재처럼 list형태의 식을 넣어줘야 함!!
  pr_e3 <- c(pr_e3,str_split(prof$EMAIL,'@')[[i]][1])
}
pr_e3

# while문 : 조건 기반 반복문, 반복변수의 자동 증가 기능 없음
# 예제) 1부터 10까지 출력
for (i in 1:10) {
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
  print(i)            # print(i)의 위치에 따라 condition(조건문)의 값이 달라짐!
}

# 반복 제어문 :  반복문의 흐름 제어
# 1. next : 반복문의 특정 구간을 스킵
for (i in 1:10) {
  cmd1                #10번수행
  cmd2                #10번수행
  if (i==5) {
    next
  }
  cmd3                # 9번수행
}
cmd4                  # 1번수행

# 2. break : 반복문 자체 종료
for (i in 1:10) {
  cmd1         # 5회 수행
  cmd2         # 5회 수행
  if (i==5) {
    break
  }
  cmd3         # 4회 수행
} 
cmd4           # 1회 수행

# 3. exit : 프로그램 자체 종료
for (i in 1:10) {
  cmd1         # 5회 수행
  cmd2         # 5회 수행
  if (i==5) {
    exit(0)
  }
  cmd3         # 4회 수행
} 
cmd4           # 0회 수행 : for문이 비정상 종료가 되었다고 판단되어 수행이 안됨.


# 연습문제) 1부터 10까지 중 짝수만 출력
for (i in 1:10) {
  if(i%%2!=0) {
    next
  }
  print(i)
}

# 예제) 1부터 10까지의 총 합 출력
# 1) for
v_sum <- 0    # 초기값 선언
for (i in 1:10) {
  v_sum <- v_sum + i
} ; v_sum

# 2) while
i <- 1      # while문에서는 for문이랑 다르게 두개 변수 모두에 초기값 선언이 필요
v_sum <- 0
while (i <= 10) {
  v_sum <- v_sum + i
  i <- i + 1
} ; v_sum


# 연습문제)1~100까지의 합을 구하되, 홀수는 제외
v_sum <- 0
for (i in 1:100) {
  if(i%%2!=0) {
    next
  }
  v_sum <- v_sum+i
} ; v_sum


i <- 1
v_sum <- 0
while (i <= 100){
  i <- i + 1
  if(i%%2!=0) {
    next
  }
  v_sum <- v_sum + i
} ; v_sum








