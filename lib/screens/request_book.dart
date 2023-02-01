import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:medical_pdf/colors_constant.dart';


class RequestBook extends StatefulWidget {
  @override
  _RequestBookState createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {
  CollectionReference req = FirebaseFirestore.instance.collection('Book Requests');
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();

  String name = '';
  String email = '';
  String book_name = '';
  String edition = '';
  String author = '';
  @override
  Widget build(BuildContext context) {

    Future<void> addReq() {
      showLoaderDialog(context);
      // Call the user's CollectionReference to add a new user
      return req
          .add({
        'name': name,
        'email': email,
        'book_name': book_name,
        'edition': edition,
        'author': author,
        'status': "0"
      })
          .then((value){
        Fluttertoast.showToast(
            msg: "Request send successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        _controller1.clear();
        _controller2.clear();
        _controller3.clear();
        _controller4.clear();
        _controller5.clear();
        Navigator.pop(context);
      })
          .catchError((error){
        Fluttertoast.showToast(
            msg: "Failed to send request: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pop(context);

      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Book",
            style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: ListView(
        children: [
          NeuomorphicContainer(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _controller1,
                onChanged: (value) {
                  name = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kTextColor,
                    ),
                    hintText: "Name",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          NeuomorphicContainer(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _controller2,
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: kTextColor,
                    ),
                    hintText: "Email",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          NeuomorphicContainer(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _controller3,
                onChanged: (value) {
                  book_name = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    icon: SvgPicture.asset("assets/icons/book_icon.svg"),
                    hintText: "Book Name",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          NeuomorphicContainer(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _controller4,
                onChanged: (value) {
                  edition = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.book,
                    //   color: kTextColor,
                    // ),
                  icon: SvgPicture.asset("assets/icons/edition_icon.svg"),
                    hintText: "Edition",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          NeuomorphicContainer(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20 , bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _controller5,
                onChanged: (value) {
                  author = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.book,
                    //   color: kTextColor,
                    // ),
                  icon: SvgPicture.asset("assets/icons/author_icon.svg"),
                    hintText: "Author",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(50.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());

                if(_controller1.text.isNotEmpty && _controller2.text.isNotEmpty && _controller3.text.isNotEmpty &&  _controller4.text.isNotEmpty && _controller5.text.isNotEmpty ){
                  addReq();
                }
                else{
                  Fluttertoast.showToast(
                      msg: "Submit all the fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                }
              },
              child: NeuomorphicContainer(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Center(
                          // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                          child: Image.asset(
                            'assets/send_icon.png',
                            fit: BoxFit.fill,
                            height: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin:
                          EdgeInsets.only(top: 00, left: 30),
                          child: Text(
                            'Send Request',
                            style: TextStyle(fontSize: 22.0),
                            textAlign: TextAlign.center,
                          ),
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
    );
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text(" Sending Request...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
