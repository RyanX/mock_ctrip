import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mock_ctrip/dao/travel_dao.dart';
import 'package:mock_ctrip/model/travel_tab_model.dart';

import '../dao/travel_tab_dao.dart';
import '../model/travel_model.dart';

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  const TravelTabPage(
      {Key? key, required this.travelUrl, required this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelItem>? travelItems;
  int pageIndex = 1;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: travelItems?.length ?? 0,
      itemBuilder: (context, index) {
        return _TravelItems(index: index, travelItems: travelItems?[index]);
      },
    ));
  }

  void _loadData() {
    TravelDao.fetch(
            widget.travelUrl, widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems?.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var element in resultList) {
      if (element.article != null) {
        //移除article为空的模型
        filterItems.add(element);
      }
    }
    return filterItems;
  }

  Widget _TravelItems({int? index, TravelItem? travelItems}) {
    return Container(
      child: Text('$index'),
    );
  }
}

// class _TravelItem extends StatelessWidget {
//   final TravelItem? item;
//   final int? index;
//
//   const _TravelItem({Key? key, this.item, this.index}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('$index'),
//     );
//   }
// }
