import 'package:flutter/material.dart';
import 'package:mock_ctrip/model/common_model.dart';
import 'package:mock_ctrip/model/grid_nav_model.dart';
import 'package:mock_ctrip/widget/webview.dart';
import 'package:mock_ctrip/widget/webview2.dart';

import '../model/sales_box_model.dart';

///底部卡片入口
class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key? key, required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1!, salesBox.bigCard2!, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1!, salesBox.smallCard2!, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3!, salesBox.smallCard4!, false, true));

    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox.icon!,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebView(url: salesBox.moreUrl, title: '更多活动')));
                  },
                  child: const Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard,
      bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, leftCard, isBig, true, isLast),
        _item(context, rightCard, isBig, false, isLast)
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool isBig, bool isLeft,
      bool isLast) {
    BorderSide borderSide =
        const BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView2(
                      url: model.url,
                      statusBarColor: model.statesBarColor,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: isLeft ? borderSide : BorderSide.none,
                bottom: isLast ? BorderSide.none : borderSide)),
        child: Image.network(
          model.icon ?? '',
          fit: BoxFit.fill,
          // 获取屏幕宽度
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: isBig ? 129 : 80,
        ),
      ),
    );
  }
}
