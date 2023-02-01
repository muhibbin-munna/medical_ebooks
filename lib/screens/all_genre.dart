import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:medical_pdf/screens/booklist.dart';
import 'package:medical_pdf/screens/sub_genre.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';

class AllGenre extends StatefulWidget {
  var genre_name;
  AllGenre(this.genre_name);
  @override
  _AllGenreState createState() => _AllGenreState();
}

class _AllGenreState extends State<AllGenre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre_name.toString().replaceAll("Genre", ""),
            style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.genre_name)
            .orderBy('name', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text("No genre found"),
              );
            } else {
              return ListView(
                children: [
                  for (int i = 0; i < snapshot.data.docs.length; i++)
                    Column(children: [
                      SizedBox(
                        height: 10,
                      ),

                      GestureDetector(
                        onTap: (){
                          List<dynamic> sub_genre = snapshot.data.docs[i]["sub"];
                          if(sub_genre.isNotEmpty){
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => SubGenre(sub_genre),
                            ));
                          }
                          else{
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => Booklist(snapshot.data.docs[i]["name"]),
                            ));
                          }

                        },
                        child: NeuomorphicContainer(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Center(
                                  // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                  child: Image.asset(
                                    'assets/book_icon.png',
                                    fit: BoxFit.fill,
                                    height: 80,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data.docs[i]["name"],
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: kTextColor, fontSize: 22.0),

                                ),
                              )
                            ],
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
              );
            }
          }
        },
      ),
    );;

  }
}
