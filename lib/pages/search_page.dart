import 'package:flutter/material.dart';
import 'package:mock_ctrip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SearchBar(
              hideLeft: true,
              defaultText: '嘿嘿',
              hint: '123',
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChanged)
        ],
      ),
    );
  }

  _onTextChanged(text){

  }
}
