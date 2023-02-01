import 'dart:io';
import 'package:medical_pdf/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:medical_pdf/models/book_model.dart';
import 'package:medical_pdf/screens/book_details.dart';
import 'package:medical_pdf/screens/download_book_details.dart';
import 'package:medical_pdf/utils/book_database_helper.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DownloadedBooks extends StatefulWidget {
  @override
  _DownloadedBooksState createState() => _DownloadedBooksState();
}

class _DownloadedBooksState extends State<DownloadedBooks> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Book> bookList;
  int count = 0;
  String dir;

  @override
  void initState() {
    super.initState();
    _getDir().then((value) {
      setState(() {
        dir = value + Platform.pathSeparator;
      });
    });
  }

  Future<String> _getDir() async {
    final internalDir = await getApplicationDocumentsDirectory();
    String dir = internalDir.path + Platform.pathSeparator + 'download';
    return dir;
  }

  @override
  Widget build(BuildContext context) {
    if (bookList == null) {
      bookList = List<Book>();
      updateListView();
    }
    if (bookList.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title:
              Text("Downloaded Books", style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: bookList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,),
            itemBuilder: (context,index){
            return Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DownloadBookDetails(bookList[index]),
                  ));
                },
                onLongPress: () {
                  // _delete(context, bookList[i]);
                  print("long press");
                  showAlertDialog(context , bookList[index]);
                },
                child:NeuomorphicContainer(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity,
                  height: 165,
                  child: Padding(
                    padding: const EdgeInsets.only(top:10.0, left: 5, right: 5 , bottom: 5),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Center(
                            // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                            child: FadeInImage(
                              fadeInDuration: Duration(milliseconds: 10),
                              fadeOutDuration: Duration(milliseconds: 10),
                              image: FileImage(
                                  File(dir + bookList[index].item_id + '.png')),
                              placeholder:
                              AssetImage('assets/cover.png'),
                              fit: BoxFit.fitWidth,

                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,

                          child:
                          Center(
                            child: Text(
                              bookList[index].name.toString(),
                              // overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: kTextColor, fontSize: 16.0),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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

                // NeuomorphicContainer(
                //   margin: EdgeInsets.only(left: 20, right: 20),
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: Row(
                //       children: <Widget>[
                //         Padding(
                //           padding: const EdgeInsets.only(left: 10.0),
                //           child: Center(
                //             child: FadeInImage(
                //               fadeInDuration: Duration(milliseconds: 10),
                //               fadeOutDuration: Duration(milliseconds: 10),
                //               image: FileImage(
                //                   File(dir + bookList[i].item_id + '.png')),
                //               placeholder: AssetImage('assets/book_icon.png'),
                //               fit: BoxFit.fitHeight,
                //               height: 50,
                //               width: 50,
                //             ),
                //             // Image.network(
                //             //   (snapshot.data.docs[i])["image"],
                //             //   fit: BoxFit.fill,
                //             //   height: 50,
                //             // ),
                //           ),
                //         ),
                //         Center(
                //           child: Container(
                //             margin: EdgeInsets.only(top: 00, left: 10),
                //             child: Flexible(
                //               child: FittedBox(
                //                 fit: BoxFit.fitWidth,
                //                 child: Text(
                //                   bookList[i].name.toString(),
                //                   style: TextStyle(
                //                       color: kTextColor, fontSize: 22.0),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                //   borderRadius: BorderRadius.circular(15.0),
                //   color: kTextColorInverse,
                //   style: NeuomorphicStyle.Concave,
                //   intensity: 0.2,
                //   offset: Offset(8, 8),
                //   blur: 7,
                // ),
              ),
            ]);
            }


          ,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title:
              Text("Downloaded Books", style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: Center(
          child: Text("No downloaded books"),
        ),
      );
    }
  }

  void _delete(BuildContext context, Book book) async {
    int result = await databaseHelper.deleteBook(book.id);
    if (result != 0) {
      _showSnackBar(context, 'Book Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    // Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAlertDialog(BuildContext context , Book book) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        _delete(context, book);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you want to delete this book from downloads?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database) {
      Future<List<Book>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((bookList) {
        setState(() {
          this.bookList = bookList;
          this.count = bookList.length;
        });
      });
    });
  }
}
