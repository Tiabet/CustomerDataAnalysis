diamonds %>% filter(carat >= 1)
diamonds %>% filter('carat' >= 1)
min = 1
diamonds %>% filter(carat > min)

min = 1
diamonds[diamonds$carat > min, ]

var = "carat"
diamonds[diamonds[[var]] > min, ]

min = 1
diamonds %>% filter(.data$carat > .env$min)

var = 'carat'
diamonds %>% filter(.data[[var]] > .env$min)
