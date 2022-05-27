/// https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031084316977558113&x-traceID=09031084316977558113-1653552635149-2052601
/// {"districtId":0,"groupChannelCode":"tourphoto_global1","type":1,"lat":-180,"lon":-180,"locatedDistrictId":0,"pagePara":{"pageIndex":1,"pageSize":10,"sortType":9,"sortDirection":0},"imageCutType":1,"head":{"cid":"09031084316977558113","ctok":"","cver":"1.0","lang":"01","sid":"8888","syscode":"09","auth":"","xsid":"","extension":[{"name":"tecode","value":"h5"}]}}
///旅拍类别模型
class TravelTabModel {
  String? url;
  List<TravelTab>? tabs;

  TravelTabModel({this.url, this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['tabs'] != null) {
      tabs = <TravelTab>[];
      json['tabs'].forEach((v) {
        tabs?.add(TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    if (tabs != null) {
      data['tabs'] = tabs?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTab {
  String? labelName;
  String? groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['labelName'] = labelName;
    data['groupChannelCode'] = groupChannelCode;
    return data;
  }
}
