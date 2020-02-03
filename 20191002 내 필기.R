m1 <- read.csv('melt_ex.csv')
melt(m1, id.vars = c('year','mon'))
melt(m1, id.vars = c('year','mon'), 
         measure.vars = c('latte','americano'))

melt(m1, id.vars = 'mon', 
     measure.vars = c('latte','americano'))

d1 <- read.csv('dcast_ex1.csv')

library(plyr)
dcast(d1,year+name ~ info)
dcast(d1,year+name ~ info, subset = .(name=='latte'))


# dplyr 패키지 : 내부 함수를 사용하여 SQL 문법처럼 구문처리가 가능
# - 각 내부 함수는 순차적 전달되어야 하며 전달은 %>%로 가능
# - select : 컬럼선택
# - filter : 조건선택
# - mutate : 연산식의 결과를 기존 데이터 프레임에 추가(컬럼추가)
# - group_by : group by 컬럼
# - summarise_each : group by 표현식(연산대상)
# - arrange : 정렬

install.packages('dplyr')
library(dplyr)

emp <- read.csv('emp.csv', stringsAsFactors = F)

# 예제1) emp에서 EMPNO, SAL, DEPTNO 선택
emp %>%
  select(EMPNO, SAL, DEPTNO)

# 예제2) emp에서 DEPTNO가 10인 행 선택
emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  filter(DEPTNO == 10)

# 에러 : 기입한 순서대로 실행이 되므로...
emp %>%
  select(EMPNO, SAL)  %>%
  filter(DEPTNO == 10)   # 주의 : select에 표현된 컬럼만 조건가능


emp %>%
  filter(DEPTNO == 10) %>%
  select(EMPNO, SAL)
  

# 예제3) 위의 결과에서 10% 상승된 연봉정보 출력
emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  filter(DEPTNO == 10) %>%
  mutate(NEW_SAL = SAL*1.1)   # 표현식추가는 mutate에서... Oracle에서는 select절에서 다 처리했다...

# 예제4) 위의 결과를 SAL 순서대로 정렬
emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  filter(DEPTNO == 10) %>%
  mutate(NEW_SAL = SAL*1.1) %>%
  arrange(SAL)

emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  filter(DEPTNO == 10) %>%
  mutate(NEW_SAL = SAL*1.1) %>%
  arrange(desc(SAL))   # 역순정렬은 desc함수와 함께!!!

# 예제5) DEPTNO별 SAL평균 출력
emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  group_by(DEPTNO)  %>%
  summarise_each(list(MEAN = mean), SAL)

emp %>%
  select(EMPNO, SAL, DEPTNO)  %>%
  group_by(DEPTNO)  %>%
  summarise_each(mean, SAL)


install.packages('psych')
library(psych)
emp <- read.clipboard(sep='\t')   # sep옵션 사용해야함.. csv파일임..
