import 'package:flutter/material.dart';
import 'package:mock_ctrip/model/common_model.dart';
import 'package:mock_ctrip/model/grid_nav_model.dart';
import 'package:mock_ctrip/widget/webview.dart';
import 'package:mock_ctrip/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel>? subNavList;

  const SubNav({Key? key, required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(context, model));
    }
    // 计算第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList?.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Webview(
                          url: model.url,
                          statusBarColor: model.statesBarColor,
                          hideAppBar: model.hideAppBar,
                        )));
          },
          child: Column(
            children: [
              Image.network(
                model.icon ?? '',
                width: 18,
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  model.title ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
