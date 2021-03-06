import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mock_ctrip/dao/travel_dao.dart';
import 'package:mock_ctrip/model/travel_tab_model.dart';

import '../dao/travel_tab_dao.dart';
import '../model/travel_model.dart';
import '../widget/loading_container.dart';
import '../widget/webview.dart';

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

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem>? travelItems;
  int pageIndex = 1;
  bool _loading = true;
  ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingContainer(
      isLoading: _loading,
      child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: MasonryGridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                itemCount: travelItems?.length ?? 0,
                itemBuilder: (context, index) {
                  return _TravelItems(index: index, item: travelItems?[index]);
                },
              ))),
    ));
  }

  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    TravelDao.fetch(
            widget.travelUrl, widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((model) {
      _loading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems?.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((onError) {
      _loading = false;
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
        //??????article???????????????
        filterItems.add(element);
      }
    }
    return filterItems;
  }

  Widget _TravelItems({int? index, TravelItem? item}) {
    return GestureDetector(
      onTap: () {
        if (item != null &&
            item.article != null &&
            item.article!.urls != null &&
            item.article!.urls!.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Webview(
                        url: item.article?.urls?[0].h5Url,
                        title: '??????',
                      )));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(item),
              Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  item?.article?.articleTitle ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText(item)
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(TravelItem? item) {
    return Stack(
      children: [
        Image.network(item?.article?.images?[0].dynamicUrl ?? ''),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(item),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName(TravelItem? item) {
    return (item?.article?.pois ?? []).isEmpty
        ? '??????'
        : item?.article?.pois?[0].poiName ?? '??????';
  }

  _infoText(TravelItem? item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item?.article?.author?.coverImage?.dynamicUrl ?? '',
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item?.article?.author?.nickName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  item?.article?.likeCount?.toString() ?? '',
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _loadData();
  }
}
