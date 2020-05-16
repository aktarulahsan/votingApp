import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:votingapp/state/authentication.dart";

void gotoHomeScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        kAuthSuccess) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  });
}

void gotoLoginScreen(BuildContext context) {
  Future.microtask(() {
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
        null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}
