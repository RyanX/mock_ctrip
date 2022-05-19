import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:mock_ctrip/dao/home_dao.dart';
import 'package:mock_ctrip/model/common_model.dart';
import 'package:mock_ctrip/model/home_model.dart';
import 'package:mock_ctrip/widget/grid_nav.dart';
import 'package:mock_ctrip/widget/loading_container.dart';
import 'package:mock_ctrip/widget/local_nav.dart';
import 'package:mock_ctrip/widget/sales_box.dart';
import 'package:mock_ctrip/widget/sub_nav.dart';

import '../model/grid_nav_model.dart';
import '../model/sales_box_model.dart';
import '../widget/webview2.dart';

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

  double appBarAlpha = 0;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  GridNavModel? gridNavModel;
  List<CommonModel>? subNavList;
  SalesBoxModel? salesBox;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox!;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
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
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      // 滚动列表监听且是组件内的第一个元素时
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar
          ],
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: LocalNav(localNavList: localNavList ?? [])),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: GridNav(gridNavModel: gridNavModel)),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SubNav(subNavList: subNavList)),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SalesBox(salesBox: salesBox)),
      ],
    );
  }

  Widget get _appBar {
    return Opacity(
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
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemCount: bannerList?.length ?? 0,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList![index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView2(
                            url: model.url,
                            title: model.title,
                            hideAppBar: model.hideAppBar,
                          )));
            },
            child: Image.network(
              bannerList![index].icon!,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }
}
