# apply
# plyr::adply : apply 비슷, margin = 1 기존 데이터 유지.
# plyr::ddply : tapply 비슷.
# plyr::mdply : mapply(function, ...) 비슷.

# reshape2
# - 데이터 형 변환(wide <-> long)
# - melt : stack과 비슷(wide -> long)
# - dcast : unstack과 비슷(long -> wide)
install.packages('reshape2')
library(reshape2) 

# 1. melt(data,              -- 데이터 프레임
#         id.vars = ,        -- 고정 컬럼(stack처리 제외 대상 컬럼)
#         measure.var = ,    -- stack 처리 컬럼
#         varable.name = ,   -- variable 컬럼 명
#         value.name = )     -- value 컬럼 명
# - stack처리되는 컬럼(고정컬럼 제외)이 variable컬럼과 value 컬럼으로 생성

m1 <- read.csv('melt_ex.csv')
d1 <- read.csv('dcast_ex1.csv')
d2 <- read.csv('dcast_ex2.csv')

m1

stack(m1)   # year, mon 컬럼도 stack 처리 됨(제외 불가)
melt(m1, id.vars = c('year', 'mon'))
melt(m1, id.vars = c('year', 'mon'), 
         variable.name = '이름', value.name = '판매량')

# 연습문제) 2000-2013년_연령별실업율_40-49세.csv 파일을 읽고
df1 <- read.csv('2000-2013년_연령별실업율_40-49세.csv')
# 해당 데이터를 년도별 월별 정리된 형태로 출력

# df1 : cross table 형태(wide data)
# - 월별 평균
apply(df1[,-1], 1, mean)
adply(as.matrix(df1[,-1]),1,mean)

# df2 : tidy table 형태(long data)
df2 <- melt(df1, id.vars = '월')
# - 월별 평균
tapply(df2$value, df2$월, mean)


# 연습문제) employment.csv 파일을 읽고 tidy 형식으로 정리
emp1 <- read.csv('employment.csv', stringsAsFactors = F)
melt(emp1[-1, ], id.vars = '고용형태')

# 컬럼과 첫번째 행 데이터 결합하여 컬럼명 변경
colnames(emp1) <- paste(colnames(emp1), emp1[1,], sep='_')
emp1 <- emp1[-1,]
colnames(emp1)[1] <- '고용형태'

emp2 <- melt(emp1, id.vars = '고용형태')

strsplit('X2009.7_연간특별급여 (천원)','_')[[1]][1]

f_split <- function(x, sep='_', ord=1) {
  strsplit(x,sep)[[1]][ord]
}

sapply(emp2$variable, f_split)   # 에러 : emp2$variable가 factor이므로 에러발생
v1 <- sapply(as.character(emp2$variable), f_split)
v2 <- sapply(as.character(emp2$variable), f_split, ord=2)

emp2$년도 <- v1
emp2$세부항목 <- v2

emp2[, c('년도','고용형태','세부항목','value')]


# 2. dcast
# - unstack 처럼 long -> wide data로 변경
# - unstack 처리 할 컬럼 필요(formula 우측)
# - unstack 처리하지 않고 고정 시킬 컬럼 필요(formula 좌측)
# - value 컬럼 필요, 생략 시 맨 마지막 컬럼이 자동 선택

dcast(data,
      formula,                         # 고정컬럼 ~ unstack 컬럼
      fun.aggregate = NULL,            # 요약함수 : 여러개의 쉘을 하나의 쉘에 표현할 때, 즉 축약표현할때 쓰는 그룹함수. ex) sum, mean, ...
      ...,
      value.var = guess_value(data))   # value 컬럼

# 예제) d1 데이터를 year, name 컬럼 고정, info 컬럼 unstack 처리
dcast(d1, year + name ~ info)
dcast(d1, year + name ~ info, value.var = 'value')

# 예제) d1 데이터를 year 컬럼 고정, info 컬럼 unstack 처리
dcast(d1, year ~ info, fun.aggregate = mean,value.var = 'value')

# 예제) d2에서 year와 name에 대한 qty의 교차테이블 작성
d2
dcast(d2, year ~ name, value.var = 'qty')     # value.var = . 이 옵션을 생략하면 맨마지막 컬럼이 디폴트값이다.

d3 <- d2[-4,]
dcast(d3, year~name, value.var = 'qty')  # 2001년 latte 데이터는 NA.

dcast(d3, year~name, value.var = 'qty', 
                     fill = 0)   # fill = . NA채우는 옵션.

dcast(d3, year~name, value.var = 'qty', 
                     fill = 0, 
                     fun.aggregate = sum,
                     margins = T)   # margins = T. 컬럼별, 행별 총 합. fun.aggregate = sum. 옵션 있을때(qty 총합) 없을때(갯수 카운트).


# 상반기사원별월별실적현황_new.csv 파일을 다음과 같은 교차테이블로 표현
#       1     2     3     4     5     6
#박동주 1     0.85 0.75  0.98  0.92  0.97
#최경우 0.90 0.92  0.68  0.87  0.89  0.89

new <- read.csv('상반기사원별월별실적현황_new.csv', stringsAsFactors = F)
dcast(new, 이름 ~ 월, value.var = '성취도')
dcast(new, 이름 ~ 월)   # Using 성취도 as value column: use value.var to override.
                        # : value.var = . 를 설정을 안해줘서 마지막 컬럼인 '성취도'가 설정이 되었다.

# 연습문제) subway2.csv 파일을 읽고 각 역별, 시간대별 승차 - 하차의 값을 출력
sub <- read.csv('subway2.csv', stringsAsFactors = F)
sub

g1 <- function(x) {
  return(as.numeric(str_remove_all(x,',')))
}
sub
sub[,-c(1,2)] <- apply(sub[,-c(1,2)],c(1,2),g1)

sub2 <- sub[,-c(1,2)]
rownames(sub2) <- sub[ ,sub$구분]

sub3 <- sub[sub$구분 == '승차', ]
sub3[,-c(1,2)] <- sub[sub$구분 == '승차', -c(1,2)] - sub[sub$구분 == '하차', -c(1,2)]
sub3 <- sub3[,-2]
colnames(sub3) <- sub[1,-2]

sub3

dcast(sub3, )

f1 <- sub[sub$구분 == '승차', ]
f2 <- sub[sub$구분 == '하차', ]
NROW(f1)
NROW(f2)




subb <- read.csv('subway2.csv', stringsAsFactors = F, 
                 skip=1, na.strings = '')
library(zoo)
# step1) 전체 컬럼 채우기
subb$전체 <- na.locf(subb$전체)
subb

# step2) 천단위 구분기호 제거 및 숫자 변경
f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}
subb[,-c(1,2)] <- apply(subb[,-c(1,2)], c(1,2), f1)

# step3) 시간컬럼 stack 처리
subb2 <- melt(subb, id.vars = c('전체','구분'), 
                    variable.name = '시간대',
                    value.name = '수')

# step4) 시간대 컬럼 정리(숫자로)
subb2$시간대 <- as.numeric(substr(subb2$시간대,2,3))

# step5) 구분컬럼 unstack
total <- dcast(subb2, 전체 + 시간대 ~ 구분, value.var = '수')
subb2
# step6) 승차 - 하차
total$v1 <- total$승차 - total$하차





