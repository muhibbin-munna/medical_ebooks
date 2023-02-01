import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_pdf/components/logged_in_widget.dart';
import 'package:medical_pdf/components/sign_up_widget.dart';
import 'package:medical_pdf/provider/google_sign_in.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:provider/provider.dart';
import 'package:medical_pdf/colors_constant.dart';



class Profile extends StatelessWidget {
  bool checklogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      User _user = FirebaseAuth.instance.currentUser ;
      print("logged in");
      print(_user.uid);
      return true;
    } else {
      print("logged out");
      return false;
    }

  }
  @override
  Widget build(BuildContext context) {
    checklogin();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body:ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child:
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              // return LoggedInWidget();
              return LoggedInWidget();
            } else {
              return SignUpWidget();
            }
          },
        ),
      ),

    );
  }
  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      Center(child: CircularProgressIndicator()),
    ],
  );
}

