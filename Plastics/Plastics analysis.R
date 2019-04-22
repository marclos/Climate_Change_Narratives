
test1 = c(17.66666667, 9.333333333, 18, 12, 7, 30.33, 7, 12.33, 15.66, 14.33)
test2 = c(2, 6.33, 6.33, 9.33, 1, 1.66, 1.33, 1.66, 0.33, 8.66)

t.test(test1, test2)

number <- sample(1:8, 1)

sample(1:8, 1, replace=TRUE) 
install.packages("ggpubr")


boxplot(test1 ~ test2,
        names= c("Lake","Campus"),
        ylab= "Microplastics", 
        xlab="site")
