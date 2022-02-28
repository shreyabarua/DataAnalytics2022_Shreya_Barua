expenditure <- read.csv("~/Downloads/SYB64_245_202110_Public expenditure on education.csv")
summary(expenditure)

colnames(expenditure) <- as.character(as.vector(expenditure[1,])) # rename columns

expenditure <- expenditure[-c(1), ] # remove first row
View(expenditure)
# Higher expenditure on education leads to higher overall GDP of a country

# Compare Public expenditure on education (% of GDP) to DGP per capita of 
# a country and see if there is a correlation
# stretch: see if there is correlation with how many women have seats in the
# national parliament and public expenditure on education
# women and economic growth

# gdp data from world bank

# read 3 to 5 papers by Monday
# literature review

gdp <- read.csv("~/Downloads/SYB64_230_202110_GDP and GDP Per Capita.csv")
colnames(gdp) <- as.character(as.vector(gdp[1,])) # rename columns

gdp <- gdp[-c(1), ] # remove first row
View(gdp)

