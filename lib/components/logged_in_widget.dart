import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:medical_pdf/provider/google_sign_in.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print(user.providerData[0].providerId);
    return Container(
      alignment: Alignment.center,
      color: Color(0XFFFEFEFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text(
            'Welcome',
            style: TextStyle(color: kTextColor ,fontSize: 24.0),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 50,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + user.displayName,
            style: TextStyle(color: kTextColor , fontSize: 18.0),
          ),
          SizedBox(height: 8),
          user.email != null ?
          Text(
            'Email: ' + user.email,
            style: TextStyle(color: kTextColor, fontSize: 18.0),
          ):SizedBox(height: 0),
          SizedBox(height: 50),
          GestureDetector(
            onTap: (){
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              if(user.providerData[0].providerId == 'google.com' ){
                provider.google_logout();
              }
              else if(user.providerData[0].providerId == 'facebook.com'){
                provider.facebook_logout();
              }
            },
            child: NeuomorphicContainer(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: kTextColor, fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              style: NeuomorphicStyle.Concave,
              intensity: 0.2,
              offset: Offset(8, 8),
              blur: 7,
            ),
          ),
        ],
      ),
    );
  }
}
