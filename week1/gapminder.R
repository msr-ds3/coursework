library(tidyverse)
library(gapminder)
library(scales)

theme_set(theme_bw())

ggplot(data = gapminder,
       aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10(label = comma) +
  scale_size_area(label = comma) +
  labs(x = 'GDP per capita',
       y = 'Life expectancy',
       title = 'Health and wealth of countries over time') +
  facet_wrap(~ year)
ggsave('/tmp/gapminder.pdf', width = 12, height = 6)


library(gganimate)

p <- ggplot(data = gapminder,
            aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10(label = comma) +
  scale_size_area(label = comma) +
  labs(title = 'Health and wealth of countries over time: {frame_time}',
       x = 'GDP per capita',
       y = 'Life expectancy') +
  #facet_wrap(~ year) +
  transition_time(year) +
  ease_aes('linear') +
  scale_size_continuous(guide = F)

anim_save("/tmp/gapminder.gif", p)