library(ggplot2)
library(data.table)

df = fread('Economist_Assignment_data.csv',drop = 1)

head(df)

pl = ggplot(df, aes(x=CPI,y=HDI,color=Region)) + geom_point(shape = 1,size=5)
pl

pl + geom_smooth(aes(group=1))


pl2 = pl + geom_smooth(aes(group=1),method='lm',formula = y~log(x),se=FALSE,color='red')
pl2

pl2 = pl2 + geom_text(aes(label=Country))
pl2

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 = pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3


pl4 = pl3 + theme_bw()
pl4

pl5 = pl4 + scale_x_continuous(name='Corruption perceptions Index, 2011 (10=least corrupt)', limits=c(1,10),breaks=1:10)
pl5

pl6 = pl5 + scale_y_continuous(name='Human Development Index, 2011 (1=Best)',limits = c(0.2,1.0))
pl6

print(pl6 + ggtitle('Corruption and Human development'))
