import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:medical_pdf/screens/all_genre.dart';
import 'package:medical_pdf/screens/discalimer_page.dart';
import 'package:medical_pdf/screens/dmca_policy.dart';
import 'package:medical_pdf/screens/downloaded_books.dart';
import 'package:medical_pdf/screens/ecg_page.dart';
import 'package:medical_pdf/screens/open_slide.dart';
import 'package:medical_pdf/screens/profile.dart';
import 'package:medical_pdf/screens/request_book.dart';
import 'package:medical_pdf/screens/search_list.dart';
import 'package:medical_pdf/screens/slide_page.dart';
import 'package:medical_pdf/screens/terms_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import './otherpage.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'booklist.dart';

List<String> genre_list = new List<String>();
String search = "";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool checklogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {

      return false;
    }

  }
  String mainProfilePic =
      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  String otherProfilePic =
      "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/368-mj-2516-02.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=9f3d0ad657bbca1c0f2db36ad7deb323";

  //.. Switching Profile using multiple Accounts

  /*void switchUser(){
    String backupString = mainProfilePic;
    this.setState(() {
      mainProfilePic = otherProfilePic;
      otherProfilePic = backupString;
    });
  }*/
  bool _switchValue = true;
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/slide1.png',
    'assets/slide2.png',
    'assets/slide3.png',
    'assets/slide4.png',
    'assets/slide5.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  // Future<dynamic> getData() async {
  //   FirebaseFirestore.instance
  //       .collection('All Genre')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {});
  //   });
  // }

  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // genre_list.clear();
    //
    //   FirebaseFirestore.instance
    //       .collection('All Genre')
    //       .get()
    //       .then((QuerySnapshot querySnapshot) {
    //     querySnapshot.docs.forEach((doc) {
    //       setState(() {
    //         genre_list.add(doc["name"]);
    //       });
    //     });
    //   });


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      screenWidth = MediaQuery.of(context).size.height;
      screenHeight = MediaQuery.of(context).size.width;
    }
    bool folded = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeuomorphicContainer(
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
        ),
        iconTheme: IconThemeData(color: kTextColor),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: NeuomorphicContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                focusNode: searchFocusNode,
                onChanged: (value) {
                  search = value;
                  print(value);
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: hintColor)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
        ),
        backgroundColor: kMainColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NeuomorphicContainer(
              child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (search.trim().isNotEmpty) {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchList(search, genre_list),
                      ));
                    }
                  }),
              borderRadius: BorderRadius.circular(10.0),
              color: kMainColor,
              style: NeuomorphicStyle.Concave,
              intensity: 0.2,
              offset: Offset(8, 8),
              blur: 7,
            ),
          )
        ],
      ),
      drawer: SafeArea(
        child: new Drawer(
            child: Container(
          color: drawerColor,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "  Personalization",
                style: TextStyle(color: kTextColor, fontSize: 14),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(15.0, 6.0, 15.0, 6.0),
              //   child: Container(
              //     child: ListTile(
              //         title: Text("Login"),
              //         onTap: () {
              //           FocusScope.of(context).requestFocus(new FocusNode());
              //           Navigator.of(context).pop();
              //           Navigator.of(context).push(new MaterialPageRoute(
              //             builder: (BuildContext context) => Profile(),
              //           ));
              //         }),
              //     decoration: BoxDecoration(
              //         color: Color(0XFFf5f5ff),
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.grey[500],
              //               offset: Offset(3.0, 4.0),
              //               blurRadius: 8.0,
              //               spreadRadius: 1.0),
              //           BoxShadow(
              //               color: kTextColorInverse,
              //               offset: Offset(-5.0, -5.0),
              //               blurRadius: 8.0,
              //               spreadRadius: 1.0),
              //         ]),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: Stack(
                    children: [
                      ListTile(
                          leading:SvgPicture.asset(
                            'assets/icons/night_mood.svg',
                            height: 25.0,
                            width: 25.0,
                            allowDrawingOutsideViewBox: true,
                          ),
                          title: Text("Night Mood"),
                          onTap: () {
                          }),
                      Positioned(
                        right: 5,
                        top: 0,
                        bottom: 0,
                        child: CupertinoSwitch(
                          activeColor: Color(0xff221931),
                          value: _switchValue,
                          onChanged: (value) {
                            setState(() {
                              _switchValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/downloads.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("My Downloads"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => DownloadedBooks(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/reminder.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Reminder"),
                      onTap: () {

                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),

              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "  Support",
                style: TextStyle(color: kTextColor, fontSize: 14),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/request.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Request for book"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => RequestBook(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/contact.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Contact"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => RequestBook(),
                        // ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/dmca.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("DMCA Policy"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => DMCAPolicy(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/terms.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Terms and regulation"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => TermsPage(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/disclaimer.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Disclaimer"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Disclaimer(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/other.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Other"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => RequestBook(),
                        // ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/rate.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Rate this app"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        _launchSocial('https://play.google.com/store/apps/details?id=com.muhibbin.memes', '');
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => RequestBook(),
                        // ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/blog.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Read our blog"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => RequestBook(),
                        // ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(
                      leading:SvgPicture.asset(
                        'assets/icons/share.svg',
                        height: 25.0,
                        width: 25.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      title: Text("Share app"),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Share.share('Download and install the Emergency app from playstore: link here, appstore: link here');
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => RequestBook(),
                        // ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: drawerColor,
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 6.0, 30.0, 6.0),
                child: NeuomorphicContainer(
                  child: ListTile(

                      title: Center(child: checklogin() ? Text("Logout", style: TextStyle(color: Colors.white)) : Text("Login", style: TextStyle(color: Colors.white))),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Profile(),
                        ));
                      }),
                  borderRadius: BorderRadius.circular(15.0),
                  color: drawerColor,
                  bgColor: Color(0xFF100426),
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Text(
                "  Follow us",
                style: TextStyle(color: kTextColor, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        _launchSocial('fb://profile/2335534916564184', 'https://www.facebook.com/WOMSofficial/');
                      },
                      elevation: 5.0,
                      fillColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/facebook.svg',
                        height: 20.0,
                        width: 20.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        _launchSocial('https://instagram.com/woms_official?igshid=5gt7a2ddhtvc', '');
                      },
                      elevation: 5.0,
                      fillColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/instagram.svg',
                        height: 20.0,
                        width: 20.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        _launchSocial('https://youtube.com/channel/UCjb-amyNp-lzokdiCR6ZkKw', '');
                      },
                      elevation: 5.0,
                      fillColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/youtube.svg',
                        height: 20.0,
                        width: 20.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              )

            ],
          ),
        )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          print(MediaQuery.of(context).size.height);
          print(MediaQuery.of(context).size.width);
        },
        child: Container(
          height: screenHeight,
          child: ListView(
            children: [
              Padding(
          padding: EdgeInsets.only(top: 10),
          child: carouselSlider = CarouselSlider(
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.green,
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          imgUrl,
                          fit: BoxFit.fill,

                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                  height: 140,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration:
                  Duration(milliseconds: 2000),
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  })),
          ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: map<Widget> (
                  imgList, (index,url){
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(shape: BoxShape.circle,
                      color: _current == index ? Color(0xFF970000): Colors.green),
                    );
                }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                child: Text(
                  'Books',
                  style: TextStyle(
                      color: kTextColor,
                      fontFamily: 'Segoe UI',
                      fontSize: 20,
                    fontWeight: FontWeight.w600,),

                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AllGenre("MBBS Genre"),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/mbbs_bg.png', fit: BoxFit.fill),
                            // Stack(
                            //   children: <Widget>[
                            //     Positioned(
                            //       top: 10,
                            //       right: 5,
                            //       child: Image.asset(
                            //         'assets/mbbs_book.png',
                            //         fit: BoxFit.fill,
                            //         height: 30,
                            //       ),
                            //     ),
                            //     Positioned(
                            //       top: 15,
                            //       left: 20,
                            //       width: 50,
                            //       child: FittedBox(
                            //
                            //         fit: BoxFit.scaleDown,
                            //         child: Text(
                            //           'MBBS',
                            //           style: TextStyle(
                            //               color: kTextColor,
                            //               fontSize: 22.0),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       bottom: 10,
                            //       left: 12,
                            //       right: 12,
                            //
                            //       child: FittedBox(
                            //         fit: BoxFit.scaleDown,
                            //         child: Text(
                            //           'All the books for your\nsuccess at one place',
                            //           style: TextStyle(
                            //               color: kTextColor,
                            //               fontSize: 22.0),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AllGenre("Nursing Genre"),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/nursing_bg.png', fit: BoxFit.fill),
                            // Stack(
                            //   children: <Widget>[
                            //     Positioned(
                            //       top: 10,
                            //       right: 5,
                            //       child: Image.asset(
                            //         'assets/mbbs_book.png',
                            //         fit: BoxFit.fill,
                            //         height: 30,
                            //       ),
                            //     ),
                            //     Positioned(
                            //       top: 15,
                            //       left: 20,
                            //       width: 50,
                            //       child: FittedBox(
                            //
                            //         fit: BoxFit.scaleDown,
                            //         child: Text(
                            //           'MBBS',
                            //           style: TextStyle(
                            //               color: kTextColor,
                            //               fontSize: 22.0),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ),
                            //     Positioned(
                            //       bottom: 10,
                            //       left: 12,
                            //       right: 12,
                            //
                            //       child: FittedBox(
                            //         fit: BoxFit.scaleDown,
                            //         child: Text(
                            //           'All the books for your\nsuccess at one place',
                            //           style: TextStyle(
                            //               color: kTextColor,
                            //               fontSize: 22.0),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),


                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context)
                        //         .requestFocus(new FocusNode());
                        //     Navigator.of(context)
                        //         .push(new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           Booklist('Nursing books'),
                        //     ));
                        //   },
                        //   child: NeuomorphicContainer(
                        //     margin: EdgeInsets.only(
                        //         top: 8, left: 20, right: 10, bottom: 8),
                        //     height: 100,
                        //     width: double.infinity,
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Positioned(
                        //           bottom: -20,
                        //           right: -20,
                        //           child: Image.asset(
                        //             'assets/books_b.png',
                        //             fit: BoxFit.fill,
                        //             height: 60,
                        //           ),
                        //         ),
                        //         Positioned(
                        //           top: 10,
                        //           left: 0,
                        //           right: 0,
                        //           child: FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child:
                        //             Text(
                        //               'Nursing Books',
                        //               style: TextStyle(
                        //                   color: kTextColorInverse,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: widgetColor,
                        //     bgColor: Color(0xfff99a24),
                        //     style: NeuomorphicStyle.Concave,
                        //     intensity: 0.2,
                        //     offset: Offset(10, 5),
                        //     blur: 7,
                        //   ),
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('MBBS books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'MBBS books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('USMLE books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'USMLE books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('Nursing books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Nursing books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Nursing books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/dictionary.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dictionary',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AllGenre("Dental Genre"),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 5, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/dental_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context)
                        //         .requestFocus(new FocusNode());
                        //     Navigator.of(context)
                        //         .push(new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           Booklist('Dental books'),
                        //     ));
                        //   },
                        //   child: NeuomorphicContainer(
                        //     margin: EdgeInsets.only(
                        //         left: 10, right: 20, bottom: 8),
                        //     height: 216,
                        //     width: double.infinity,
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Positioned(
                        //           bottom: -20,
                        //           right: -20,
                        //           child: Image.asset(
                        //             'assets/books_b.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //         ),
                        //         Positioned(
                        //           top: 20,
                        //           left: 0,
                        //           right: 0,
                        //           child: FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental\nBooks',
                        //               style: TextStyle(
                        //                   color: kTextColorInverse,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: widgetColor,
                        //     bgColor: Color(0xffff4639),
                        //     style: NeuomorphicStyle.Concave,
                        //     intensity: 0.2,
                        //     offset: Offset(8, 8),
                        //     blur: 7,
                        //   ),
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('Dental books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Notes',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Quiz',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/slide.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Slides',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                        Navigator.of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AllGenre('USMLE Genre'),
                        ));
                      },
                      child: NeuomorphicContainer(
                        margin: EdgeInsets.only(
                            top:10, left: 20, right: 20, bottom: 10),
                        child:
                        Image.asset('assets/usmle_bg.png', fit: BoxFit.fill),

                        borderRadius: BorderRadius.circular(200.0),
                        color: Color(0xFFD5D3D3),
                        bgColor: Color(0xffffff),
                        style: NeuomorphicStyle.HomeWidget,
                        intensity: 0.2,
                        offset: Offset(8, 8),
                        blur: 7,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                        Navigator.of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AllGenre('MRCP Genre'),
                        ));
                      },
                      child: NeuomorphicContainer(
                        margin: EdgeInsets.only(
                            top:10, left: 20, right: 20, bottom: 10),
                        child:
                        Image.asset('assets/mrcp_bg.png', fit: BoxFit.fill),

                        borderRadius: BorderRadius.circular(200.0),
                        color: Color(0xFFD5D3D3),
                        bgColor: Color(0xffffff),
                        style: NeuomorphicStyle.HomeWidget,
                        intensity: 0.2,
                        offset: Offset(8, 8),
                        blur: 7,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                        Navigator.of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AllGenre('PLAB Genre'),
                        ));
                      },
                      child: NeuomorphicContainer(
                        margin: EdgeInsets.only(
                           top:10, left: 20, right: 20, bottom: 10),
                        child:
                        Image.asset('assets/plab_bg.png', fit: BoxFit.fill),

                        borderRadius: BorderRadius.circular(200.0),
                        color: Color(0xFFD5D3D3),
                        bgColor: Color(0xffffff),
                        style: NeuomorphicStyle.HomeWidget,
                        intensity: 0.2,
                        offset: Offset(8, 8),
                        blur: 7,
                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                child: Text(
                  'Others',
                  style: TextStyle(
                      color: kTextColor,
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,),

                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // Navigator.of(context)
                            //     .push(new MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //       Booklist('MBBS books'),
                            // ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/dictionary_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Booklist('Notes'),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/notes_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context)
                        //         .requestFocus(new FocusNode());
                        //     Navigator.of(context)
                        //         .push(new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           Booklist('Nursing books'),
                        //     ));
                        //   },
                        //   child: NeuomorphicContainer(
                        //     margin: EdgeInsets.only(
                        //         top: 8, left: 20, right: 10, bottom: 8),
                        //     height: 100,
                        //     width: double.infinity,
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Positioned(
                        //           bottom: -20,
                        //           right: -20,
                        //           child: Image.asset(
                        //             'assets/books_b.png',
                        //             fit: BoxFit.fill,
                        //             height: 60,
                        //           ),
                        //         ),
                        //         Positioned(
                        //           top: 10,
                        //           left: 0,
                        //           right: 0,
                        //           child: FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child:
                        //             Text(
                        //               'Nursing Books',
                        //               style: TextStyle(
                        //                   color: kTextColorInverse,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: widgetColor,
                        //     bgColor: Color(0xfff99a24),
                        //     style: NeuomorphicStyle.Concave,
                        //     intensity: 0.2,
                        //     offset: Offset(10, 5),
                        //     blur: 7,
                        //   ),
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('MBBS books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'MBBS books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('USMLE books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'USMLE books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('Nursing books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Nursing books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top: 8, left: 20, right: 10, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Nursing books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/dictionary.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dictionary',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // Navigator.of(context)
                            //     .push(new MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //       Booklist('Dental books'),
                            // ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 5, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/mcq_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  // OpenSlide(),
                              SlidePage(),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 5, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/slides_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Booklist('Entrance'),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 5, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/entrance_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context)
                        //         .requestFocus(new FocusNode());
                        //     Navigator.of(context)
                        //         .push(new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           Booklist('Dental books'),
                        //     ));
                        //   },
                        //   child: NeuomorphicContainer(
                        //     margin: EdgeInsets.only(
                        //         left: 10, right: 20, bottom: 8),
                        //     height: 216,
                        //     width: double.infinity,
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Positioned(
                        //           bottom: -20,
                        //           right: -20,
                        //           child: Image.asset(
                        //             'assets/books_b.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //         ),
                        //         Positioned(
                        //           top: 20,
                        //           left: 0,
                        //           right: 0,
                        //           child: FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental\nBooks',
                        //               style: TextStyle(
                        //                   color: kTextColorInverse,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: widgetColor,
                        //     bgColor: Color(0xffff4639),
                        //     style: NeuomorphicStyle.Concave,
                        //     intensity: 0.2,
                        //     offset: Offset(8, 8),
                        //     blur: 7,
                        //   ),
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('Dental books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Notes',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Quiz',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/slide.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Slides',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                child: Text(
                  'Sounds',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,),

                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context)
                      .requestFocus(new FocusNode());
                  Navigator.of(context)
                      .push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Booklist('MBBS books'),
                  ));
                },
                child: NeuomorphicContainer(
                  margin: EdgeInsets.only(
                      left: 20, right: 20, bottom: 10),

                  width: double.infinity,
                  child:
                  Image.asset('assets/auscultation_bg.png', fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFD5D3D3),
                  bgColor: Color(0xffffff),
                  style: NeuomorphicStyle.HomeWidget,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                child: Text(
                  'Radiology',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,),

                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Booklist('MBBS books'),
                            ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/xray_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // Navigator.of(context)
                            //     .push(new MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //       AllGenre("Dental Genre"),
                            // ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 10, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/ct_scan_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // Navigator.of(context)
                            //     .push(new MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //       AllGenre("Dental Genre"),
                            // ));
                          },
                          child: NeuomorphicContainer(
                            margin: EdgeInsets.only(
                                left: 10, right: 20, bottom: 8),

                            width: double.infinity,
                            child:
                            Image.asset('assets/usg_bg.png', fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFD5D3D3),
                            bgColor: Color(0xffffff),
                            style: NeuomorphicStyle.HomeWidget,
                            intensity: 0.2,
                            offset: Offset(8, 8),
                            blur: 7,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context)
                        //         .requestFocus(new FocusNode());
                        //     Navigator.of(context)
                        //         .push(new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           Booklist('Dental books'),
                        //     ));
                        //   },
                        //   child: NeuomorphicContainer(
                        //     margin: EdgeInsets.only(
                        //         left: 10, right: 20, bottom: 8),
                        //     height: 216,
                        //     width: double.infinity,
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Positioned(
                        //           bottom: -20,
                        //           right: -20,
                        //           child: Image.asset(
                        //             'assets/books_b.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //         ),
                        //         Positioned(
                        //           top: 20,
                        //           left: 0,
                        //           right: 0,
                        //           child: FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental\nBooks',
                        //               style: TextStyle(
                        //                   color: kTextColorInverse,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: widgetColor,
                        //     bgColor: Color(0xffff4639),
                        //     style: NeuomorphicStyle.Concave,
                        //     intensity: 0.2,
                        //     offset: Offset(8, 8),
                        //     blur: 7,
                        //   ),
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       Navigator.of(context)
                        //           .push(new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             Booklist('Dental books'),
                        //       ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Dental books',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Notes',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/books.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Quiz',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                        // NeuomorphicContainer(
                        //   margin: EdgeInsets.only(top:8, left: 10, right: 20, bottom: 8),
                        //   width: double.infinity,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       // Navigator.of(context)
                        //       //     .push(new MaterialPageRoute(
                        //       //   builder: (BuildContext context) =>
                        //       //       Booklist('Dental books'),
                        //       // ));
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Image.asset(
                        //             'assets/slide.png',
                        //             fit: BoxFit.fill,
                        //             height: 70,
                        //           ),
                        //           FittedBox(
                        //             fit: BoxFit.scaleDown,
                        //             child: Text(
                        //               'Slides',
                        //               style: TextStyle(
                        //                   color: kTextColor,
                        //                   fontSize: 22.0),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   borderRadius: BorderRadius.circular(15.0),
                        //   color: widgetColor,
                        //   style: NeuomorphicStyle.Concave,
                        //   intensity: 0.2,
                        //   offset: Offset(8, 8),
                        //   blur: 7,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context)
                      .requestFocus(new FocusNode());
                  // Navigator.of(context)
                  //     .push(new MaterialPageRoute(
                  //   builder: (BuildContext context) =>
                  //       Booklist('MBBS books'),
                  // ));
                },
                child: NeuomorphicContainer(
                  margin: EdgeInsets.only(
                      top: 10,left: 20, right: 20, bottom: 8),

                  width: double.infinity,
                  child:
                  Image.asset('assets/mri_bg.png', fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFD5D3D3),
                  bgColor: Color(0xffffff),
                  style: NeuomorphicStyle.HomeWidget,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context)
                      .requestFocus(new FocusNode());
                  Navigator.of(context)
                      .push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ECG(),
                  ));
                },
                child: NeuomorphicContainer(
                  margin: EdgeInsets.only(
                      top: 10,left: 20, right: 20, bottom: 20),

                  width: double.infinity,
                  child:
                  Image.asset('assets/ecg_bg.png', fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFD5D3D3),
                  bgColor: Color(0xffffff),
                  style: NeuomorphicStyle.HomeWidget,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     FocusScope.of(context).requestFocus(new FocusNode());
              //     Navigator.of(context).push(new MaterialPageRoute(
              //       builder: (BuildContext context) =>
              //           Booklist('Auscultation'),
              //     ));
              //   },
              //   child: NeuomorphicContainer(
              //     margin: EdgeInsets.only(
              //         top: 8, left: 20, right: 20, bottom: 10),
              //     width: double.infinity,
              //     child: Row(
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.only(
              //               top: 10, bottom: 10, left: 10.0),
              //           child: Center(
              //             // child: Icon(Icons.access_alarm,size: 50,color: Colors.white,),
              //             child: Image.asset(
              //               'assets/auscultation.png',
              //               fit: BoxFit.fill,
              //               height: 60,
              //             ),
              //           ),
              //         ),
              //         Center(
              //           child: Container(
              //             margin: EdgeInsets.only(top: 00, left: 30),
              //             child: Text(
              //               'Auscultation',
              //               style: TextStyle(
              //                   color: kTextColor, fontSize: 22.0),
              //               textAlign: TextAlign.center,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //     borderRadius: BorderRadius.circular(15.0),
              //     color: widgetColor,
              //     style: NeuomorphicStyle.Concave,
              //     intensity: 0.2,
              //     offset: Offset(8, 8),
              //     blur: 7,
              //   ),
              // ),
              // NeuomorphicContainer(
              //   margin: EdgeInsets.only(left: 20, right: 10, bottom: 8),
              //   width: double.infinity,
              //   child: GestureDetector(
              //     onTap: () {
              //       FocusScope.of(context)
              //           .requestFocus(new FocusNode());
              //       Navigator.of(context)
              //           .push(new MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             Booklist('Auscultation'),
              //       ));
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Column(
              //         children: <Widget>[
              //           Image.asset(
              //             'assets/books.png',
              //             fit: BoxFit.fill,
              //             height: 70,
              //           ),
              //           FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: Text(
              //               'MBBS books',
              //               style: TextStyle(
              //                   color: kTextColor,
              //                   fontSize: 22.0),
              //               textAlign: TextAlign.center,
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              //   borderRadius: BorderRadius.circular(15.0),
              //   color: widgetColor,
              //   style: NeuomorphicStyle.Concave,
              //   intensity: 0.2,
              //   offset: Offset(8, 8),
              //   blur: 7,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         GestureDetector(
              //           onTap: () {
              //             FocusScope.of(context)
              //                 .requestFocus(new FocusNode());
              //             Navigator.of(context)
              //                 .push(new MaterialPageRoute(
              //               builder: (BuildContext context) =>
              //                   Booklist('Biochemistry'),
              //             ));
              //           },
              //           child: NeuomorphicContainer(
              //             margin: EdgeInsets.only(left: 20, right: 20),
              //             width: double.infinity,
              //             child: Row(
              //               children: <Widget>[
              //                 Padding(
              //                   padding: const EdgeInsets.only(
              //                       left: 20.0, top: 10, bottom: 10),
              //                   child: Center(
              //                     // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
              //                     child: Stack(
              //                       children: [
              //                         Image.asset(
              //                           'assets/genre_image.png',
              //                           fit: BoxFit.fill,
              //                           height: 60,
              //                           width: 50,
              //                         ),
              //                         // Container(
              //                         //   height: 60,
              //                         //   width: 50,
              //                         //   padding: const EdgeInsets.only(
              //                         //    left: 10, right: 5),
              //                         //   child: FittedBox(
              //                         //     fit: BoxFit.fitWidth,
              //                         //     child: Text(
              //                         //   "Biochemistry",
              //                         //   style: TextStyle(
              //                         //       color: kTextColor),
              //                         // ),
              //                         //   ),
              //                         // ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Center(
              //                   child: Container(
              //                     margin: EdgeInsets.only(
              //                         top: 00, left: 30),
              //                     child: Text(
              //                       'Biochemistry',
              //                       style: TextStyle(color: kTextColor,fontSize: 22.0),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //             borderRadius: BorderRadius.circular(15.0),
              //             color: widgetColor,
              //             style: NeuomorphicStyle.Concave,
              //             intensity: 0.2,
              //             offset: Offset(8, 8),
              //             blur: 7,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             FocusScope.of(context)
              //                 .requestFocus(new FocusNode());
              //             Navigator.of(context)
              //                 .push(new MaterialPageRoute(
              //               builder: (BuildContext context) =>
              //                   Booklist('Forensic Medicine'),
              //             ));
              //           },
              //           child: NeuomorphicContainer(
              //             margin: EdgeInsets.only(left: 20, right: 20),
              //             width: double.infinity,
              //             child: Row(
              //               children: <Widget>[
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.only(left: 10.0),
              //                   child: Center(
              //                     // child: Icon(Icons.access_alarm,size: 50,color: Colors.white,),
              //                     child: Image.asset(
              //                       'assets/book_icon.png',
              //                       fit: BoxFit.fill,
              //                       height: 80,
              //                     ),
              //                   ),
              //                 ),
              //                 Center(
              //                   child: Container(
              //                     margin: EdgeInsets.only(
              //                         top: 00, left: 30),
              //                     child: Text(
              //                       'Forensic Medicine',
              //                       style: TextStyle(color: kTextColor,fontSize: 22.0),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //             borderRadius: BorderRadius.circular(15.0),
              //             color: widgetColor,
              //             style: NeuomorphicStyle.Concave,
              //             intensity: 0.2,
              //             offset: Offset(8, 8),
              //             blur: 7,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             FocusScope.of(context)
              //                 .requestFocus(new FocusNode());
              //             Navigator.of(context)
              //                 .push(new MaterialPageRoute(
              //               builder: (BuildContext context) =>
              //                   Booklist('Community Medicine'),
              //             ));
              //           },
              //           child: NeuomorphicContainer(
              //             margin: EdgeInsets.only(left: 20, right: 20),
              //             width: double.infinity,
              //             child: Row(
              //               children: <Widget>[
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.only(left: 10.0),
              //                   child: Center(
              //                     // child: Icon(Icons.access_alarm,size: 50,color: Colors.white,),
              //                     child: Image.asset(
              //                       'assets/book_icon.png',
              //                       fit: BoxFit.fill,
              //                       height: 80,
              //                     ),
              //                   ),
              //                 ),
              //                 Center(
              //                   child: Container(
              //                     margin: EdgeInsets.only(
              //                         top: 00, left: 30),
              //                     child: Text(
              //                       'Community Medicine',
              //                       style: TextStyle(color: kTextColor,fontSize: 22.0),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //             borderRadius: BorderRadius.circular(15.0),
              //             color: widgetColor,
              //             style: NeuomorphicStyle.Concave,
              //             intensity: 0.2,
              //             offset: Offset(8, 8),
              //             blur: 7,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             FocusScope.of(context)
              //                 .requestFocus(new FocusNode());
              //             Navigator.of(context)
              //                 .push(new MaterialPageRoute(
              //               builder: (BuildContext context) =>
              //                   AllGenre(),
              //             ));
              //           },
              //           child: NeuomorphicContainer(
              //             margin: EdgeInsets.only(left: 20, right: 20),
              //             width: double.infinity,
              //             child: Row(
              //               children: <Widget>[
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.only(left: 10.0),
              //                   child: Center(
              //                     // child: Icon(Icons.access_alarm,size: 50,color: Colors.white,),
              //                     child: Image.asset(
              //                       'assets/book_icon.png',
              //                       fit: BoxFit.fill,
              //                       height: 80,
              //                     ),
              //                   ),
              //                 ),
              //                 Center(
              //                   child: Container(
              //                     margin: EdgeInsets.only(
              //                         top: 00, left: 30),
              //                     child: Text(
              //                       'See More',
              //                       style: TextStyle(color: kTextColor,fontSize: 22.0),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //             borderRadius: BorderRadius.circular(15.0),
              //             color: seeMoreWidgetColor,
              //             style: NeuomorphicStyle.Concave,
              //             intensity: 0.2,
              //             offset: Offset(8, 8),
              //             blur: 7,
              //           ),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //       ]),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
void _launchSocial(String url, String fallbackUrl) async {
  // Don't use canLaunch because of fbProtocolUrl (fb://)
  try {
    bool launched =
    await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
