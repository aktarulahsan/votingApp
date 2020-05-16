import 'package:flutter/material.dart';
import 'package:votingapp/constants.dart';
import 'package:votingapp/widgets/shared_widgets.dart';
import 'package:votingapp/state/authentication.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/utilities.dart';


class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // gotoHomeScreen(context);

    return Consumer<AuthenticationState>(
      builder: (builder, authState, child) {
        return Container(
          width: 400,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Text(
                  kAppName,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                      ),
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              // if (authState.authStatus == kAuthLoading)
              //   Text(
              //     'loading..',
              //     style: TextStyle(fontSize: 12.0),
              //   ),
              // if (authState.authStatus == null ||
              //     authState.authStatus == kAuthError)
                Container(
                  child: Column(
                    children: <Widget>[
                      LoginButton(
                        label: 'Vote',
                        onPressed: () => votes(context, kAuthSignInGoogle),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      LoginButton(
                        label: 'Vote Result',
                        // Navigator.pushReplacementNamed(context, '/result')
                        onPressed: () =>results(context, kAuthSignInAnonymous),
                        // onPressed: () => signIn(context, kAuthSignInAnonymous),
                      ),
                    ],
                  ),
                ),
                // if(authState.authStatus == kAuthError)
                //   Text(
                //     'Error',
                //     style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                //   ),
            ],
          ),
        );
      },
    );
  }

  void signIn(BuildContext context, String service) {
    // Navigator.pushReplacementNamed(context, '/home');
    Provider.of<AuthenticationState>(context, listen: true)
        .login(serviceName: service);
  }
  void votes(BuildContext context, String service){
    Navigator.pushReplacementNamed(context, '/vote');
  }
   void results(BuildContext context, String service){
    Navigator.pushReplacementNamed(context, '/result');
    Navigator.pushReplacementNamed(context, '/result');
  }
}
