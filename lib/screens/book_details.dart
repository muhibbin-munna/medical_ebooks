import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_pdf/components/sign_up_widget.dart';
import 'package:medical_pdf/models/book_model.dart';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:medical_pdf/provider/google_sign_in.dart';
import 'package:medical_pdf/screens/broken_link.dart';
import 'package:medical_pdf/screens/open_book.dart';
import 'package:medical_pdf/screens/open_download_book.dart';
import 'package:medical_pdf/screens/profile.dart';
import 'package:medical_pdf/utils/book_database_helper.dart';
import 'package:medical_pdf/utils/last_read_database_helper.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

int ratingcount;

double avgrating, myrating;

class BookDetails extends StatefulWidget {
  var pageTextChanged;
  String genre;

  BookDetails(this.pageTextChanged, this.genre);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Book book = Book("", "", "", "", "", "", "");
  DatabaseHelper helper = DatabaseHelper();
  LastReadDatabaseHelper lastReadHelper = LastReadDatabaseHelper();
  List<Book> bookList = new List<Book>();
  LastRead last_read_page = LastRead("", 0);

  //Download using dio
  bool downloading = false;
  var progressString = "";
  var imageLink;

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      final internalDir = await getApplicationDocumentsDirectory();
      String dir = internalDir.path + Platform.pathSeparator + 'download';
      final downloadDir = Directory(dir);
      if (!await downloadDir.exists()) {
        downloadDir.create();
      }

      Future.wait([
        dio.download(
            'https://drive.google.com/uc?id=' +
                widget.pageTextChanged["link"] +
                '&export=download',
            dir + Platform.pathSeparator + widget.pageTextChanged.id + ".pdf",
            onReceiveProgress: (rec, total) {
          print("Rec: $rec , Total: $total");

          setState(() {
            downloading = true;
          });
        }),
        dio.download(widget.pageTextChanged["image"],
            dir + Platform.pathSeparator + widget.pageTextChanged.id + ".png")
      ]).whenComplete(() {
        setState(() {
          downloading = false;
          progressString = "Completed";
          _save();
        });
        Navigator.pop(context);
        print("Download completed");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {

    try {
      imageLink = NetworkImage(widget.pageTextChanged["image"]);
    } catch (e) {
      imageLink = AssetImage('assets/no_cover.png');
    }
    checklogin();
    List list = widget.pageTextChanged["ratings"].values.toList();
    print(list);
    double temp = 0;
    for (int i = 0; i < list.length; i++) {
      temp = temp + list[i];
    }
    if (list.isNotEmpty) {
      setState(() {
        print("Called");
        ratingcount = list.length;
        avgrating = temp / ratingcount;
      });
    } else {
      setState(() {
        print("not");
        ratingcount = 0;
        avgrating = 0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Future<Database> dbFuture = helper.initDB();
    dbFuture.then((database) {
      Future<List<Book>> bookListFuture =
          helper.findBook(widget.pageTextChanged.id);
      bookListFuture.then((bookList) {
        if (mounted) {
          setState(() {
            this.bookList = bookList;
          });
        }
      });
    });
    final Future<Database> dbllFuture = lastReadHelper.initDB();
    dbllFuture.then((database) {
      Future<List<LastRead>> lastReadFuture =
          lastReadHelper.findBook(widget.pageTextChanged.id);
      lastReadFuture.then((lastReadList) {
        if (mounted) {
          setState(() {
            if (lastReadList.isNotEmpty) {
              // this.bookList = bookList;
              last_read_page = lastReadList[0];
              print(lastReadList.length);
            } else {
              last_read_page = null;
            }
          });
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(widget.pageTextChanged["name"],
              style: TextStyle(color: kTextColor)),
        ),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child:  CachedNetworkImage(
                  imageUrl: widget.pageTextChanged["image"],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => FadeInImage(
                    fadeInDuration: Duration(milliseconds: 10),
                    fadeOutDuration: Duration(milliseconds: 10),
                    image: imageLink,
                    placeholder:
                    AssetImage('assets/cover.png'),
                    fit: BoxFit.fitWidth,

                  ),
                ),
              ),
              // Container(
              //   color: const Color(0xff882f94),
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(8.0),
              //   child: Center(
              //     child: SingleChildScrollView(
              //       child: Text(
              //         widget.pageTextChanged["intro"],
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: const Color(0xffffffff),
              //           letterSpacing: 0.00,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            Expanded(
                flex: 5,
                child: NeuomorphicContainer(
                  width: double.infinity,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xff3b3b3b),
                                letterSpacing: 0.54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Author: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.pageTextChanged["author"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color(0xff3b3b3b),
                                letterSpacing: 0.54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Edition: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.pageTextChanged["edition"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color(0xff3b3b3b),
                                letterSpacing: 0.54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'File Size: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.pageTextChanged["size"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color(0xff3b3b3b),
                                letterSpacing: 0.54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Ratings: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: avgrating.toStringAsFixed(1) +
                                      " (" +
                                      ratingcount.toString() +
                                      " ratings)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xff3b3b3b),
                                    letterSpacing: 0.54,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Your Rating: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // TextSpan(
                                    //   text: widget.pageTextChanged["rating"],
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.center,
                              ),
                              SmoothStarRating(
                                  onRated: (v) {
                                    if (checklogin()) {
                                      print(v);
                                      print(FirebaseAuth
                                          .instance.currentUser.uid);
                                      FirebaseFirestore.instance
                                          .collection(widget.genre)
                                          .doc(widget.pageTextChanged.id)
                                          .set({
                                        'ratings': {
                                          FirebaseAuth.instance.currentUser.uid:
                                              v,
                                        }
                                      }, SetOptions(merge: true));
                                    } else {
                                      Navigator.of(context)
                                          .push(new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Profile(),
                                      ));
                                    }
                                  },
                                  starCount: 5,
                                  rating: myrating,
                                  color: Colors.green,
                                  borderColor: Colors.green,
                                  spacing: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0XFFFFFFFF),
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                )),
            bookList.isEmpty
                ? Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      showLoaderDialog(context);
                                      downloadFile();
                                    },
                                    child: NeuomorphicContainer(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 6.0),
                                      height: double.infinity,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 8.0),
                                            child: Image.asset(
                                              'assets/download.png',
                                              fit: BoxFit.fill,
                                              height: 25,
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Download book',
                                                style:
                                                    TextStyle(fontSize: 22.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: kTextColorInverse,
                                      style: NeuomorphicStyle.Concave,
                                      intensity: 0.2,
                                      offset: Offset(5, 5),
                                      blur: 7,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            OpenBook(widget.pageTextChanged, 1,
                                                last_read_page),
                                      ));
                                    },
                                    child: NeuomorphicContainer(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      margin: EdgeInsets.only(
                                          left: 6.0, right: 10.0),
                                      height: double.infinity,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 8.0),
                                            child: Image.asset(
                                              'assets/read_book.png',
                                              fit: BoxFit.fill,
                                              height: 25,
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Read online',
                                                style:
                                                    TextStyle(fontSize: 22.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: kTextColorInverse,
                                      style: NeuomorphicStyle.Concave,
                                      intensity: 0.2,
                                      offset: Offset(5, 5),
                                      blur: 7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BrokenLink(widget.pageTextChanged),
                                  ));
                                },
                                child: Center(
                                  child: Text(
                                    "Having Trouble with Downloading?",
                                    style: TextStyle(
                                      color: Color(0XFF0000EE),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OpenDownloadedBook(widget.pageTextChanged,
                                        0, last_read_page),
                              ));
                            },
                            child: NeuomorphicContainer(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Center(
                                        // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                        child: Image.asset(
                                          'assets/read_book.png',
                                          fit: BoxFit.fill,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 00, left: 30),
                                        child: Text(
                                          'Read the book',
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
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void _save() async {
    book.item_id = widget.pageTextChanged.id;
    book.name = widget.pageTextChanged["name"];
    // book.intro = widget.pageTextChanged["intro"];
    book.author = widget.pageTextChanged["author"];
    book.edition = widget.pageTextChanged["edition"];
    book.size = widget.pageTextChanged["size"];
    book.rating = avgrating.toStringAsFixed(1);
    // book.image = widget.pageTextChanged["image"];
    int result;
    if (book.id != null) {
      // Case 1: Update operation
      result = await helper.updateBook(book);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertBook(book);
    }

    if (result != 0) {
      // Success
      // _showAlertDialog('Status', 'Book downloaded Successfully');
      Fluttertoast.showToast(
          msg: "Book downloaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      // Failure
      // _showAlertDialog('Status', 'Problem saving book');
      Fluttertoast.showToast(
          msg: "Error saving book",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Flexible(
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(" Downloading... Please wait"))
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          child: alert,
          onWillPop: () async {
            return false;
          },
        );
      },
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  bool checklogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      myrating = (widget
          .pageTextChanged["ratings"])[FirebaseAuth.instance.currentUser.uid];
      if (myrating == null) {
        myrating = 0;
      }
      print(myrating);
      return true;
    } else {
      myrating = 0;
      print(myrating);
      return false;
    }
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
