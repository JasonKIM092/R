# 1. plot 그래프 그리기
plot(x,     # x축 데이터
     y,     # y축 데이터
     ...)   # 옵션

v1 <- c(1,3,5,7,10)
v2 <- c(100,150,170,200,300)
plot(v1)   # 데이터를 하나만 쓰게 되면, 해당 데이터는 y축으로 설정된다.

plot(v2,v1)

# type : 라인의 모양 설정
plot(v2,v1, type = 'l')
plot(v2,v1, type = 'o')

# col : 그래프 컬러 설정(숫자전달 또는 컬러 이름전달)
plot(v2,v1, type = 'o', col = 2)
plot(v2,v1, type = 'o', col = 'blue')

# ylim : y축 범위 설정(벡터로 전달).             cf) xlim : x축 범위 설정 옵션(벡터로 전달).
plot(v2,v1, type = 'o', col = 'blue', ylim = c(0,15))

# xlab, ylab, main : 그래프의 이름 설정
plot(v2,v1, type = 'o', xlab = 'x축 이름',
                        ylab = 'y축 이름',
                        main = '그래프 이름')

# axis : x축과 y축 눈금 설정(개수, 이름 변경)
# 축 눈금 변경 시 기존 축과 겹쳐 출력되므로 axes = F를 사용하여
# 축 자체를 출력하지 않고 새로 설정 필요

# 1) 겹쳐서 출력
plot(v1, type = 'o')

axis(1,                            # 방향(1 : x축, 2 : y축)
     at = 1:5,                     # 눈금 개수 설정
     lab=c('a','b','c','d','e'))   # 각 눈금의 이름 설정

# 2) 안겹쳐서 출력
plot(v1, type = 'o', ylim = c(0,15), axes = F)    # 축 눈금 출력 x
                                                  # ylim : y축 변경목적

axis(1,
     at = 1:5,
     lab=c('a','b','c','d','e'))

axis(2, ylim = c(0,10))   # ylim : y축 눈금 출력목적이지, 변경목적이 아니다.
                          # axis에서 ylim은 기존의 눈금 출력목적, 수정목적 x 

# Error in plot.new() : figure margins too large
# 1. R-studio의 오른쪽 plot창 넓게 설정
# 2. 새로운 figure분리 생성
dev.new()


# 예제) data.csv 파일에서 2014년의 총구직자수의 변화추이 선 그래프 출력
df1 <- read.csv('data.csv')
v1 <- df1[df1$년도 == 2014,'총구직자수']
plot(v1, type = 'o', col = 3, ylim = c(0,15000), axes = F,
     xlab = '월', ylab = '총구직자수', main = '월별 총구직자수')
axis(1,
     at = 1:12,
     lab=paste(1:12,'월',sep=''))   # paste 옵션은 공백이 자동으로 부여되어 sep=''옵션을 쓴 것.
                                    # str_c는 공백부여 x
axis(2, ylim = c(0,15000))

# 여러 선 그래프를 하나의 figure에 그리기
v1 <- c(1:10, 15)
v2 <- c(seq(1,20,2),20)

# 1) par(new=T)
# - 도표 그린 후 추가 도표 그리기 위한 옵션
# - 각 도표의 서로 다른 눈금이 같이 표현(중첩)

plot(v1, col = 1, type = 'o')
par(new=T)
plot(v2, col = 2, type = 'o')

plot(v1, col = 1, type = 'o', ylim = c(0,25))   # y축 범위를 똑같이 지정해준다.
par(new=T)
plot(v2, col = 2, type = 'o', ylim = c(0,25))

# 2) lines
# - plot 함수 대신 lines를 사용하여 두번째 그래프부터 연이은 출력 가능
# - 눈금은 첫 그래프의 눈금을 기준으로 출력(중첩x)

plot(v1, col = 1, type = 'o')   # y축 범위가 서로 달라서 그래프가 미완.
lines(v2, col = 2, type = 'o')

plot(v1, col = 1, type = 'o', ylim = c(0,25))   # y축이 작은 쪽에 범위를 늘려준다.
lines(v2, col = 2, type = 'o')

plot(v2, col = 2, type = 'o')   # 아니면 순서를 바꾼다.
lines(v1, col = 1, type = 'o')


# 예제) data.csv 파일에서 년도별 총구직자수의 변화추이 선 그래프 출력
df1
library(reshape2)
df2 <- dcast(df1, 월~년도, value.var = '총구직자수')[,-1]
plot(df2)   # 산점도 출력. 각 변수 간 상관관계 알 수 있음. 데이터분석에 유용하다.
            # 년도별 선그래프 출력 불가, 컬럼별 교차 산점도 출력
plot(iris[,-5])


plot(df2$`2014`, col=1, type='o', ylim = c(4000,12000), axes = F)
lines(df2$`2015`, col=2, type='o')
lines(df2$`2016`, col=3, type='o')
lines(df2$`2017`, col=4, type='o')
lines(df2$`2018`, col=5, type='o')
axis(1,
     at = 1:12,
     lab=paste(1:12,'월',sep=''))
axis(2, ylim = c(4000,15000))
# 데이터 프레임은 년도별 선그래프를 그릴려면,
# 직접 하나하나씩 선택해서 개별적으로 출력해줘야 한다.

# legend : 범례설정(그래프의 설명선)
legend(x,           # 범례가 그려질 x축 시작 위치. 내가 부여한 숫자가 아니라 프로그램 내부에서 부여한 숫자임.
                    # 현재 수정한 눈금 기준이 아니라, 본래 부여된 눈금 기준.
       y,           # 범례가 그려질 y축 끝 위치
       legend = ,   # 범례(그래프 설명)
       fill = ,     # 범례의 표현 형식이 네모(막대그래프/barplot 표현 시)
       lty = ,      # 범례의 표현 형식이 선(선그래프 표현 시)
       col = ,      # 범례의 선
       ...)         # 가로로 펼칠수 있는 옵션은 현재 없다...

legend(1,12000,colnames(df2), col=1:5, lty = 1)   # 범례를 없애거나 수정하고 싶다면 그래프를 처음부터 다시 생성해야 한다.
                                                  # 범례를 수정하거나 삭제하는 기능이 없다.


# 연습문제)
# subway2.csv 파일의 데이터를 기반으로
# 승차가 가장 많은 top5개의 역을 구하고
# 각 역의 시간대별 승차의 증감추세를 도표화
sub <- read.csv('subway2.csv', stringsAsFactors = F, skip = 1)

# step1) 승차 선택
sub2 <- sub[sub$구분 == '승차', -2]
rownames(sub2) <- sub2$전체
sub2 <- sub2[,-1]
head(sub2)

# step2) 천단위 구분기호 삭제 및 숫자변경
library(stringr)
f1 <- function(x) {
  as.numeric(str_remove_all(x,','))
}
sub2[,] <- apply(sub2,c(1,2),f1)
head(sub2)

# step3) 역별 승차 총 합
v_sum <- apply(sub2, 1, sum)

# step4) top5개 역 선택
# order : 순번나옴. 데이터프레임 전달. 즉 행번호 나옴. 쉘번호... 그래서 위치값 전달해줘야 한다.
# sort : 출력된 값 그대로 출력. 벡터정렬에 좋음
sort(v_sum, decreasing = T)[1:5]
v_top <- v_sum[order(v_sum, decreasing = T)][1:5]
total <- sub2[rownames(sub2) %in% names(v_top),]

# step5) 그래프 출력
total <- t(total)   # plot함수에 행을 전달할 경우, 오류가 난다. 그래서 t()함수를 사용하여 컬럼으로 변경해준다.
plot(total[,1]/10000, col=1, type='o', ylim = c(0,40),
     ylab='승차(만)', xlab='시간', main = '역별 승차 시간별 추이',
     axes = F)
lines(total[,2]/10000, col=2, type='o')
lines(total[,3]/10000, col=3, type='o')
lines(total[,4]/10000, col=4, type='o')
lines(total[,5]/10000, col=5, type='o')
v_time <- as.numeric(substr(rownames(total),2,3))
axis(1,
     at = 1:length(v_time),
     lab=v_time)
axis(2, ylim = c(0,40))
legend(1,40,colnames(total), col=1:5, lty = 1, cex = 0.6)   # cex = . 범례글씨크기 옵션



colnames(total) <- str_remove_all(colnames(total),' ')
plot(total$강남, col=1, type='o') 


# mfrow 옵션 : figure 내 표현 가능한 그래프의 개수 및 형태 전달
par(mfrow=c(1,3))   # 한개만 크게 출력하고 싶으면, dev.new()를 다시 실행시키거나, mfrow=c(1,1)로 설정.
plot(1:10, type = 'o')
plot(2:11, type = 's')
plot(3:12, type = 'l')

# 2. barplot
# 1) 벡터의 barplot 출력
par(mfrow=c(1,1))
dev.new()
v1 <- c(1,3,5,10)
barplot(v1, col = 1:4)
barplot(v1, col = rainbow(4))

# 2) 데이터 프레임의 barplot 출력
df1 <- data.frame(orange = c(100,200,300),
                  mango = c(150,110,250))
rownames(df1) <- c(2000,2001,2002)
df1
barplot(df1)   # 에러발생
# error : 'height'는 반드시 벡터 또는 행렬이어야 합니다 -> matrix 변경
barplot(as.matrix(df1))
barplot(as.matrix(df1),
        beside = T, col = rainbow(3))   # beside = T : 각 년도별로 각자의 막대로 표현하는 옵션. 위 출력값이랑 비교!!
legend(1,300, rownames(df1), fill = rainbow(3))


# 연습문제)
# 상반기사원별월별실적현황_new.csv을 읽고,
# 월별 각 직원의 성취도를 비교하기 위한 막대그래프 출력
acv <- read.csv('상반기사원별월별실적현황_new.csv', stringsAsFactors = F)
class(acv)

acv1 <- dcast(acv, 이름~월, value.var = '성취도')
rownames(acv1) <- acv1$이름
acv1 <- acv1[,-1]
acv1
sapply(acv1,sum)

barplot(as.matrix(acv1), col = rainbow(7), ylim = c(0,10))
legend(6,10, rownames(acv1), fill = rainbow(7))

barplot(as.matrix(acv1), beside = T, col = rainbow(7), ylim = c(0,1.5))
legend(40,1.5, rownames(acv1), acv1$이름, fill = rainbow(7), cex=0.8)
