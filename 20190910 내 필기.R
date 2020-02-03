c(1,2,c(1,2))

# 벡터의 크기 확인
v1 <- 1:5
length(v1) # 벡터의 원소의 개수
NROW(v1)   # 벡터의 원소의 개수.1,2차원일 경우 행의 수 출력. 1차원,2차원 둘다 가능.
nrow(v1)   # 2차원일 경우 행의 수 출력, 벡터 전달 불가. 2차원만 가능, 1차원은 불가능.

# 포함연산자 : %in%
v2 <- c('a','b','c','d','e')
v2 %in% c('a','c')  # (v2=='a') | (v2=='c')와 동일
                    # where v2 in ('a','c')
v2 %in% 'a'         # v2벡터의 각 원소에 'a'의 포함 여부 리턴
'a' %in% v2         # v2벡터 전체 중 'a'가 포함됐는지 여부 리턴

# 조건의 부정
v2[v2 == 'a']  # where v2 = 'a'
v2[!v2 == 'a']  # where v2 != 'a'
v2[v2 != 'a']  # where v2 != 'a'

sal <- c(900,1200,1500,3000)
sal[!sal > 1200]  # where not (sal > 1200). 조건의 부정(not)은 조건 앞에다가 !, =의 부정은 !=.

#       'a','b','c','d','e'     
#R       1   2   3   4   5
#Python  0   1   2   3   4
#Python -5  -4  -3  -2  -1

#v1[2:4] => b,c,d (in R)     : 마지막 범위를 포함한다. 숫자 1부터 시작. 2<= x <= 4
#v1[2:4] => c,d (in Python)  : 마지막 범위를 포함하지 않는다. 숫자 0부터 시작. 2<= x < 4
#v1[-1]  => b,c,d,e (in R)   : 제외의 의미
#v1[-1]  => e (in Python)    : 역으로 숫자를 센다는 의미


#벡터의 수정 : 출력을 먼저 하고, 수정을 한다.
v1
v1[3] <- 30  # 수정하는 방법. 값 수정.
v1

v1[3] <- 30 ; v1 # 수정하고 바로 결과값 출력해주는 방식(;)

v1 <- c(v1,6) ; v1       #여섯번째 원소에 6입력, 맨 앞 또는 맨 뒤에 데이터 삽입가능. 값 삽입(맨끝)
v1 <- c(6,v1,9) ; v1     #맨 앞, 맨 뒤에 데이터 삽입가능. 
v1 <- append(v1,7) ; v1  #일곱번째 원소에 7입력. 값 삽입(맨끝)
v1[8] <- 8 ; v1          #여덟번째 원소에 8입력. 값 삽입(맨끝:8번째)
v1 <- append(v1,40, after = 3) ; v1  # 데이터 중간에 삽입 가능. 위치지정 가능.값 삽입(중간:3번째 뒤)
v1[15] <- 15 ; v1 # 중간에 NA삽입. cf) NA는 위치를 갖고있고(데이터크기가 있고), NULL은 위치가 없다(데이터 크기가 없다).
                  # 마지막위치 : 11, 12~14위치 까지 NA삽입.
# append함수는 중간에 값 삽입이 가능하나, c()를 통한 삽입은 맨 앞, 맨 뒤만 가능하다.


#벡터 연습문제
#1.
seq(as.Date('2015/01/01','%Y/%m/%d'),
    as.Date('2015/01/31','%Y/%m/%d'),
    1)
#2.
vec1 <- c('사과','배','감','버섯','고구마') ; vec1
vec1[-3]
vec1[!vec1 == '감']

# 생성된 변수의 확인 및 제거
objects() # 생성변수 확인
objects(all.names = T) # 숨김변수까지 출력

rm(list='vec1') # 특정 변수의 삭제
rm(list=ls()) # 현 세션에 선언된 모든 변수의 삭제


#3.
vec1 <- c('봄','여름','가을','겨울')
vec2 <- c('봄','여름','늦여름','초가을')
#1) 합집합
c(vec1,vec2) # c(union(vec1,vec2), intersect(vec1,vec2))
union(vec1,vec2)

#2) 차집합
vec1[!vec1 %in% vec2]
setdiff(vec1,vec2)

vec2[!vec1 %in% vec2]
setdiff(vec2,vec1)

#3) 교집합
vec1[vec1 %in% vec2]
intersect(vec1,vec2)

# 벡터의 집합연산자
v1 <- c('a','b','c','d')
v2 <- c('b','d','e')
v3 <- c('b','d','d','e')
v4 <- c('b','d','e')

# 1. union : 합집합(중복제거)
union(v1,v2) #"a" "b" "c" "d" "e"

# 2. intersect : 교집합
intersect(v1,v2) #"b" "d

# 3. setdiff : 차집합
setdiff(v1,v2) #"a" "c"

# 4. identical : 두 벡터가 완전히 동일한지 여부 체크(크기, 내용일치)
identical(v2,v4) #TRUE
identical(v3,v4) #FALSE

# 5. setequal : 두 벡터의 구성요소가 동일한지 여부 체크(크기 상관 x)
setequal(v3,v4) #TRUE


# factor : 범주형 자료를 표현하는 자료형
# 범주형 자료 : 이미 자료를 구성하는 카테고리(레벨)가 정해진 경우 
#               주로 문자형 변수에 해당. 오라클에서 체크 제약조건이랑 비슷하다.
#               정해진 레벨 이외의 값이나 문자는 절대로 허용하지 않는다.

# 1. factor 종류
# - 명목형 factor : 각 카테고리(레벨)에 순서가 의미 없는 경우
#   예) 남,여
# - 순서형 factor : 각 카테고리(레벨)에 순서가 의미 있는 경우
#   예) 상, 중, 하

# 2. factor 생성
# factor(벡터, levels=레벨값)
(f1 <- factor(c('m','m','f'), levels = c('m','f'))) # levels로 인하여 m,f 이 외의 문자는 절대로 허용하지 않는다. 레벨의 순서를 강제로 부여.
(f2 <- factor(c('m','m','f')))  # 레벨순서가 f1과 다르다. f2는 레벨의 순서가 차이가 있다. 알파벳순. 레벨의 순서가 중요한 이유 : 레벨의 일부를 수정할 때 순서가 중요.
(f3 <- factor(c('m','m'), levels = c('m','f')))  # f라는 레벨이 있다는 것을 선언.
(f3 <- factor(c('m','m'))) # 레벨이 m만 생긴다.
(f5 <- factor(c('m','m','f'), levels = c('m','f'), ordered = T)) # 레벨 선언 순으로 순서형 factor
(f6 <- factor(c('m','m','f'), ordered = T)) # 알파벳 순으로 순서형 factor

(v1 <- c('m','m','f'))

# 3. factor 변수의 값 수정
f1[2] <- 'male' ; f1  #에러
v1[2] <- 'male' ; v1

# 4. factor의 level 확인 및 수정
levels(f1) <- c('male', 'female') ; f1  # 전체수정
levels(f1)[2] <- 'f' ; f1               # 일부수정


f2 <- as.character(f2) ; f2
f2[2] <- 'male' ; f2
f2 <- as.factor(f2) ; f2  # as.character로 일반변수로 변경후, 원하는 값을 수정한 후에 as.factor로 다시 factor선언을 한다.

# 5. factor의 확인
is.factor(f1)
is.factor(v1)

#  as.함수 : 형변환,  is.함수 : 형확인

std <- read.csv('student.csv', stringsAsFactors = F) #stringsAsFactors = T : 문자열을 factor로 바꾸겠단 뜻
std
str(std) # str = Oracle에서 desc함수.

