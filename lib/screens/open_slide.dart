import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpenSlide extends StatefulWidget {
  var pageTextChanged;
  var option;

  OpenSlide(this.pageTextChanged, this.option);

  @override
  _OpenSlideState createState() => _OpenSlideState();
}

class _OpenSlideState extends State<OpenSlide> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  PDFDocument document ;
  // bool _visible = true;
  // AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 400),
    // );
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    loadDocument();
   
  }
  @override
  dispose(){
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }
  loadDocument() async {
    document = await PDFDocument.fromURL(
      // 'https://drive.google.com/uc?id=1qGViugPYHvuDD0HIWwHklPMhPTXSlNk8&export=download',
      'https://drive.google.com/uc?id='+widget.pageTextChanged['link']+'&export=download',
      /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
    );

    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:
        // SlidingAppBar(
        //   controller: _controller,
        //   visible: _visible,
        //   child:
        // AppBar(
        //     title: Text("Slides",
        //         style: TextStyle(color: kTextColor)),
        //     backgroundColor: kMainColor,
        //     iconTheme: IconThemeData(color: kTextColor),
        //
        //   ),
        // ),
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
            document: document,
            zoomSteps: 1,
            lazyLoad: false,

            // uncomment below line to scroll vertically
            // scrollDirection: Axis.vertical,

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


