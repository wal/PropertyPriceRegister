library(gmodels)
library(ggplot2)
library(scales)


data.2013<- read.csv('data/cleaned/PPR-2013-Dublin.csv', stringsAsFactors = FALSE)
data.2014 <- read.csv('data/cleaned/PPR-2014-Dublin.csv', stringsAsFactors = FALSE)

data <- rbind(data.2013, data.2014)

names(data) <- c('Date.of.Sale','Address','Postal.Code','County','Price','Not.Full.Market.Price','VAT.Exclusive','Description.of.Property','Property.Size.Description')

str(data)
data$Postal.Code <- as.factor(data$Postal.Code)
data$County <- as.factor(data$County)
data$Date.of.Sale <- as.Date(data$Date.of.Sale,"%m/%d/%Y")
data$SaleMonth <- as.Date(cut(data$Date.of.Sale,  breaks = "month"))
data$Description.of.Property <- as.factor(data$Description.of.Property)
data$Property.Size.Description <- as.factor(data$Property.Size.Description)
data$VAT.Exclusive <- as.factor(data$VAT.Exclusive)
data$Not.Full.Market.Price <- as.factor(data$Not.Full.Market.Price)


price_range <- 250000:700000
post_codes <- c('Dublin 3', 'Dublin 5')

data.subset <- subset(data, Price %in% price_range & Postal.Code %in% post_codes)

pdf("2013-2014-summary.pdf")
ggplot(data.subset, aes(SaleMonth,Price)) + stat_summary(fun.y = mean, geom="line") + geom_smooth(method='lm')

ggplot(data.subset, aes(Postal.Code, Price)) + geom_boxplot()
dev.off();


