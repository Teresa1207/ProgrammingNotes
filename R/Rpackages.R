### Packages
pacs = c('ggplot2','Rmisc','gridExtra','grid','plyr','data.table','stringr','RColorBrewer')

iP = function(x){install.packages(x)}
iP(pacs)
lapply(1:length(pacs), function(x){iP(pacs[x])})
