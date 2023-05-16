library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(readxl)
library(haven)
library(stringr)
library(forcats)

raw = read_sav("Koweps_hpc16_2021_beta1.sav")

dim(raw)

welfare = raw %>% select('h16_g3',   # 성별
                         'h16_g4',   # 태어난 연도
                         'h16_g6',   # 교육 수준
                         'h16_eco9', # 직종 코드
                         'h16_reg7', # 지역 코드
                         'p1602_8aq1' # 월급
) %>%
  set_colnames(c('성별', '연도', '교육', '직종', '지역', '월급'))

welfare %>%
  select(성별) %>%
  table()

welfare = welfare %>%
  mutate(성별 = if_else(성별 == 1, '남', '여'))
      
welfare %>%
  select(성별) %>%
  ggplot(aes(x = 성별)) +
  geom_bar()

welfare %>%
  select(나이) %>%
  ggplot(aes(x = 나이)) +
  geom_bar()

welfare %>%
  select(월급) %>%
  summary()

welfare = welfare %>%
  mutate(월급 = if_else(월급 == 0, NA, 월급))

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(성별) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 성별, y = 평균월급)) +
  geom_col()


welfare = welfare %>%
  mutate(나이 = 2020 - 연도)


welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(나이) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 나이, y = 평균월급)) +
  geom_line() +
  geom_vline(xintercept = 45, color = 'red', linetype = 2) +
  geom_vline(xintercept = 60, color = 'red')

welfare = welfare %>%
  mutate(연령대 = if_else(나이 < 30, '초년', if_else(나이 <= 50, "중년", "노년")))

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(연령대) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 연령대, y = 평균월급)) +
  geom_col() +
  scale_x_discrete(limits = c('초년', '중년', '노년')) #라벨링순서지정

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(성별, 연령대) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 연령대, y = 평균월급, fill = 성별)) +
  geom_col(position = 'dodge') + #dodge 안 해주면 위로 쌓이기만함
  scale_x_discrete(limits = c('초년', '중년', '노년'))

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(성별, 나이) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 나이, y = 평균월급, color = 성별)) +
  geom_line(linewidth = 1.4)+
  geom_point(size=3)

welfare %>%
  filter(나이<35)
  select(교육) %>%
  table() %>%
  prop.table() %>%
  round(., 4)

welfare = welfare %>%
  mutate(교육 = case_when(
    교육 == 1 ~ '1_미취학(만7세미만)',
    교육 == 2 ~ '2_무학(만7세이상)',
    교육 == 3 ~ '3_초등학교',
    교육 == 4 ~ '4_중학교',
    교육 == 5 ~ '5_고등학교',
    교육 == 6 ~ '6_전문대학',
    교육 == 7 ~ '7_대학교',
    교육 == 8 ~ '8_대학원(석사)',
    교육 == 9 ~ '9_대학원(박사)',
    TRUE ~ 'NA'
  )
  )

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(교육) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 교육, y = 평균월급)) +
  geom_col()

welfare %>%
  mutate(나이대 = case_when(
    나이 <= 20 ~ '1_20세이하',
    나이 <= 30 ~ '2_21~30세',
    나이 <= 40 ~ '3_31~40세',
    나이 <= 50 ~ '4_41~50세',
    나이 <= 60 ~ '5_51~60세',
    TRUE ~ '6_60세이상'
  )
  ) %>%
  filter(!is.na(월급)) %>%
  group_by(나이대, 교육) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 교육, y = 평균월급)) +
  geom_col() +
  facet_grid( ~ 나이대)

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(성별, 교육) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 교육, y = 평균월급, fill = 성별)) +
  geom_col(position = 'dodge')


welfare %>%
  filter(나이<50)%>%
  group_by(교육) %>%
  summarize(n = n()) %>%
  mutate(freq = n / sum(n) * 100)

welfare %>%
  group_by(성별, 교육) %>%
  summarize(n = n()) %>%
  mutate(freq = n / sum(n) * 100) %>%
  select(-n) %>%
  pivot_wider(names_from = 성별, values_from = freq)

job = read_excel("(한국복지패널)_1_16차_결합데이터_코드북_가구데이터(release_220408).xlsx",
                 sheet = '직종코드(14-15차)')

job = job %>% select(1:4) %>%
  set_colnames(c('대분류', '중분류', '소분류', '소분류명')) %>%
  fill(대분류, 중분류) #fill : NA값들을 위의 데이터값으로 채우기

welfare = welfare %>%
  mutate(직종 = str_pad(직종, 4, 'left', 0)) %>%
  left_join(job, by = c('직종' = '소분류'))

income_by_job = welfare %>%
  filter(!is.na(월급)) %>%
  group_by(소분류명) %>%
  summarize(평균월급 = median(월급)) %>%
  arrange(desc(평균월급))

income_by_job %>%
  top_n(30) %>%
  ggplot(aes(x = 소분류명, y = 평균월급)) +
  geom_col() +
  coord_flip() +
  xlab('')

income_by_job %>%
  top_n(30) %>%
  ggplot(aes(x = fct_reorder(소분류명, 평균월급), y = 평균월급)) +
  geom_col() +
  coord_flip() +
  xlab('')

income_by_job %>%
  top_n(-30) %>%
  ggplot(aes(x = fct_reorder(소분류명, 평균월급), y = 평균월급)) +
  geom_col() +
  coord_flip() +
  xlab('')

welfare = welfare %>%
  mutate(지표 = if_else(between(나이, 15, 64), '생산가능인구',
                      if_else(나이 >= 65, '고령', '아동'))) %>%
  mutate(지역명 = case_when(
    지역 == 1 ~ '1_서울',
    지역 == 2 ~ '2_수도권(인천/경기) ',
    지역 == 3 ~ '3_부산/경남/울산',
    지역 == 4 ~ '4_대구/경북',
    지역 == 5 ~ '5_대전/충남',
    지역 == 6 ~ '6_강원/충북',
    지역 == 7 ~ '7_광주/전남/전북/제주도',
    TRUE ~ 'NA'
  ))

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(지역명) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 지역명, y = 평균월급)) +
  geom_col()

welfare %>%
  group_by(지역명) %>%
  summarize(n = n()) %>%
  mutate(prop = n / sum(n))

welfare %>%
  filter(지표 != '아동') %>%
  group_by(지역명, 지표) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  pivot_wider(names_from = '지표', values_from = n) %>%
  mutate(고령화수준 = 고령 / 생산가능인구) %>%
  ggplot(aes(x = 지역명, y = 고령화수준)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=rev)
