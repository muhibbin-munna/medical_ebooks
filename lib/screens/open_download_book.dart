import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:medical_pdf/utils/last_read_database_helper.dart';
import 'package:path_provider/path_provider.dart';

class OpenDownloadedBook extends StatefulWidget {
  var pageTextChanged;
  var option;
  LastRead last_read_page;

  OpenDownloadedBook(this.pageTextChanged, this.option, this.last_read_page);

  @override
  _OpenDownloadedBookState createState() => _OpenDownloadedBookState();
}

class _OpenDownloadedBookState extends State<OpenDownloadedBook>
    with WidgetsBindingObserver {
  String dir;
  bool loading = false;
  @override
  void initState() {
    loading = true;
    super.initState();
    _getDir().then((value) {
      setState(() {
        dir =
            value + Platform.pathSeparator + widget.pageTextChanged.id + '.pdf';
        loading = false;
        print("directory : " + dir.toString());
      });
    });

    if (widget.last_read_page != null) {
      page_no = widget.last_read_page.pageno;
    } else {
      page_no = 0;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("dispose" + indexPage.toString());
    _saveLastRead(indexPage);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      setState(() {
        print("state " +
            state.toString() +
            " " +
            controller.getCurrentPage().toString());
        _saveLastRead(indexPage);
      });
    }
  }

  _saveLastRead(int pageno) async {
    LastRead lastRead = new LastRead(widget.pageTextChanged.id, pageno);
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

  Future<String> _getDir() async {
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    final internalDir = await getApplicationDocumentsDirectory();
    String dir = internalDir.path + Platform.pathSeparator + 'download';
    print("direc" + dir);
    return dir;
    // }
  }

  PDFViewController controller;
  TextEditingController text_controller = new TextEditingController();
  int page_no;
  int pages = 0;
  int indexPage = 0;
  LastReadDatabaseHelper lastReadHelper = LastReadDatabaseHelper();


  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.pageTextChanged['name']),
          actions: pages >= 0
              ? [
                  GestureDetector(onTap: (){
                    _showDialog();
                  },
                      child: Center(child: Text(text))),
                  IconButton(
                    icon: Icon(Icons.chevron_left, size: 32),
                    onPressed: () {
                      final page = indexPage == 0 ? pages : indexPage - 1;
                      controller.setPage(page);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, size: 32),
                    onPressed: () {
                      final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                      controller.setPage(page);
                    },
                  ),
                ]
              : null,
        ),
        body: loading? Center(child: CircularProgressIndicator()): PDFView(
          filePath: dir,
          pageSnap: false,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: false,
          onRender: (_pages) {
            setState(() {
              pages = _pages;
            });
          },
          defaultPage: page_no,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            setState(() => this.controller = pdfViewController);
          },
          onPageChanged: (int page, int total) {
            print('page change: $page/$total');
            setState(() => this.indexPage = page);
          },
        ));
  }

  _showDialog() async {
    print("Show");
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: TextField(
          controller: text_controller,
          autofocus: true,
          decoration: new InputDecoration(
              labelText: 'Enter a page number',
              hintText: ("1-" + pages.toString())),
        ),
        actions: <Widget>[
          new TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new TextButton(
              child: const Text('GO'),
              onPressed: () {
                Navigator.pop(context);
                controller.setPage(int.parse(text_controller.text)-1);
                text_controller.clear();
              })
        ],
      ),
    );
  }
}

