import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medical_pdf/models/book_model.dart';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:medical_pdf/screens/download_open_book.dart';
import 'package:medical_pdf/utils/last_read_database_helper.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medical_pdf/colors_constant.dart';

class DownloadBookDetails extends StatefulWidget {
  Book _book;

  DownloadBookDetails(this._book);

  @override
  _DownloadBookDetailsState createState() => _DownloadBookDetailsState();
}

class _DownloadBookDetailsState extends State<DownloadBookDetails> {

  LastReadDatabaseHelper lastReadHelper = LastReadDatabaseHelper();
  LastRead last_read_page = LastRead("", 0);

  @override
  Widget build(BuildContext context) {
    final Future<Database> dbllFuture = lastReadHelper.initDB();
    dbllFuture.then((database) {
      Future<List<LastRead>> lastReadFuture =
      lastReadHelper.findBook(widget._book.item_id);
      lastReadFuture.then((lastReadList) {
        if (mounted) {
          setState(() {
            if(lastReadList.isNotEmpty) {
              // this.bookList = bookList;
              last_read_page = lastReadList[0];
              print(lastReadList.length);
            }
            else{
              last_read_page = null;
            }
          });
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._book.name, style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: const Color(0xff882f94),
                width: double.infinity,
                child: Center(
                  child: Text(
                    widget._book.intro,
                    style: TextStyle(
                      fontSize: 25,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.7000000000000001,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: NeuomorphicContainer(
                  width: double.infinity,
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
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
                                  text: widget._book.author,
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
                                  text: widget._book.edition,
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
                                  text: widget._book.size,
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
                                  text: widget._book.rating,
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
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0XFFFFFFFF),
                  style: NeuomorphicStyle.Concave,
                  intensity: 0.2,
                  offset: Offset(8, 8),
                  blur: 7,
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DownloadOpenBook(widget._book, last_read_page),
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
                                padding: const EdgeInsets.only(left: 30.0),
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
                                  margin: EdgeInsets.only(top: 00, left: 30),
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
}
