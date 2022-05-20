import 'package:flutter/material.dart';
import 'package:mock_ctrip/dao/search_dao.dart';
import 'package:mock_ctrip/widget/search_bar.dart';

import '../model/search_model.dart';

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
    return Text(item.word ?? '');
  }
}
