import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/network.dart';

///没有使用MVVM设计模式的Widget
///author:liuhc
class HomePageNoMVVM extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageNoMVVM> {
  bool _loading = true;
  String _text;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      _loading = true;
      _text = "";
    });
    NetWork.query().then((String text) {
      setState(() {
        _loading = false;
        _text =
            text; //here we change the data and using setState to update in view
      });
    }).catchError((error) {
      setState(() {
        _loading = false;
        _text = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter没有使用MVVM的示例"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("点击重新获取网络数据"),
              onPressed: () {
                // TODO: without using mvvm, use setState
                loadData();
              },
            ),
            Offstage(
              offstage: !_loading,
              child: CircularProgressIndicator(),
            ),
            Expanded(
              // TODO: using flutter state management setState to update
              child: SingleChildScrollView(
                child: Text("${_text ?? ""}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
