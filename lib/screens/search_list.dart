import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_pdf/models/book_model.dart';
import 'package:medical_pdf/screens/book_details.dart';
import 'package:medical_pdf/screens/download_book_details.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:medical_pdf/colors_constant.dart';

// List<Book> booksList = new List<Book>();
List<QueryDocumentSnapshot> querySnapshots = new List<QueryDocumentSnapshot>();

class SearchList extends StatefulWidget {
  String search;
  List<String> genre_list;

  SearchList(String search, List<String> genre_list) {
    this.search = search;
    this.genre_list = genre_list;
  }

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  void initState() {
    super.initState();
   fetch_data();
  }

  void fetch_data(){
    querySnapshots.clear();
    for (int i = 0; i < widget.genre_list.length; i++) {
      FirebaseFirestore.instance
          .collection(widget.genre_list[i])
          .orderBy('name', descending: false)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          setState(() {
            String temp = doc["name"];
            if (temp.toLowerCase().contains(widget.search.toLowerCase())) {
              querySnapshots.add(doc);
            }
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.search + " search result",
              style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: querySnapshots.isNotEmpty
            ? ListView(
                children: [
                  for (int i = 0; i < querySnapshots.length; i++)
                    Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(querySnapshots[i]);
                          print(querySnapshots[i].reference.parent.id);
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BookDetails(querySnapshots[i] , querySnapshots[i].reference.parent.id) ,
                          )).then((value) => fetch_data());
                        },
                        child: NeuomorphicContainer(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Center(
                                    // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                    child: FadeInImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 10),
                                      fadeOutDuration:
                                          Duration(milliseconds: 10),
                                      image: NetworkImage((querySnapshots[i])["image"]),
                                      placeholder:
                                          AssetImage('assets/book_icon.png'),
                                      fit: BoxFit.fitHeight,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 00, left: 30),
                                    child: Text(
                                      (querySnapshots[i])["name"],
                                      style: TextStyle(
                                          color: kTextColor, fontSize: 22.0),
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
                    ]),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            : Center(
                child: Text("No book available"),
              ));
  }
}
