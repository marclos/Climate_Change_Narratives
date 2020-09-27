
# Randomziation for Peer Review

roster <- c(  "Sean J. Noble",
              "David J. Minovitz", 
              "Michael Hang",
              "Patrick J. Mulcahy",
              "Tera L. Curren",
              "Winn R. Mcenery",
              "Afreen Malik",
              "Heather A. Thams",
              "Chelsea D. Neill", 
              "Kyle O. Olejniczak", 
              "Ashley M. Quackenbush", 
              "Michael W. Esgro", 
              "Sarah E. Finstad", 
              "Jessica Missaghian", 
              "John F. Inman")
length(roster)

sampler <- function(author) {
  reviewer <- sample(author)
  reviewer
}

sampler(roster);

repeats <- c(1,2,3)
while(sum(repeats)>0) {
  Reviewer1=sampler(roster); Reviewer1
  Reviewer2=sampler(roster); Reviewer2
  Reviewer3=sampler(roster); Reviewer3
  
  for(i in 1:length(roster)) {
    repeats[i] = sum(roster[i]==Reviewer1[i],roster[i]==Reviewer2[i],roster[i]==Reviewer3[i],
                     Reviewer1[i]==Reviewer2[i], Reviewer1[i]==Reviewer3[i], Reviewer2[i]==Reviewer3[i] )
  }
  repeats
}

rndnumbers = sample(1000:9999,length(roster)*3);rndnumbers

ThreeReviewer <- data.frame(Author=roster, Reviewer1name=Reviewer1, Reviewer2name=Reviewer2,
                            Reviewer3name=Reviewer3, Repeated=repeats, Reviewer1=rndnumbers[1:length(roster)],
                            Reviewer2=rndnumbers[c(length(roster)+1):c(length(roster)*2)],
                            Reviewer3=rndnumbers[c(length(roster)*2+1):c(length(roster)*3)]); ThreeReviewer

Review1 <- data.frame(Name= ThreeReviewer$Reviewer1name, Random1=ThreeReviewer$Reviewer1); Review1
Review2 <- data.frame(Name= ThreeReviewer$Reviewer2name, Random2=ThreeReviewer$Reviewer2); Review2
Review3 <- data.frame(Name= ThreeReviewer$Reviewer3name, Random3=ThreeReviewer$Reviewer3); Review3

combined <- merge(Review1, Review2, by.x="Name")
combined <- merge(combined, Review3, by.x="Name"); combined
write.csv(ThreeReviewer[,c(1,6:8)], file = "C:\\Documents and Settings\\losh0935\\Desktop\\PeerReviewers.csv")
write.csv(combined, file = "C:\\Documents and Settings\\losh0935\\Desktop\\PeerReviewedAssignments.csv")

