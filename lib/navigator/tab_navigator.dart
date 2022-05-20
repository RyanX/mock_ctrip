import 'package:flutter/material.dart';
import 'package:mock_ctrip/pages/home_page.dart';
import 'package:mock_ctrip/pages/my_page.dart';
import 'package:mock_ctrip/pages/search_page.dart';
import 'package:mock_ctrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(
            hideLeft: true,
          ),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _item(Icon(Icons.home, color: _defaultColor),
              Icon(Icons.home, color: _activeColor), '首页'),
          _item(Icon(Icons.search, color: _defaultColor),
              Icon(Icons.search, color: _activeColor), '搜索'),
          _item(Icon(Icons.camera_alt, color: _defaultColor),
              Icon(Icons.camera_alt, color: _activeColor), '旅拍'),
          _item(Icon(Icons.account_circle, color: _defaultColor),
              Icon(Icons.account_circle, color: _activeColor), '我的')
        ],
      ),
    );
  }

  _item(Icon icon, Icon activeIcon, String label) {
    return BottomNavigationBarItem(
        icon: icon, activeIcon: activeIcon, label: label);
  }
}
