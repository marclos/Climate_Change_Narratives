# Detection Limits

Blank =c(-1.3, 2.3, 3.1, -.3, .43, -2.5, -.22, -.94); mean(Blank)
LowConc = c(3.8, 3.1, 3.6, 3.6, 3.2, 4.4, 5.1); mean(LowConc)

LoB = mean(Blank) + 1.645*(sd(Blank)); LoB

LoD = LoB + 1.645*(sd(LowConc)); LoD
 
LoQ = LoB + 3*1.645*(sd(LowConc)); LoQ

conc_range = seq(-10, 10, .1); conc_range

plot(conc_range, dnorm(conc_range, mean=mean(Blank), sd=sd(Blank)), 
     ty='l', ylab="Probability", ylim=c(0, .6), col="red")
lines(conc_range, dnorm(conc_range, mean=mean(LowConc), sd=sd(LowConc)), col="blue")

abline(v=LoB, col="red")
abline(v=LoD, col="blue")
abline(v=LoQ, col="darkgreen")

