# 히스토그램
hist(x,                       # 벡터
     breaks="Sturges",        # 구간의 분기를 나타내는 벡터
     include.lowest = TRUE,   # 최소값의 포함 여부
     right = TRUE)            # 오른쪽 닫힘 여부(포함)  (,]

v1 <- c(160,161,168,172,177,180,181,182,183)

hist(v1)
hist(v1, breaks = c(160,170,180,190))

# right = TRUE   - 오른쪽 닫힘 여부(포함)  (,]
#                - 예) right = TRUE가 디폴트값 : 160초과 165이하.
#                -     right = FALSE값은 160이상 165미만.

# include.lowest = TRUE   - 최소값의 포함 여부
#                         - 해당 히스토그램 설정에서  right=T이므로 160은 포함이 안되어야 한다.
#                         - 하지만 include.lowest = T 이므로 최소값을 포함하게 설정되어 있으므로
#                         - 160은 160초과 165미만에 포함이 된다.

# 연습문제)
# 영화이용현황.csv 파일을 읽고,
# 1) 20세미만, 20대, 30대, 40대, 50대, 60세이상 별 이용비율의 평균
movie <- read.csv('영화이용현황.csv', stringsAsFactors = F)

movie[movie$연령대<20,]
movie$연령대>=20 & movie$연령대 < 30
movie$연령대>=30 & movie$연령대 < 40
movie$연령대>=40 & movie$연령대 < 50
movie$연령대>=50 & movie$연령대 < 60
movie$연령대>=60
tapply(movie$이용_비율..., movie$연령대<20, mean)
aggregate(이용_비율...~연령대<20, movie, mean)

movie$연령대별 <- ifelse(movie$연령대<20,'20대 미만',
                     ifelse(movie$연령대 < 30, '20대', 
                            ifelse(movie$연령대 < 40,'30대', 
                                   ifelse(movie$연령대 < 50,'40대', 
                                          ifelse(movie$연령대 < 60,'50대','60대')))))
tapply(movie$이용_비율..., movie$연령대별, mean)
aggregate(이용_비율...~연령대별, movie, mean)
ddply(movie, .(연령대별), summarise, mean_이용률 = mean(이용_비율...))

### 선생님풀이 ###
unique(substr(movie$연령대,1,1))
v1 <- paste(substr(movie$연령대,1,1),'0대', sep='')   # paste에서 백터 내부는 collapse 옵션!!
v1 <- str_replace(v1, '10대','20세미만')
v1 <- str_replace(v1, '60대','60세이상')
v1 <- str_replace(v1, '70대','60세이상')
unique(v1)
movie$age <- v1
ddply(movie, .(age), summarise, v1=mean(이용_비율...))

# 2) 각 지역.시도별 이용률이 가장 높은 연령대 출력
# (연령대 : 20세미만, 20대, 30대, 40대, 50대, 60세이상)
movie$지역.시도
m1 <- ddply(movie, .(지역.시도 ,연령대별), summarise, mean_시도_연령_이용률 = mean(이용_비율...))
ddply(m1, .(지역.시도), subset,  mean_시도_연령_이용률 == max(mean_시도_연령_이용률))

### 선생님풀이 ###
movie2 <- ddply(movie, .(지역.시도, age), summarise, v1=mean(이용_비율...))
ddply(movie2, .(지역.시도), subset, v1 == max(v1))   # = : 컬럼생성, == : 같다.

# 3) 지역.시도별 성별 이용비율의 평균을 비교하기 위한 막대그래프 출력
m2<- ddply(movie, .(지역.시도 ,성별), summarise, mean_시도_성별_이용률 = mean(이용_비율...))
m3 <- m2[,-c(1,2)]
class(m2)
barplot(as.matrix(m2[,-c(1,2)]), beside=T, col=rainbow(nrow(m2)), ylim = c(0, 0.003))
legend(30,0.003,m2$레전드,fill=rainbow(nrow(m2)), cex=0.4)
m2$레전드<-str_c(m2$지역.시도,m2$성별)

### 선생님풀이 ###
movie3 <- dcast(movie, 성별~지역.시도, value.var='이용_비율...', fun.aggregate=mean)
rownames(movie3) <- movie3$성별
movie3 <- movie3[,-1]
barplot(as.matrix(movie3), beside=T, col=c(2,3), ylim = c(0, 0.003))
legend(1,0.003,rownames(movie3), fill=c(2,3))

# 4) 위를 사용하여 각 지역.시도별 남여의 이용비율의 차지비율
# (예를들면 강원도는 여자가 45%, 남자가 55%)
movie3
f1 <- function(x) {
  x/sum(x) * 100
}
apply(movie3,2,f1)



# pie chart
pie(x,                # 벡터
    labels(lab) = ,   # 파이 이름
    radius = ,        # 파이 크기
    clockwise = F,    # 파이 진행 방향(시계방향 여부)
    init.angle = )    # 파이 시작 위치

v1 <- c(1,2,3,4)
pie(v1, col = rainbow(4))
pie(v1, col = rainbow(4), init.angle = 90)

# 예제) 위의 movie 데이터를 사용하여 서울특별시의 남녀별 이용평균을
# pie 차트로 표현
movie4 <- apply(movie3, 2, f1)   # apply 적용하면서 행렬로 변환됨...
movie4 <- as.data.frame(movie4)
movie4$서울특별시
rownames(movie4)

pie(movie4$서울특별시, col=rainbow(2))
pie_label <- paste(rownames(movie4), '\n',   # '\n' 파이차트에 삽입하면 한 층 내린 엔터로 파싱함.
                   round(movie4$서울특별시,2),'%',sep='')

pie(movie4$서울특별시, col=rainbow(2), lab = pie_label, radius=0.5)

# pie 3D : 3D 형식의 파이 차트
install.packages('plotrix')
library(plotrix)

pie3D(x,                # pie 차트로 출력할 숫자 벡터
      radius = ,        # 파이 크기
      theta = ,         # 파이 기울기
      labels = ,        # 파이 이름
      labelcex = 1.5,   # 파이 라벨 글자 크기
      explode = 0)      # 파이간 간격

pie3D(movie4$서울특별시, col=rainbow(2), labels = pie_label, explode = 0.05)

# 연습문제) movie 데이터를 사용하여 연령별 이용률 현황율 비교
# (서울시, 경기도, 인천광역시)
f2 <- function(x) {
  x/sum(x)
}

apply(m1$v1, 2, f2)

m1 <- movie2[movie2$지역.시도 == '서울특별시', ]
m2 <- movie2[movie2$지역.시도 == '경기도', ]
m3 <- movie2[movie2$지역.시도 == '인천광역시', ]

pie(m1$v1, col=rainbow(6), lab = pie_label1)
m1$시도age<- paste(m1$지역.시도, m1$age)
pie_label1 <- paste(m1$시도age, '\n',   
                    round(m1$v1,2),'%',sep='')


df1 <- dcast(movie, age~지역.시도, value.var='이용_비율...',
             fun.aggregate=mean)
par(mfrow = c(1,1))
pie3D(df1$서울특별시, col = rainbow(nrow(df1)),
      main = '서울특별시', cex.main=3)
pie3D(df1$경기도, col = rainbow(nrow(df1)),
      main = '경기도', cex.main=3)
pie3D(df1$인천광역시, col = rainbow(nrow(df1)),
      main = '인천광역시', cex.main=3)
legend(0.5,1.1,df1$age, fill=rainbow(nrow(df1)), cex=0.7)



# 머신러닝
# 1. 지도학습(y 존재)
# 1) 회귀(y가 연속형)

# 2) 분류(y가 범주형)
#  - knn
#  - decision tree, random forest, GB, XGB
#  - SVM

# 2. 비지도학습(y 존재 x)
#  - clustering

# 딥러닝(tensorflow, keras) in python
# in R




