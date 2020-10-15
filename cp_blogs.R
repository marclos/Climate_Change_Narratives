#!/bin/bash

# identify the folders

Student_Folders <- "Student_Folders"
docs <- "docs/F2020"
# find the files that you want
list.of.folders <- list.files(Student_Folders)
list.of.files <- list.files(paste("Student_Folders/",list.of.folders, sep=""), "*.html")
# copy the files to the new folder
Student.html = paste("Student_Folders/",list.of.folders,"/",list.of.folders,".html", sep="")
file.copy(Student.html, docs, overwrite=TRUE)

