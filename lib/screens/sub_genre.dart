import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_pdf/screens/booklist.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:medical_pdf/colors_constant.dart';

class SubGenre extends StatefulWidget {
  List<dynamic> sub_genre;

  SubGenre(this.sub_genre);

  @override
  _SubGenreState createState() => _SubGenreState();
}

class _SubGenreState extends State<SubGenre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text("Sub Genre",
              style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: ListView(
          children: [
            for (int i = 0; i < widget.sub_genre.length; i++)
              Column(children: [
                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Booklist(widget.sub_genre[i]),
                    ));
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
                            widget.sub_genre[i],
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
        )
    );
  }
}
