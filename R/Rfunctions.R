### Common Functions to use ###

mytab <- function(...) table(..., useNA='ifany')

first <- which(!duplicated(rush2$id))
last  <- c(first[-1] -1, nrow(rush2))
count <- table(rush2$study[last])