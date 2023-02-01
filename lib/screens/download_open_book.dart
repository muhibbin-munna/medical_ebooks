import 'dart:io';
import 'package:medical_pdf/colors_constant.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_pdf/models/book_model.dart';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:medical_pdf/utils/last_read_database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

PdfViewerController _pdfViewerController = PdfViewerController();
int codeDialog;
String valueText;
String dir;
File file;
int page_no;
TextEditingController _textFieldController = TextEditingController();

Future<void> _displayTextInputDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Jump to page'),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: (value) {
              valueText = value;
            },
            controller: _textFieldController,
            decoration: InputDecoration(
                hintText: "Enter page number (1-" +
                    _pdfViewerController.pageCount.toString() +
                    ")"),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: kTextColorInverse,
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: Colors.green,
              textColor: kTextColorInverse,
              child: Text('OK'),
              onPressed: () {
                codeDialog = num.tryParse(valueText);

                if (codeDialog < _pdfViewerController.pageCount) {
                  Navigator.pop(context);
                  _pdfViewerController.jumpToPage(codeDialog as int);
                } else {
                  Fluttertoast.showToast(
                      msg: "Page between 1 to " +
                          _pdfViewerController.pageCount.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        );
      });
}

class DownloadOpenBook extends StatefulWidget {
  Book _book;
  LastRead last_read_page;

  DownloadOpenBook(this._book, this.last_read_page);

  @override
  _DownloadOpenBookState createState() => _DownloadOpenBookState();
}

PdfTextSearchResult _searchResult;

class _DownloadOpenBookState extends State<DownloadOpenBook>
    with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;
  LastReadDatabaseHelper lastReadHelper = LastReadDatabaseHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _getDir().then((value) {
      setState(() {
        dir = value + Platform.pathSeparator + widget._book.item_id +'.pdf';
        file = new File(dir);
        print("directory : " + dir.toString());
        print(file);
      });
    });
    if(widget.last_read_page != null){
      page_no = widget.last_read_page.pageno;
      _pdfViewerController.jumpToPage(widget.last_read_page.pageno);
    }
    else{
      _pdfViewerController.jumpToPage(0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("dispose" + _pdfViewerController.pageNumber.toString());
    _saveLastRead(_pdfViewerController.pageNumber);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      setState(() {
        print("state " +
            state.toString() +
            " " +
            _pdfViewerController.pageNumber.toString());
        _saveLastRead(_pdfViewerController.pageNumber);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget._book.name,
                style: TextStyle(color: kTextColor)),
            backgroundColor: kMainColor,
            iconTheme: IconThemeData(color: kTextColor),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: kTextColor,
                ),
                onPressed: () {
                  _pdfViewerController.previousPage();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: kTextColor,
                ),
                onPressed: () {
                  _pdfViewerController.previousPage();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: kTextColor,
                ),
                onPressed: () {
                  _pdfViewerController.nextPage();
                },
              ),
            ],
          ),
          body: Container(
              child: file == null
                  ? Center(child: Text('Loading'))
                  : SfPdfViewer.file(
                      file,
                      canShowScrollHead: true,
                      canShowPaginationDialog: true,
                      enableDoubleTapZooming: true,
                      controller: _pdfViewerController,
                      canShowScrollStatus: true,
                      searchTextHighlightColor: Colors.yellow,
                    ))),
    );
    // if (_lastLifecycleState == null)
    //   return Text('This widget has not observed any lifecycle changes.', textDirection: TextDirection.ltr);
    //
    // return Text('The most recent lifecycle state this widget observed was: $_lastLifecycleState.',
    //     textDirection: TextDirection.ltr);
  }

  _showDialog() async {
    await showDialog<String>(
      builder: (context) => new _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Full Name', hintText: 'eg. John Smith'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('OPEN'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ), context: context,
    );
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
  void _saveLastRead(int pageno) async {
    LastRead lastRead = new LastRead(widget._book.item_id, pageno);
    int result;
    if (widget.last_read_page != null) {
      // Case 1: Update operation
      lastRead.id = widget.last_read_page.id;
      result = await lastReadHelper.updateBook(lastRead);
    } else {
      // Case 2: Insert Operation
      result = await lastReadHelper.insertBook(lastRead);
    }
    print(result);
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
