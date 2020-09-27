# Use Roster to Create Peer Review Assignments
# From 2014 version, lost 2019 version...ugh!

# Import Roster
roster.csv = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Admin/Random_IDs/EA30F20_Roster.csv"
roster = read.csv(roster.csv)

# Function Randomization of Product Author Student IDs

sampler <- function(author) {
  review <- sample(author)
  review
}

sampler(roster$ID);

repeats <- c(1,2,3)
while(sum(repeats)>0) {
  set.seed(333)
  Review1=sampler(roster$ID); Review1
  Review2=sampler(roster$ID); Review2
  Review3=sampler(roster$ID); Review3
  
  for(i in 1:length(roster$ID)) {
    repeats[i] = sum(roster$ID[i]==Review1[i], roster$ID[i]==Review2[i],
                     roster$ID[i]==Review3[i],
                     Review1[i]==Review2[i], Review1[i]==Review3[i], 
                     Review2[i]==Review3[i] )
  }
  repeats
}

set.seed(1533)
rndnumbers = sample(1000:9999,length(roster$ID)*1);rndnumbers

ThreeReviewer <- data.frame(Author=roster$ID, 
      ReviewID.1=Review1, ReviewID.2=Review2, ReviewID.=Review3, 
      Repeated=repeats, 
                    Review1=rndnumbers[1:length(roster$ID)],
                    Review2=rndnumbers[c(length(roster$ID)+1):c(length(roster$ID)*2)],
                    Review3=rndnumbers[c(length(roster$ID)*2+1):c(length(roster$ID)*3)]);
ThreeReviewer

Review1 <- data.frame(Name= ThreeReviewer$ReviewID.1, Random1=ThreeReviewer$ReviewID.2); Review1
Review2 <- data.frame(Name= ThreeReviewer$Reviewer2name, Random2=ThreeReviewer$Reviewer2); Review2
Review3 <- data.frame(Name= ThreeReviewer$Reviewer3name, Random3=ThreeReviewer$Reviewer3); Review3

combined <- merge(Review1, Review2, by.x="Name")
combined <- merge(combined, Review3, by.x="Name"); combined

PeerReviewAssignments = merge(roster, ThreeReviewer, by.x="ID", by.y="Author")


write.csv(ThreeReviewer[,c(1,6:8)], file = "C:\\Documents and Settings\\losh0935\\Desktop\\PeerReviewers.csv")
write.csv(combined, file = "C:\\Documents and Settings\\losh0935\\Desktop\\PeerReviewedAssignments.csv")

