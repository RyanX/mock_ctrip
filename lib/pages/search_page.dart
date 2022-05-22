import 'package:flutter/material.dart';
import 'package:mock_ctrip/dao/search_dao.dart';
import 'package:mock_ctrip/widget/search_bar.dart';
import 'package:mock_ctrip/widget/webview2.dart';

import '../model/search_model.dart';

const TYPES = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;

  const SearchPage({Key? key, this.hideLeft, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  late String keyword;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      }))),
        ],
      ),
    );
  }

  _onTextChanged(String text) {
    keyword = text;
    if (text.isEmpty) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    SearchDao.fetch(keyword)
        .then((SearchModel model) => {
              //只有当当前输入的内容和服务端返回的内容一致时才渲染页面
              if (model.keyword == keyword)
                {
                  setState(() {
                    searchModel = model;
                  })
                }
            })
        .catchError((onError) {
      print(onError);
    });
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            decoration: const BoxDecoration(color: Colors.white),
            child: SearchBar(
                hideLeft: widget.hideLeft,
                defaultText: widget.keyword,
                hint: widget.hint,
                leftButtonClick: () {
                  Navigator.pop(context);
                },
                onChanged: _onTextChanged),
          ),
        )
      ],
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem item = searchModel!.data![position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView2(
                      url: item.url,
                      title: '详情',
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item.type ?? '')),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _typeImage(String type) {
    if (type.isEmpty) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    for (final name in TYPES) {
      if (type.contains(name)) {
        path = name;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans
        .addAll(_keywordTextSpans(item.word ?? '', searchModel?.keyword ?? ''));
    spans.add(TextSpan(
        text: ' ' + (item.cityName ?? '') + ' ' + (item.districtName ?? ''),
        style: const TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
        text: item.productScore ?? '',
        style: const TextStyle(fontSize: 16, color: Colors.orange),
      ),
      TextSpan(
        text: ' ' + (item.type ?? ''),
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ]));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word.isEmpty) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle =
        const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle =
        const TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
