

import 'package:flutter/cupertino.dart';
import 'package:votingapp/models/vote.dart';
import 'package:votingapp/services/service.dart';

class VoteState with ChangeNotifier{
  List <Vote> _voteList = List<Vote>();
  Vote _activeVote;
  String _selectedOptionInActiveVote;

  void loadVoteList(BuildContext context) async{
    // _voteList= getVoteList();
    // notifyListeners();
    getVoteListFromFirestore(context);

  }

void clearState(){
  _voteList = null;
  _activeVote= null;
  _selectedOptionInActiveVote = null;
}

List <Vote> get voteList => _voteList;
set voteList(newValue){
  _voteList = newValue;
  notifyListeners();
}

Vote get activeVote => _activeVote;
String get selectedOptionInActiveVote => _selectedOptionInActiveVote;

set activeVote(newValue){
  _activeVote = newValue;
  notifyListeners();
}

void set selectedOptionInActiveVote(String newValue){
  _selectedOptionInActiveVote = newValue;
  notifyListeners();
}

}