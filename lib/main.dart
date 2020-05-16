import 'package:flutter/material.dart';
import 'package:votingapp/constants.dart';
import 'package:votingapp/screens/dashboard.dart';
import 'package:votingapp/screens/home_screen.dart';
import 'package:votingapp/screens/launch_screen.dart';
import 'package:votingapp/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/screens/signin.dart';
import 'package:votingapp/screens/succesfull.dart';
import 'package:votingapp/state/vote.dart';
import 'package:votingapp/state/authentication.dart';
import 'package:votingapp/utilities.dart';


void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // providers: <SingleChildCloneableWidget>[],
      providers: [
        ChangeNotifierProvider(
          builder:(_)=> VoteState(),
        ),
        ChangeNotifierProvider(
          builder:(_)=> AuthenticationState(),
        ),
      ],
          child: MaterialApp(
        initialRoute: "/", 
        routes: {
          "/": (context)=>Scaffold(
            body: LaunchScreen(),
          ),
          '/home':(context)=>Scaffold(
            appBar: AppBar(
              title: Text(kAppName),
              actions: <Widget>[
                getActions(context)
              ],
            ),
            body: DashBoard(),
          ),
          '/vote':(context)=>Scaffold(
            appBar: AppBar(
              title: Text('Vote'),
              leading: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/home');
                  // print('result Screen');
                },
              ),
              actions: <Widget>[
                getActions(context)
              ],
            ),
            body: HomeScreen(),
          ),
          '/result':(context)=>Scaffold(
            appBar: AppBar(
              title: Text('Result'),
              leading: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/home');
                  // print('result Screen');
                },
              ),
              actions: <Widget>[
                getActions(context)
              ],
            ),
            body: ResultScreen(),
          ),
          '/signin':(context)=>Scaffold(
            appBar: AppBar(
              title: Text('Signin'),
              leading: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/home');
                  // print('result Screen');
                },
              ),
              actions: <Widget>[
                getActions(context)
              ],
            ),
            body: LoginScreen(),
          ),
          '/sucess':(context)=>Scaffold(
            appBar: AppBar(
              title: Text('sucess'),
              leading: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/home');
                  // print('result Screen');
                },
              ),
              actions: <Widget>[
                getActions(context)
              ],
            ),
            body: SuccesfullyScreen(),
          ),
          
        },
      ), 
    );
  }

  PopupMenuButton getActions(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          Provider.of<AuthenticationState>(context, listen: false).logout();
          gotoLoginScreen(context);
        }
      },
    );
  }


}
