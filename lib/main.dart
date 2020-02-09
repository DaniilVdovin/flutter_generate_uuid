import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  Admob.initialize("ca-app-pub-3940256099942544~3347511713");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate UUID',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.orangeAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dmen = [
    "com",
    "ru",
    "us",
    "ar",
    "рф",
    "uk",
    "io",
    "dm",
    "mi",
    "sp",
    "gg",
    "fu",
  ];
  static Widget defItem = Center(child: Text("Please enter name."));
  Widget _builditem(String dmen, String uid) {
    return ListTile(
      title: Text("$uid"),
      leading: CircleAvatar(
        child: Text("$dmen"),
      ),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: uid));
        Fluttertoast.showToast(
            msg: "COPY",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.deepOrange,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  var _name;
  var list = <Widget>[];
  _itemBuilder(String name) async {
    var _list = [];
    if (name == null) {
      _list.add(defItem);
    } else
      for (var i in dmen) {
        var uid = Uuid().v5(Uuid.NAMESPACE_URL, "www.$name.$i");
        setState(() {
          _list.add(_builditem(i, uid));
        });
      }
    return list;
  }

  @override
  void initState() {
    _itemBuilder(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 100.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: Colors.black,
                    offset: Offset(0, 2.0),
                  ),
                ],
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.topRight,
                          icon: Icon(FontAwesomeIcons.idBadge,
                              color: Colors.orangeAccent, size: 48.0),
                          onPressed: null),
                      Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                              hoverColor: Colors.orangeAccent,
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(color: Colors.orangeAccent),
                              hintText: "Enter something one",
                            ),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600),
                            onSubmitted: (text) {
                              _itemBuilder(text);
                              _name = text;
                              print("Click");
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              constraints: BoxConstraints.expand(height: 70.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: Colors.black,
                    offset: Offset(0, 2.0),
                  ),
                ],
              ),
              child: Container(
                child: Center(
                  child: Text(
                      "Generate used V5 (name-sha1-based)",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600
                          ),
                    ),
                ), 
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(minWidth: 300.0, minHeight: 150.0),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6.0,
                      color: Colors.black12,
                      offset: Offset(0, 2.0),
                    ),
                  ],
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    if (_name != null && index < dmen.length)
                      return _builditem(
                          dmen[index],
                          Uuid().v5(
                              Uuid.NAMESPACE_URL, "www.$_name.${dmen[index]}"));
                  },
                ),
              ),
            ),
            SizedBox(
              child: Container(
                constraints: BoxConstraints.expand(height: 50),
                child: AdmobBanner(
                  adUnitId: "ca-app-pub-3688869810838809/1943827161",
                  adSize: AdmobBannerSize.SMART_BANNER,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
