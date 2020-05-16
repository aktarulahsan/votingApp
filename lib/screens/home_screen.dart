import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/state/vote.dart';
import 'package:votingapp/widgets/vote.dart';
import 'package:votingapp/widgets/vote_list.dart';
import '../state/vote.dart';
import '../services/service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentStep = 0;
    String ctitle;
  @override
  void initState() {
    super.initState();
    // loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ctitle ='choose Symbol';
    return Container(
      child: Column(
        children: <Widget>[
          if (Provider.of<VoteState>(context, listen: false).voteList != null)
          Expanded(
              child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            
            onStepContinue: () {
              if (_currentStep == 0) {
                if (step2Required()) {
                  setState(() {
                    _currentStep =
                        (_currentStep + 1) > 1 ? 1 : _currentStep + 1;
                    // ++ _currentStep;
                  });
                } else {
                  showSnackBar(context, 'please select a vote first');
                }
              }else if(_currentStep==1){
                this.ctitle= 'choose Symbol';
                  if(step3Required()){
                    //submit vote
                    markMyVote();
                    //goto result
                    Navigator.pushReplacementNamed(context, '/sucess');
                    // Navigator.pushReplacementNamed(context, '/result');
                  }else{
                    showSnackBar(context, 'please mark your vote');
                  }
              }
            },
            steps: [
              getStep(
                title: ctitle,
                child: VoteListWidget(),
                isActive: true,
              ),
              getStep(
                title: 'vote',
                child: VoteWidget(),
                isActive: _currentStep >= 1 ? true : false,
              ),
            ],
            // onStepCancel: () {
            //   setState(() {
            //     _currentStep = (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
            //   });
            // },
            onStepCancel: () {
              if (_currentStep <= 0) {
                Provider.of<VoteState>(context).activeVote = null;
              } else if (_currentStep <= 1) {
                Provider.of<VoteState>(context).selectedOptionInActiveVote =
                    null;
              }

              setState(() {
                _currentStep = (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
              });
            },
          )),
        ],
      ),
    );
  }

  bool step2Required() {
    if (Provider.of<VoteState>(context).activeVote == null) {
      return false;
    }

    return true;
  }
  bool step3Required() {
    if (Provider.of<VoteState>(context).selectedOptionInActiveVote == null) {
      return false;
    }

    return true;
  }

  void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 22),
      ),
    ));
  }

  Step getStep({String title, Widget child, bool isActive = false}) {
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  void markMyVote() {
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote.voteId;
    final option = Provider.of<VoteState>(context, listen: false)
        .selectedOptionInActiveVote;

    markVote(voteId, option);
  }
}
