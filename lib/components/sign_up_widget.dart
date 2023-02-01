import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:medical_pdf/provider/google_sign_in.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/5),
                child: Center(
                  child: Image.asset(
                    'assets/splash.png',
                    fit: BoxFit.fill,
                    height: 100,
                  ),
                ),
              ),

              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 100.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: GestureDetector(
                        onTap: (){
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.facebook_login();
                        },
                        child: NeuomorphicContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Center(
                                    // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                    child: SvgPicture.asset(
                                      "assets/icons/facebook_icon.svg",
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 00, left: 30),
                                  child: Text(
                                    "Log In with Facebook",
                                    style: TextStyle(
                                        color: kTextColor, fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          color: kTextColorInverse,
                          style: NeuomorphicStyle.Concave,
                          intensity: 0.2,
                          offset: Offset(8, 8),
                          blur: 7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.google_login();
                        },
                        child: NeuomorphicContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Center(
                                    // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                    child: SvgPicture.asset(
                                      "assets/icons/google_icon.svg",
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 00, left: 30),
                                  child: Text(
                                    "Log In with Google",
                                    style: TextStyle(
                                        color: kTextColor, fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          color: kTextColorInverse,
                          style: NeuomorphicStyle.Concave,
                          intensity: 0.2,
                          offset: Offset(8, 8),
                          blur: 7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
