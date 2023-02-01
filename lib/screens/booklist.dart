import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:medical_pdf/screens/book_details.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:medical_pdf/colors_constant.dart';

class Booklist extends StatefulWidget {
  var pageTextChanged;

  Booklist(this.pageTextChanged);

  @override
  _BooklistState createState() => _BooklistState();
}

class _BooklistState extends State<Booklist> {

  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection(widget.pageTextChanged.toString()).get();
    return querySnapshot.docs;
  }

  Future sendData() async {
    Firebase.initializeApp().whenComplete(() => {
          FirebaseFirestore.instance
              .collection(widget.pageTextChanged.toString())
              .add({
            'name': "Book 1",
          })
        });
  }

  fetchData() async {
    return FirebaseFirestore.instance
        .collection(widget.pageTextChanged.toString())
        .orderBy('name', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.pageTextChanged, style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.pageTextChanged)
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
                child: Text("No books found"),
              );
            } else {
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,),
                  itemBuilder: (context,index){
                    DocumentSnapshot data = snapshot.data.docs[index];
                    var imageLink;
                    try{
                      imageLink = NetworkImage(data["image"]);
                    }
                    catch(e){
                      imageLink = AssetImage('assets/no_cover.png');
                    }
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BookDetails(data , widget.pageTextChanged),
                        ));
                      },
                      child: NeuomorphicContainer(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: double.infinity,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0, left: 5, right: 5 , bottom: 5),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Center(
                                  // child: Icon(Icons.access_alarm,size: 50,color: kTextColorInverse,),
                                  child: CachedNetworkImage(
                                    imageUrl: data["image"],
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

                                  // FadeInImage(
                                  //   fadeInDuration: Duration(milliseconds: 10),
                                  //   fadeOutDuration: Duration(milliseconds: 10),
                                  //   image: imageLink,
                                  //   placeholder:
                                  //   AssetImage('assets/cover.png'),
                                  //   fit: BoxFit.fitWidth,
                                  //
                                  // ),
                                ),
                              ),
                              Flexible(
                                flex: 2,

                                child:
                                Center(
                                  child: Text(
                                    data["name"],
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
                    );
                  });


            }
          }

        },
      ),
    );
  }
}

