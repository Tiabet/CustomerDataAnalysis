library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(readxl)
library(haven)
library(stringr)
library(forcats)

birth_marry = read_xlsx("midterm.xlsx", sheet = '출산및혼인')
motherage_avg = read_xlsx("midterm.xlsx", sheet = '모나이평균')
motherage_group = read_xlsx("midterm.xlsx", sheet = '모나이그룹')

#1번
birth_marry$DT=as.numeric(birth_marry$DT)

birth_marry %>%
  filter(ITM_NM_ENG=='TFR'&C1_NM=='전국') %>%
  ggplot(aes(x = PRD_DE, y = DT, group = 1)) +
  geom_line() +
  geom_hline(yintercept = 1, color = 'red', linetype = 2)

#한 번도 1 이하로 떨어진 적 없는 출산율이 2018년 들어서 처음으로 1 이하로 떨어졌다.
#출산율의 하락세는 2015년부터 계속되고 있다.


#2번
birth_marry %>%
  filter(!is.na(DT)&C1_NM!='전국'&C1_NM!='국외'&ITM_NM_ENG=='TFR'&PRD_DE=='2022')%>%
  ggplot(aes(x = fct_reorder(C1_NM, DT), y = DT)) +
  geom_col() +
  coord_flip() +
  xlab('시도') +
  ylab('출산율')

#2022년에는 세종시가 가장 높은 출산율을 보였고 서울특별시가 가장 낮은 출산율을 보였다.
#특이한 점은 많은은 광역시들이 평균보다 더 낮은 출산율을 보였다는 점이다.

#3번
birth_marry%>%
  filter(!is.na(DT)&ITM_NM_ENG=="Crude marriage rate(per 1000 population)"&C1_NM!='전국'&C1_NM!='국외')%>%
  ggplot(aes(x = PRD_DE, y = DT, group = 1))+
  geom_line()+
  facet_wrap(~C1_NM)
#모든 시-도의 출산율이 대체적으로 같은 방향을 그리고 있음을 확인할 수 있다.

#4번
motherage_avg$DT=as.numeric(motherage_avg$DT)

motherage_avg%>%
  ggplot(aes(x = PRD_DE, y = DT, group = 1))+
  geom_line()+
  geom_point()

#모의 결혼 연령이 해가 갈수록 꾸준히 증가하고 있는 것을 확인할 수 있다.
#출산율이 낮아짐과 동시에 결혼 연령도 점점 늦춰지는 것이다.

#5번
motherage_group$DT=as.numeric(motherage_group$DT)

motherage_group_wider = motherage_group %>% pivot_wider(names_from = 'PRD_DE', values_from = 'DT')
which(names(motherage_group_wider)=='C2_NM')
motherage_group_wider<-motherage_group_wider[,23:ncol(motherage_group_wider)]

#6번
motherage_group%>%
  filter(C2_NM=='계'&C3_NM!='총계')%>%
  group_by(PRD_DE) %>%
  mutate(DT_ratio = DT / sum(DT)) %>%
  ggplot(aes(x = PRD_DE, y = DT_ratio, group = C3_NM, color = C3_NM)) +
  geom_line()+
  geom_point()

#아동 1명, 2명의 비율이 압도적으로 높은 것을 확인할 수 있다. 
#그리고 2017년부터 1아의 비율은 급격히 늘어나고 2아,3아의 비율은 확연한 감소세를 보이는 것을 확인할 수 있다.