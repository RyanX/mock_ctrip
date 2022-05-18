import 'package:mock_ctrip/model/common_model.dart';
import 'package:mock_ctrip/model/config_model.dart';
import 'package:mock_ctrip/model/grid_nav_model.dart';
import 'package:mock_ctrip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel? config;
  final List<CommonModel>? bannerList;
  final List<CommonModel>? localNavList;
  final List<CommonModel>? subNavList;
  final GridNavModel? gridNav;
  final SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['localNavList'] as List;
    List<CommonModel>? bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel>? localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel>? subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        config: ConfigModel.fromJson(json['config']),
        gridNav: GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']));
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config,
      'bannerList': bannerList,
      'localNavList': localNavList,
      'subNavList': subNavList,
      'gridNav': gridNav,
      'salesBox': salesBox
    };
  }
}
