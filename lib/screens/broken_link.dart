import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:path/path.dart';
import 'package:medical_pdf/colors_constant.dart';
final _formKey = GlobalKey<FormState>();

class BrokenLink extends StatefulWidget {
  var pageTextChanged;

  BrokenLink(this.pageTextChanged);

  @override
  _BrokenLinkState createState() => _BrokenLinkState();
}

class _BrokenLinkState extends State<BrokenLink> {
  CollectionReference req =
  FirebaseFirestore.instance.collection('Broken Links');

  File _image;
  final picker = ImagePicker();
  String fileName;

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    setState(() {
      if(result != null) {
        _image = File(result.files.single.path);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  String name = '';
  String email = '';
  String problem = '';
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future<void> SendReport() async {
      showLoaderDialog(context);
      // Call the user's CollectionReference to add a new user
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child(
          "screenshots/" + DateTime.now().millisecondsSinceEpoch.toString());
      UploadTask uploadTask = reference.putFile(_image);

      // Waits till the file is uploaded then stores the download url
      String url = await (await uploadTask).ref.getDownloadURL();
      req.add({
        'name': name,
        'email': email,
        'problem': problem,
        'book_id': widget.pageTextChanged.id,
        'ss': url,
        'status': "0"
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Report send successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        _controller1.clear();
        _controller2.clear();
        _controller3.clear();

        Navigator.pop(context);
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Failed to send report: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(

        title: Text("Report problem or link broken",
            style: TextStyle(color: kTextColorInverse)),
        backgroundColor: Color(0xFF6200EE),
        iconTheme: IconThemeData(color: kTextColorInverse),
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
                      color: Colors.black,
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
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 20,
                controller: _controller3,
                onChanged: (value) {
                  problem = value;
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    hintText:
                        "Explain the problem you facing while downloading",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            borderRadius: BorderRadius.circular(15.0),
            color: kMainColor,
            style: NeuomorphicStyle.Concave,
            intensity: 0.2,
            offset: Offset(8, 8),
            blur: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                getImage();

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
                          child: Icon(Icons.add_a_photo),
                          // Image.asset(
                          //   'assets/send_icon.png',
                          //   fit: BoxFit.fill,
                          //   height: 20,
                          // ),
                        ),
                      ),
                      Expanded(
                        // margin: EdgeInsets.only(top: 00, left: 30),
                        child: fileName==null ? Text(
                          'Attach screenshot',
                          style: TextStyle(fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ):Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            fileName,
                            style: TextStyle(fontSize: 22.0),
                            overflow: TextOverflow.ellipsis,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                if(_controller1.text.isNotEmpty && _controller2.text.isNotEmpty && _controller3.text.isNotEmpty ){
                  SendReport();
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
                          margin: EdgeInsets.only(top: 00, left: 30),
                          child: Text(
                            'Send Report',
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
              margin: EdgeInsets.only(left: 7),
              child: Text(" Sending Report...")),
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
