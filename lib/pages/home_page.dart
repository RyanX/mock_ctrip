import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:mock_ctrip/dao/home_dao.dart';
import 'package:mock_ctrip/model/common_model.dart';
import 'package:mock_ctrip/widget/grid_nav.dart';
import 'package:mock_ctrip/widget/local_nav.dart';
import 'package:mock_ctrip/widget/sub_nav.dart';

import '../model/grid_nav_model.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final List _images = [
    'https://dimg04.c-ctrip.com/images/0zg1q120009ggsv8s38DA.jpg',
    'https://dimg04.c-ctrip.com/images/0zg1p120009ggswfhA338.jpg',
    'https://dimg04.c-ctrip.com/images/0zg43120009ggsk3n380D.jpg'
  ];
  double appBarAlpha = 0;
  List<CommonModel>? localNavList;
  GridNavModel? gridNavModel;
  List<CommonModel>? subNavList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    HomeDao.fetch().then((value) {
      setState(() {
        localNavList = value.localNavList;
        gridNavModel = value.gridNav;
        subNavList = value.subNavList;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00fff2f2),
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  // 滚动列表监听且是组件内的第一个元素时
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    child: Swiper(
                      itemCount: _images.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _images[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: const SwiperPagination(),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: localNavList ?? [])),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: GridNav(gridNavModel: gridNavModel)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: SubNav(subNavList: subNavList)),
                  Container(
                    height: 800,
                    child: const ListTile(
                      title: Text('resultString'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
