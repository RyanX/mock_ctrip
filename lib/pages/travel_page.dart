import 'package:flutter/material.dart';
import 'package:mock_ctrip/model/travel_tab_model.dart';

import '../dao/travel_tab_dao.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController? _controller;
  List<TravelTab> _tabs = [];
  TravelTabModel? travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((model) {
      _controller = TabController(length: model.tabs?.length ?? 0, vsync: this);
      setState(() {
        _tabs = model.tabs ?? [];
        travelTabModel = model;
      });
    }).catchError((onError) => {print(onError)});
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: _tabs.map((tab) {
                return Tab(text: tab.labelName);
              }).toList()),
        ),
        Flexible(
            child: TabBarView(
                controller: _controller,
                children: _tabs.map((tab) {
                  return Text(tab.groupChannelCode ?? '');
                }).toList()))
      ],
    ));
  }
}
