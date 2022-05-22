///搜索模型
class SearchModel {
  String? keyword;
  final List<SearchItem>? data;

  SearchModel({this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<SearchItem> data =
        dataJson.map((i) => SearchItem.fromJson(i)).toList();
    return SearchModel(data: data);
  }
}

class SearchItem {
  final String? word; //xx酒店
  final String? type; //hotel
  // final String? price; //实时计价
  // final String? star; //豪华型
  final String? cityName; //虹桥
  final String? districtName; //上海
  final String? url;
  final String? productScore;

  SearchItem(
      {this.word,
      this.type,
      // this.price,
      // this.star,
      this.cityName,
      this.districtName,
      this.url,
      this.productScore});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        word: json['word'],
        type: json['type'],
        // price: json['price'],
        // star: json['star'],
        cityName: json['cityName'],
        districtName: json['districtName'],
        url: json['url'],
        productScore: json['productScore'].toString());
  }
}
