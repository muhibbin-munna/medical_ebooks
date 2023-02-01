import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();
  bool _isSigningIn , _isGoogleLogin , _isFacebookLogin;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;
  bool get isGoogleLogin => _isGoogleLogin;
  bool get isFacebookLogin => _isFacebookLogin;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }
  set isGoogleLogin(bool isGoogleLogin) {
    _isGoogleLogin = isGoogleLogin;
    notifyListeners();
  }
  set isFacebookLogin(bool isFacebookLogin) {
    _isFacebookLogin = isFacebookLogin;
    notifyListeners();
  }

  Future google_login() async {
    isSigningIn = true;
    isGoogleLogin = true;
    isFacebookLogin = false;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  Future facebook_login() async {
    print("Facebook log in called");
    isSigningIn = true;
    isFacebookLogin = false;
    isGoogleLogin = true;

    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        isSigningIn = false;
        print("cancelledByUser");
        return;
        break;
      case FacebookLoginStatus.error:
        print("error");
        isSigningIn = false;
        return;
        break;
      case FacebookLoginStatus.loggedIn:
        print("log In started");
        try {
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
          var a = await FirebaseAuth.instance.signInWithCredential(credential);
          print("email: ");
          print(a.user.email);
        } catch (e) {
          print("error: ");
          print(e);
        }
        isSigningIn = false;
        break;
    }



    // setState(() {
    //   isSignIn = true;
    //   _user = a.user;
    // });
  }

  void google_logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
  void facebook_logout() async {
    await facebookLogin.logOut();
    FirebaseAuth.instance.signOut();
  }
}
