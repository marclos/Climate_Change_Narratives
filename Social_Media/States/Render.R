setwd('/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Social_Media')
getwd()
rmarkdown::render('index.Rmd', output_file = '../docs/Social_Media/index.html')
setwd('/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Social_Media/States')

rmarkdown::render('Alabama.Rmd', output_file = '../../docs/Social_Media/Alabama.html')
rmarkdown::render('Alaska.Rmd', output_file = '../../docs/Social_Media/Alaska.html')
rmarkdown::render('Arizona.Rmd', output_file = '../../docs/Social_Media/Arizona.html')
rmarkdown::render('Kansas.Rmd', output_file = '../../docs/Social_Media/Kansas.html')

rmarkdown::render('Texas.Rmd', output_file = '../../docs/Social_Media/Texas.html')
rmarkdown::render('Wisconsin.Rmd', output_file = '../../docs/Social_Media/Wisconsin.html')