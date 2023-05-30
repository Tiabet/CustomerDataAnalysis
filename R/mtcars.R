library(DT)
library(ggplot2)
library(dplyr)
library(magrittr)

mtcars %>%
  select(mpg, cyl, wt) %>%
  filter(cyl == 6)

mtcars %>%
  select(mpg, cyl, wt) %>%
  filter(cyl %in% c(4,6))

mtcars %>%
  select(mpg, cyl, wt) %>%
  filter(cyl %in% c(4, 6)) %>%
  ggplot(aes(x = mpg, y = wt, color = factor(cyl))) +
  geom_point(size = 5)
