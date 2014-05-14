library(gmodels)
library(ggplot2)

data <- read.csv("data/PPR-2014-Dublin_cleaned.csv", stringsAsFactors=FALSE)
str(data)

names(data) <- c('Date.of.Sale','Address','Postal.Code','County','Price','Not.Full.Market.Price','VAT.Exclusive','Description.of.Property','Property.Size.Description')

data$Postal.Code <- as.factor(data$Postal.Code)
data$County <- as.factor(data$County)

data$Description.of.Property <- as.factor(data$Description.of.Property)
data$Property.Size.Description <- as.factor(data$Property.Size.Description)
data$VAT.Exclusive <- as.factor(data$VAT.Exclusive)
data$Not.Full.Market.Price <- as.factor(data$Not.Full.Market.Price)

str(data)

postcode_by_price_range<- function(postcode, price_range) {
    subset(data, Postal.Code == postcode & Price %in% price_range)
}


price_range <- 250000:700000
post_codes <- c('Dublin 3', 'Dublin 5')

data.subset <- subset(data, Price %in% price_range & Postal.Code %in% post_codes)

jpeg("boxplot.jpg")
ggplot(data.subset, aes(Postal.Code, Price)) + geom_boxplot()
dev.off();


