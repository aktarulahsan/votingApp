import 'package:flutter/material.dart';
import 'package:votingapp/models/vote.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/state/vote.dart';

List<Vote> getVoteList(){
  List<Vote> voteList = List<Vote>();


voteList.add(Vote(
  voteId: Uuid().v4(),
  voteTitle: 'President ',
  options: [
    {'Sakib': 20},
    {'ali': 70},
    {'hasan': 90},
  ]
));
voteList.add(Vote(
  voteId: Uuid().v4(),
  voteTitle: 'Vice President',
  options: [
    {'Flutter': 70},
    {'Flutter': 70},
    {'Flutter': 70},
  ]
));
voteList.add(Vote(
  voteId: Uuid().v4(),
  voteTitle: 'Secretary ',
  options: [
    {'Flutter': 70},
    {'Flutter': 70},
    {'Flutter': 70},
  ]
));
voteList.add(Vote(
  voteId: Uuid().v4(),
  voteTitle: 'club officers',
  options: [
    {'Flutter': 70},
    {'Flutter': 70},
    {'Flutter': 70},
  ]
));
return voteList;
}

const String kVotes = 'votes';
const String kTitle = 'title';
void getVoteListFromFirestore(BuildContext context)async{
  Firestore.instance.collection(kVotes).getDocuments().then((snapshot) {
    List<Vote> voteList = List<Vote>();

    snapshot.documents.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });
}

Vote mapFirestoreDocToVote(document) {
  Vote vote = Vote(voteId: document.documentID);
  List<Map<String, int>> options = List();
  document.data.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String voteId, String option) async {
  // increment value

  Firestore.instance.collection(kVotes).document(voteId).updateData({
    option: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  Firestore.instance.collection(kVotes).document(voteId).get().then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });

}