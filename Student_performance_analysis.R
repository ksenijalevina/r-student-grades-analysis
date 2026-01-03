
#=============================================

# Data loading and view

#=============================================

df <- read.csv("student_data.csv")
df
str(df)
summary(df)
any(is.na(df)) #There are clear dataset without NA values





# ==============================

# Data preparation

# ==============================

# Convert categorical variables to factor for correct grouping in plots

df$sex      <- factor(df$sex)
df$Pstatus  <- factor(df$Pstatus)
df$romantic <- factor(df$romantic)
df$paid     <- factor(df$paid)
df$internet <- factor(df$internet)
df$activities <- factor(df$activities)
df$studytime <- factor(df$studytime, ordered = TRUE)





# ==============================

# Exploratory data analysis

# ==============================
# Save key plots as PNG for GitHub (README)

if (!dir.exists("plots")) {
  dir.create("plots")
}

png("plots/g3_distribution.png", width = 800, height = 600)

hist(df$G3, col = 'lightblue', main = 'Final grafe distribution', xlab = 'Final grade')

dev.off()

png("plots/g3_by_gender.png", width = 800, height = 600)

boxplot(G3~sex,data = df, col = c('lightblue', 'pink'), 
        xlab = 'Sex', ylab = 'Final grade', main = 'Final grade by gender')

str(boxplot(G3~sex,data = df, col = c('lightblue', 'pink'), 
                xlab = 'Sex', ylab = 'Final grade', main = 'Final grade by gender'))
dev.off()

png("plots/g3_by_paid.png", width = 800, height = 600)

boxplot(G3~paid, data = df, col = c('lightgreen','lightblue'),
        main = 'Final grade by paid',xlab = 'Paid', ylab = 'Final grade')

dev.off()

png("plots/g3_by_romantic.png", width = 800, height = 600)

boxplot(G3~romantic, data = df, col = c('gold','yellow'),
        main = 'Final grade by romantic', xlab = 'Romantic', ylab = 'Final grade')

dev.off()


png("plots/g3_by_studytime.png", width = 800, height = 600)

boxplot(G3~studytime, data = df,
        col = c('gold','pink','lightgreen','lightblue'),
        xlab = 'Study time', ylab = 'Final grade', main = 'Final grade by study time')

dev.off()




vec <- c('paid', 'romantic','internet','activities','age', 'studytime', 'absences')
for (v in vec) {
  cat("\nVariable:",v,"\n")
  print(aggregate(df$G3~df[[v]], FUN = mean))
}

# Linear regression to examine associations with final grade (G3)


model <- lm(G3 ~ studytime + age + romantic + absences, data = df)
summary(model)
model
confint(model)
plot(model)

# Correlation calculation

cor(df$G3, df$age)

studytime_num <- as.numeric(df$studytime)
cor(df$G3, studytime_num)

