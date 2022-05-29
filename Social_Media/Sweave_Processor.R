
filename <- paste0("..\docs\Social_Media\Climate", format(Sys.Date(), "%d%m%Y"), ".tex")
Sweave("filename.Rnw", output=filename)
tools::texi2pdf(filename)