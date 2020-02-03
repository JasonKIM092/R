v1 <- c('a','b','c','d')
seq_along(v1) # 1 ~ n(v1)의 연속적 벡터
1:length(v1)  # seq_along과 같은 기능. 1:length(v1) 이 표현을 더 많이 쓴다. length() : 갯수 추출 함수.

# 리스트
# - key - value 형태로 저장, 색인을 위한 자료구조, key를 갖고있는 데이터구조는 리스트와 데이터프레임이다. key = column.
# - 서로 다른 데이터 타입 가능(같은 key내에서는 불가, 이유 : 벡터로 여러개의 값을 묶어주는데, 벡터에는 서로 다른 데이터 타입이 묶일 수 없다.)

#1. 리스트의 생성
l1 <- list('a' = 1, 'b' = 2) ; l1  
(l2 <- list(1, 2)) ; l2
l3 <- list('a' = c(1,2,3), 'b' = c(2,3,4)) ; l3  # 하나의 키에 여러개의 값이 들어갈 수 있다. 단, 벡터로 넣어야 한다.
l4 <- list('a' = c(1,2,3), 'b' = c('a','b','c')) ; l4 # 이건 가능하다.

#2. 리스트의 색인
l4['a']    # 출력 결과 리스트
l4$a       # 출력 결과 벡터
l4[['a']]  # 출력 결과 벡터
l4[2]               # 두번째 층으로 선택이 됨. 즉, l4[2] = l4['b']. 리스트를 구성할 때, 원소의 개개의 값보다 층이 더 우선적으로 여겨진다.
l4['a', 2]          # 리스트는 2차원도 아니고 1차원으로 보기에도 애매하다. 2차원이면 해당 명령어가 수행이 되어야 한다. 정확한 2차원 구조가 아니므로 불가(에러)
l4[['a']]           # 'a' key 색인, 출력 결과 벡터
l4[['a']][2]        # 먼저 벡터로 만들어 준 후, 원소값의 위치를 선언해 주면, 원하는 층의 원하는 원소를 출력할 수 있다. 'a' key에서 두번째 원소 추출
l4['a']             # 'a' key 색인, 출력 결과 리스트
l4$a                # 'a' key 색인, 출력 결과 벡터. 리스트에서만 가능하다.
l4['a'][2]          # 'a'라는 키에서 두번째를 출력하라는 명령어. NULL이 출력된다. 'a1','a2'가 있을때 a2를 출력하라는 의미이다.
                    # NULL 발생, 'a'라는 key 한개 선택 후 두번째 key를 추출했으므로.
l4[c('a','b')][2]   # 'b' key 선택/출력.

#3. 리스트의 수정 : 추출 후 수정. 벡터수정법과 동일.
l4[['a']][2] <- 20 ;l4       # 값 교체
l4$c <- c(10,20,30) ;l4      # key 생성/삽입
l4['d'] <- c('a','a','a')    # key 생성/삽입(에러). l4['d']: 리스트, c('a','a','a') : 벡터. data 형(form)이 안맞다.
l4[['e']] <- c('a','a','a')  # key 생성/삽입
l4['d'] <- l4['b']           # key 생성/삽입
l4$d <- NULL ; l4            # key 삭제

# [문제]
# 1-1. 아래 벡터 생성
# name   grade  jumsu    hakjum
# 서재수  4      90        A0
v1 <- c('서재수', '4' , '90', 'A0')  # 문자와 숫자가 같이 혼용되어서 두가지 타입의 데이터가 함께 벡터에는 포함될 수 없다.
names(v1) <- c('name','grade','jumsu','hakjum')   # 쉘이름 생성.
v1['jumsu']

# 1-2. jumsu를 '성적'으로 변경
names(v1)[3] <- '성적' ; v1

# 2-1. 아래 리스트 생성
# name   grade  jumsu    hakjum
# 서재수  4      90        A0
# 서진수  3      80        B+
# 홍길동  2      85        B+

k1 <- list(name   = c('서재수','서진수','홍길동'),
          grade  = c(4,3,2),
          jumsu  = c(90,80,85),
          hakjum = c('A0','B+','B+')) ; k1

# 2-2. 홍길동의 점수와 hakjum을 각각 95, A+로 변경
k1[c('jumsu','hakjum')][3]  # 세번째 키를 추출하는 명령어이다. 즉 결과값은 NULL
                            # 동시에 한번에 수정은 불가능하고, 각각 수정을 해줘야 한다. 동시 수정 불가. 동시 추출 자체가 불가하므로 동시 수정 역시 불가하다.
k1$jumsu[3] <- 95
k1$hakjum[3] <- 'A+'

k1$jumsu[k1$name == '홍길동'] <- 95 ; k1
k1$hakjum[k1$name == '홍길동'] <- 'A+' ;k1
# k1[k1$name == '홍길동'] : oracle. where name = '홍길동'

# 2-3. 서진수의 jumsu 삭제
s$s3[3] <- NULL ; s
s$s3[3] <- NA ; s
k1$jumsu[k1$name == '서진수'] <- NULL # replacement has length zero. NULL은 저장공간이 없고 학점이 땡겨져 오기때문에 에러가 발생한다. NA로 써줘야 한다.
k1$jumsu[k1$name == '서진수'] <- NA ; k1




# MATRIX
#- 2차원, 서로 동일한 데이터 타입만을 허용
#- 주로 숫자로 구성된 행렬의 연산을 위해 사용

#1. matrix 생성
matrix(data=1:10,nrow=2,ncol=5)
matrix(data=1:10,nrow=2)
matrix(data=1:10,ncol=5)
matrix(data=1:10,nrow=5) # byrow = FALSE. FALSE가 default
matrix(data=1:10,nrow=5, byrow = F)
matrix(data=1:10,nrow=5, byrow = T)

matrix(data = 1:10,  # 행렬을 구성하는 벡터
       nrow = 2,     # 행의 수
       ncol = 5,     # 컬럼수
       byrow = F     # 행 우선순위 여부
       )

#2. matrix 색인
m1 <- matrix(1:16, nrow = 4) ; m1
m1[1,]     # 첫번째 행 선택
m1[,1]     # 첫번째 컬럼 선택
m1[2,2]
m1[2,][2]  # 행 출력결과는 벡터값이다.
m1[c(2,3),c(1,2)]  # 여러개의 행과 여러개의 컬럼을 선택. 2,3행에서 1,2컬럼값을 선택.
m1 > 10
m1[m1 > 10] # 출력의 결과 : 벡터값. 벡터 원소 전체의 조건 색인, 벡터로 출력.

# 3번째 컬럼이 10이상인 행 선택
m1[m1[,3] >= 10, ]  # , 有 : MATRIX값 출력. 출력 결과 MATRIX.
                    # ,의 유무 : 출력값이 벡터이냐 MATRIX냐.
m1[ ,m1[,3] >= 10]  # 2,3,4번째 컬럼이 선택됨에 유의. m1[,3] >= 10의 조건에 만족하는 값이 2,3,4 행에 있으므로...
                    # m1[,3] >= 10의 논릿값은 F,T,T,T이므로 해당 논리값을 행에 적용하면 2,3,4행이 선택되고, 컬럼에 적용되면 2,3,4컬럼이 선택된다.
m1[m1[,3] >= 10]    # , 無 : 벡터 출력. 행우선순위, 출력 결과 벡터
                    # m1[m1[,3] >= 10,] = m1[c(2,3,4),] = m1[c(F,T,T,T),]

#3. MATRIX 행, 컬럼 이름 수정
rownames(m1) <- 1:4
colnames(m1) <- c('a','b','c','d')
dimnames(m1)  # 결과값 리스트
dimnames(m1) <- list(c('a','b','c','d'), c(1,2,3,4))

m1
m1[,'b'] # 컬럼 이름 색인 가능, 하나 컬럼 선택 시 차원 축소.
m1[,'b', drop = F]  # drop = F : 차원축소옵션 off 함수. 차원 축소 방지.

rownames(m1)  # rownames(m1) <- 1:4 숫자로 이름을 부여했음에도 문자로 저장이 되어 있다.
rownames(m1) <- 1:4
m1[c(2,4), c('b','d')]  # c(2,4) : 위치값
m1[c('2','4'), c('b','d')]  # c('2','4') : 이름
                            # 결과 값이 동일한 이유는 이름과 위치값이 일치하기 때문이다. 즉, 1번위치에 1이란 이름을 부여했다. 만약 0을 부여했으면 결과값이 달라지거나 오류가 난다.(다음예시참고)

rownames(m1) <- 0:3
m1[c(1,3), c('b','d')]  # c(1,3). 행 선택 기준 : 위치값
m1[c('1','3'), c('b','d')] # c('1','3'). 행 선택 기준 : 행의 이름.

#4. matrix 연산
ma1 <- matrix(1:4, nrow = 2)
ma2 <- matrix(c(10,20,30,40), nrow = 2)
ma3 <- matrix(c(10,20,30,40,50,60), nrow = 2)

ma1 + ma2  # 동일한 크기의 행렬 연산 가능(같은 위치 원소끼리)
ma1 + ma3  # 서로 다른 크기의 행렬 연산 불가

ma1 %*% ma2  # 행렬의 inner product
ma1 %*% ma3

m1 <- matrix(1:8, nrow = 2, byrow  = T) ; m1
r1 <- rep(c(10,20), each = 4)
m2 <- matrix(r1, ncol = 2) ; m2

#5. matrix 크기 확인
nrow(m1)  # 행의 수, 벡터 불가
ncol(m1)  # 컬럼수
NROW(m1)  # 행의 수, 벡터 가능
NCOL(m1)  # 컬럼수
dim(m1)   # shape출력, 벡터임에 주의

dim(m1) <- c(2,4)  # shape 변경하기. 2 by 4에서 4 by 2로 변경. matrix reshape.
m1
t(m1)     # 행렬전치

#6. 컬럼의 행, 열 추가
c1 <- 1:3
c2 <- 4:6
c3 <- 7:9
rbind(c1,c2,c3) # 벡터의 행 결합
cbind(c1,c2,c3) # 벡터의 컬럼 결합

m1 <- matrix(1:9, nrow = 3, byrow = T) ; m1
m1 <- rbind(m1, c(10,11,12)) ; m1
m1 <- cbind(m1, c(100,200,300,400)) ; m1


# matrix 연습문제
# 1-1)
seasons <- matrix(c('봄','여름','가을','겨울'), nrow = 2) ; seasons

v1 <- c('봄','여름','가을','겨울')
seasons <- matrix(v1, ncol = 2)

# 1-2)
seasons <- matrix(c('봄','여름','가을','겨울'), nrow = 2, byrow = T) ; seasons

seasons <- matrix(v1, ncol = 2, byrow = T)

# 2.
seasons[,2]

# 3.
seasons_2 <- rbind(seasons,c('초봄','초가을')) ; seasons_2

# 4.
seasons_3 <- cbind(seasons_2,c('초여름','초겨울','한겨울')) ; seasons_3


# Array


# Data frame
# - 데이터시트, 테이블과 같이 행과 열을 갖는 2차원 자료 구조
# - 각 컬럼은 Key가 되므로 Key삭제와 색인 가능
# - 서로 다른 Key는 다른 데이터 타입을 가질 수 있음
# - 같은 컬럼 내에서는 같은 데이터 타입만 허용

#1. Data frame 생성
name <- c('smith','allen','word')
empno <- c(9411,9511,9611)
sal <- c(900,1000,1200)

df1 <- data.frame(name = name,    # key(컬럼이름) = 벡터 형식
                  empno = empno,  # 
                  sal = sal,
                  stringsAsFactors = F) # 문자컬럼을 non-factor로 지정
df1

#2. Data frame 구조확인
str(df1)  # str() = desc
          # 문자열로 구성되어 있는 컬럼은 자동으로 Factor로 지정.stringsAsFactor = F로 설정해줘야 Factor로 지정이 안됨.
dim(df1)

#3. Data frame 구조변경
#3-1) 행추가
#1) rbind로 추가시
df1 <- rbind(df1, c('hong',9711,1500))  # 단점 : 형변환이 일어난다. num -> chr. 이에 따라 숫자의 경우 대소비교가 불가하다.
                                        # 형변환 발생
df1
str(df1)
df1$empno <- as.numeric(df1$empno)      # 다시 숫자타입으로 변경
df1$sal <- as.numeric(df1$sal)          # 다시 숫자타입으로 변경

#2) 위치색인으로 직접 값 추가 시
df1[4,1] <- 'hong'  # 해당방법으로 할 경우 형변환은 일어나지 않는다.
                    # 형변환 발생하지 않음
                    # # df1[4,'name'] <- 'hong' 이렇게도 가능
df1[4,2] <- 9711  # df1[4,'empno']<- 9711
df1[4,3] <- 1500  # df1[4,'sal']<- 1500
str(df1)

#3-2) 컬럼추가
df1$deptno <- c(10,10,20,30)
df1$job <- c('clerk','manager','manager','manager')  # 추가되어진 컬럼이 문자일 경우 chr타입으로 형설정. non-factor
df1[,'job2'] <- c('clerk','manager','manager','manager')  # non-factor
# data.frame_name[row(*oracle. where절),column(*oracle. select절)]

df1 <- cbind(df1, c('clerk','manager','manager','manager'))  # factor
df1 <- cbind(df1, c('clerk','manager','manager','manager'),
             stringsAsFactors = F)  # non-factor 옵션. non-factor
df1
str(df1)
df1 <- cbind(df1, df1$name)
# cbind는 factor로 저장됨.

#3-3) 행, 컬럼 이름 변경
rownames(df1)
colnames(df1)[c(7,8)] <- c('job3', 'job4')

#4. Data frame 색인
df1[1,3]
df1[1,'sal']
df1

# smith의 sal출력(select sal from df1 where name = 'smith';)
df1[df1$name == 'smith', 'sal']
df1[df1$name == 'smith', 'sal'] <- 900  # 데이터 수정방법.
df1

# sal이 1000이상인 직원의 이름과 sal 선택
df1[df1$sal >= 1000, c('name','sal')]

# smith와 hong의 name, empno, sal 선택
df1[df1$name %in% c('smith','hong'), c('name','empno','sal')]

