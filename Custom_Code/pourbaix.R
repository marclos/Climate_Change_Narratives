install.packages("CHNOSZ")
library(CHNOSZ)
info("aden ")
info("Mn ")
subcrt("adenine", T = 100)
subcrt("Mn+3", T=25)
basis("CHNOSe")
species(c("adenine", "cytosine", "guanine", "thymine", "uracil"))
a <- affinity(H2O = c(-12, -0), Eh = c(-0.4, -0.2), T = 100)
diagram(a)

basis("CHNOSe")
species(c("Mn+2", "Mn+3", "MnO4-"))
basis(c("Mn+2", "Mn+3", "MnO4-", "MnOH+"))
#, "MnO4-2"))

basis("CHNOS+")
species(c("H2S", "HS-", "HSO4-", "SO4-2"))
basis("CHNOSe")
thermo()$basis
info("Mn ")
basis(c("MnO2-2", "Mn+2", "Mn+3", "MnO", "MnOH+", "MnO4-2", "H2O", "H+", "O2"))

species(c("MnO2-2", "Mn+2", "Mn+3", "MnO"))
unlist(affinity()$values)
swap.basis("O2", "e-")
a <- affinity(pH = c(0, 12), Eh = c(-0.5, 1))

diagram(a, fill = "terrain", lwd = 2, lty = 3,
  #names = c("hydrogen sulfide", "bisulfide", "bisulfate", "sulfate"),
  tplot = FALSE, main = "sulfur species, 25 °C", bty = "n")



