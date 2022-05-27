import 'dart:convert';

import 'package:mock_ctrip/model/home_model.dart';
import 'package:http/http.dart' as http;

import '../model/travel_model.dart';
import '../model/travel_tab_model.dart';

const TRAVEL_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍页接口

var Params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 2,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
    "cid": "09031014111431397988",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": null,
    "extension": [
      {"name": "protocal", "value": "https"}
    ]
  },
  "contentType": "json"
};

class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map<String, dynamic> params = Params['pagePara'] as Map<String, dynamic>;
    params['pageIndex'] = pageIndex;
    params['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;
    final response = await http.post(Uri.parse(url), body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
