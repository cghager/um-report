library(tidyverse) #loading tidyveres package

#the next line reads in the gapminder_1997.csv flie
gapminder_1997 <- read_csv(file = "Data/gapminder_1997.csv")


#this assigns a argument value to the name function
name <- "Burness Lab"

Sys.Date() #prints date and time
getwd() #prints the current workign directory
sum(5,6)


?round
round(x=3.1415, digits=2)
round(digits=2, x=3.1415)


################## plotting ##########################
#using ggplot2

ggplot(Sata=gapminder_1997)

#need to tell ggplot astetic mapping. this tells it what we want to map on x and y and what color and size
#need to add a layer, the + then enter tabs over the line and includes it in the code line above
#aes gives x values. The code will run until it doesn't see any more plus marks
#labs changes labels
# aes(color= ) can color biased on parameter. To spesify color use  scale_color_brewer

ggplot(gapminder_1997) +
  aes(x=gdpPercap) +
  labs(x="GDP Per Capita")+
  aes(y=lifeExp)+
  labs(y="Life Expectancy")+
  geom_point()+
  labs(title= "Do people in wealthy countries live longer?")+
  aes(shape=continent)+
  scale_color_brewer(palette="Dark2")+
  aes(size=pop/1000000)+
  labs(size="Population (Millions)")+
  aes(color=continent)
ggsave("figures/gdpPercap_lifeExp.png")
  


#consolidate the above code

ggplot(gapminder_1997) +
  aes(x=gdpPercap, y=lifeExp, shape=continent,size=pop/1000000, color=continent) +
  geom_point()+
  labs(size="Population (Millions)", title= "Do people in wealthy countries live longer?", x="GDP Per Capita", y="Life Expectancy")+
  scale_color_brewer(palette="Dark2")+ ggsave("figures/gdpPercap_lifeExp.png")

