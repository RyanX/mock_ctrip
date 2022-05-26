import 'package:flutter/material.dart';
import 'package:mock_ctrip/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Webview(
        url: 'https://m.ctrip.com/webapp/myctrip/?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }
}
