# Use Roster to Create Peer Review Assignments
# From 2014 version, lost 2019 version...ugh!

# Import Roster
roster.csv = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Admin/Random_IDs/EA30F20_Roster.csv"
roster = read.csv(roster.csv)
# roster = roster[order(roster$ID),]
# Function Randomization of Product Author Student IDs

sampler <- function(author) {
  review <- sample(author)
  review
}

sampler(roster$ID);

repeats <- c(1,2,3)
while(sum(repeats)>0) {

  Review1=sampler(roster$ID); Review1
  Review2=sampler(roster$ID); Review2
  Review3=sampler(roster$ID); Review3
  
  for(i in 1:length(roster$ID)) {
    repeats[i] = sum(roster$ID[i]==Review1[i], 
                     roster$ID[i]==Review2[i],
                     roster$ID[i]==Review3[i],
                     Review1[i]==Review2[i], 
                     Review1[i]==Review3[i], 
                     Review2[i]==Review3[i])
  }
  repeats
}

set.seed(1533)
rndnumbers = sample(1000:9999,length(roster$ID)*1);rndnumbers



ThreeReviewer <- data.frame(Reviewer=roster$ID, 
      ReviewID.1=Review1, ReviewID.2=Review2, ReviewID.3=Review3, 
      Repeated=repeats, RandomID=rndnumbers)

ThreeReviewer

PeerReviewAssignments = merge(roster, ThreeReviewer, by.x="ID", by.y="Reviewer")

PeerReviewAssignments$ReviewName1 = roster$Last[match(PeerReviewAssignments$ReviewID.1, roster$ID)]
PeerReviewAssignments$ReviewName2 = roster$Last[match(PeerReviewAssignments$ReviewID.2, roster$ID)]
PeerReviewAssignments$ReviewName3 = roster$Last[match(PeerReviewAssignments$ReviewID.3, roster$ID)]

write.csv(PeerReviewAssignments[,c(1:7,9:12)], file = "/home/CAMPUS/mwl04747/github/Climate_Change_Narratives/Admin/Peer_Review_Sampler/Peer_Review_2020.csv")
#write.csv(combined, file = "C:\\Documents and Settings\\losh0935\\Desktop\\PeerReviewedAssignments.csv")

