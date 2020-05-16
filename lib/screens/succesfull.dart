import 'package:flutter/material.dart';

class SuccesfullyScreen extends StatelessWidget {

  // final FirebaseUser user;

  // SuccesfullyScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(" Congratulations  Your Vote submit succesfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
            SizedBox(height: 16,),
            Text("", style: TextStyle(color: Colors.grey, ),),
          ],
        ),
      ),
    );
  }
}