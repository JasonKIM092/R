library(doBy)
# 3. 추출 : sample, doBy::sampleBy
# 1) sample : row번호를 기반으로 한 추출형식, class별 균등 추출 불가
# sample은 데이터프레임을 직접 추출 안됨. nrow필요.
sample(x,            # 추출벡터
       size,         # 추출크기
       replace = ,   # 복원추출 여부
       prob = )      # 추출비율(추출벡터의 개수만큼)

# 예제) iris 데이터에서 무작위로 70% 데이터 추출, 나머지 30% 추출
sample(1:nrow(iris), size = nrow(iris)*0.7)
v_index <- sample(1:nrow(iris), size = 1)
iris[v_index,]
iris[sample(1:nrow(iris), size = nrow(iris)*0.7),]

# 무작위로 70% 데이터 추출
v_index <- sample(1:nrow(iris), size = nrow(iris)*0.7)
v_train <- iris[v_index, ]

# 나머지 30% 추출
v_test <- iris[-v_index, ]

# 건수확인
nrow(v_train)  # 105
nrow(v_test)   # 45

# class별 빈도수 확인(균등하게 추출이 되었나 확인). class = factor의 level.
table(c(1,1,2,2,2))
table(v_train$Species)
table(v_test$Species)

# 2) sampleBy : 데이터를 직접 추출, class별 균등 추출 가능. 나머지(위에서 나머지 30%)를 추출을 못하는 것이 단점 = 차집합(반대집합)을 쉽게 못얻음.
sampleBy(formula = ,   # ~ group by 컬럼
         frac = ,      # 추출비율
         replace = ,   # 복원추출 여부
         data = )      # 추출 원본 데이터프레임

v_train2 <- sampleBy(formula = ~ Species, frac = 0.7, data = iris) 
class(v_train2)

iris[rownames(iris) != rownames(str_sub(v_train2, )), ]

str_split(v_train,'.')
library(stringr)

########################################################################################  ``
# 나머지 30% 추출하기
library(stringr)
a_2 <- function(x) {
  a2 <- c()
  for ( i in 1:NROW(v_train2)) {
         a2 <- c(a2,str_split(rownames(v_train2),'\\.')[[i]][2])
   }
  return(a2)
}


t_train2_2<- as.numeric(a_2(v_train2))
NROW(iris[-t_train2_2, ])
sum(v_train2 == -t_train2_2)   # 0


f_4<-function(x){ #스칼라로 만들어서  sapply 돌리기
  return(str_split( rownames(v_train2),'\\.')[[x]][2]) #stringr 패키지 사용
}

v_num<-as.numeric(sapply(1:nrow(v_train2),f_4)) #v_train2의 row->v_num에 저장
v_test2<-iris[-v_num,] #train data 105의 row를 제외해서 출력 //test data 45개출력
nrow(v_train2) # 150개
nrow(v_test2) # 45개
####################################################################################

library(stringr)
  
# class별 빈도수 확인
table(v_train2$Species)


# [ R -> oracle : 데이터베이스 데이터 불러오기 ]
# [ R - oracle 연동 : oracle의 ojdbc <-> R의 RJDBC의 연결 설정 ]
# 1. oracle 설치(R버전과 맞게 : 64bit)
# - server : 내부 저장공간인 자체 database를 가지며 DB 테스트 가능
# - client : database를 갖추지 않는 형태의 DB로 database 통신만 가능
 
# 2. R에서 RJDBC 설치 및 로딩
install.packages('RJDBC')
library(RJDBC)
 
# 3. R에서 ojdbc 연결 설정
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver", 
                   classPath = "C:/app/kitcoop/product/11.2.0/client_2/ojdbc6.jar")
 
# 4. target DB connection 생성
con <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@192.168.0.84:1521:testdb","scott","oracle")  
       # ip주소 확인하는 법 : cmd창에 들어가서 ipconfig 명령어 수행
       # 1521 - port 이름 : testdb - db이름, 계정이름, 비번.
       # 확인하는 법 - cmd창에서 lsnrctl status 명령어 입력 후 확인.
query <- "select * from emp"
result <- dbGetQuery(con, query)
str(result)
result

query <- "select * from professor"
result <- dbGetQuery(con, query)
result

query <- "select p.PROFNO, p.NAME, p.DEPTNO, s.STUDNO, s.NAME, s.DEPTNO1 from professor p, student s where p.PROFNO = s.PROFNO"
result <- dbGetQuery(con, query)
result

# cmd창에서 sqlplus 접속이 안될 경우,
# 내 PC -> 고급시스템설정 -> 환경변수 -> 시스템변수 -> path -> 편집클릭 -> ~11.2.0w dbhome~ 파일을 client_~ 보다 상위로 설정해준다.