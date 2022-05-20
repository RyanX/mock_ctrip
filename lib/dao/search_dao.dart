import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/search_model.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?action=online&source=globalonline&keyword=';

///搜索入口
class SearchDao {
  static Future<SearchModel> fetch(String keyword) async {
    final response = await http.get(Uri.parse(SEARCH_URL + keyword));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当当前输入的内容和服务端返回的内容一致时才渲染页面
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
