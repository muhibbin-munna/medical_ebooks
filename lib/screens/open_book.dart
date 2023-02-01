import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:path_provider/path_provider.dart';

//
// PdfViewerController _pdfViewerController = PdfViewerController();
int codeDialog;
String valueText;
String dir;
File file;

int page_no;
// TextEditingController _textFieldController = TextEditingController();


// Future<void> _displayTextInputDialog(BuildContext context) async {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Jump to page'),
//           content: TextField(
//             keyboardType: TextInputType.number,
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             ],
//             onChanged: (value) {
//               valueText = value;
//             },
//             controller: _textFieldController,
//             decoration: InputDecoration(
//                 hintText: "Enter page number (1-" +
//                     _pdfViewerController.pageCount.toString() +
//                     ")"),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               color: Colors.red,
//               textColor: kTextColorInverse,
//               child: Text('CANCEL'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             FlatButton(
//               color: Colors.green,
//               textColor: kTextColorInverse,
//               child: Text('OK'),
//               onPressed: () {
//                 codeDialog = num.tryParse(valueText);
//
//                 if (codeDialog < _pdfViewerController.pageCount) {
//                   Navigator.pop(context);
//                   _pdfViewerController.jumpToPage(codeDialog as int);
//                 } else {
//                   Fluttertoast.showToast(
//                       msg: "Page between 1 to " +
//                           _pdfViewerController.pageCount.toString(),
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.BOTTOM,
//                       timeInSecForIosWeb: 1,
//                       fontSize: 16.0);
//                 }
//               },
//             ),
//           ],
//         );
//       });
// }

class OpenBook extends StatefulWidget {
  var pageTextChanged;
  var option;
  LastRead last_read_page;

  OpenBook(this.pageTextChanged, this.option, this.last_read_page);

  @override
  _OpenBookState createState() => _OpenBookState();
}

// PdfTextSearchResult _searchResult;

class _OpenBookState extends State<OpenBook> with WidgetsBindingObserver {
  bool _isLoading = true;
  bool _isError = false;
  PDFDocument document;

  // bool _visible = true;
  // AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.pageTextChanged['link']);
    loadDocument();
  }

  @override
  dispose() {
    super.dispose();
  }

  loadDocument() async {
    try {
      document = await PDFDocument.fromURL(
        'https://drive.google.com/uc?id=' + widget.pageTextChanged["link"] +
            '&export=download',
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    }on Exception catch (e) {
      print(e);
      _isError = true;
    }
    catch(e){
      print(e.toString());
      _isError = true;
    }


    setState(() => _isLoading = false);
  }

  Future<String> _getDir() async {
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    final internalDir = await getApplicationDocumentsDirectory();
    String dir = internalDir.path + Platform.pathSeparator + 'download';
    print("direc" + dir);
    return dir;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _isError?
              Center(child: Text("Some Error Occurred\nTry to download"))
          :PDFViewer(
            document: document,
            zoomSteps: 1,
            lazyLoad: false,
            // uncomment below line to scroll vertically
            scrollDirection: Axis.vertical,

            //uncomment below code to replace bottom navigation with your own
            // navigationBuilder:
            //     (context, page, totalPages, jumpToPage, animateToPage) {
            //   return ButtonBar(
            //     alignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       IconButton(
            //         icon: Icon(Icons.first_page),
            //         onPressed: () {
            //           jumpToPage(page: 0);
            //         },
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.arrow_back),
            //         onPressed: () {
            //           animateToPage(page: page - 2);
            //         },
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.arrow_forward),
            //         onPressed: () {
            //           animateToPage(page: page);
            //         },
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.last_page),
            //         onPressed: () {
            //           jumpToPage(page: totalPages - 1);
            //         },
            //       ),
            //     ],
            //   );
            // },
          ),
        ),
      ),
    );
  }
}

class SlidingAppBar extends PreferredSize {
  SlidingAppBar({
    @required this.child,
    @required this.controller,
    @required this.visible,
  });

  @override
  final PreferredSizeWidget child;

  @override
  Size get preferredSize => child.preferredSize;

  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}


