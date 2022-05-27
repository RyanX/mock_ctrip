class TravelItemModel {
  int? totalCount;
  List<TravelItem>? resultList;

  TravelItemModel({this.totalCount, this.resultList});

  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = <TravelItem>[];
      json['resultList'].forEach((v) {
        resultList?.add(TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (resultList != null) {
      data['resultList'] = resultList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelItem {
  int? type;
  Article? article;

  TravelItem({this.type, this.article});

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
    json['article'] != null ? Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (article != null) {
      data['article'] = article!.toJson();
    }
    return data;
  }
}

class Article {
  int? articleId;
  int? productType;
  int? sourceType;
  String? articleTitle;
  String? content;
  String? contentWithoutCtag;
  Author? author;
  List<Images>? images;
  bool? hasVideo;
  int? readCount;
  int? likeCount;
  int? commentCount;
  int? shareCount;
  List<Urls>? urls;
  List<Pois>? pois;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  int? level;
  String? distanceText;
  bool? isLike;
  int? imageCounts;
  bool? isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;
  String? currentDate;
  int? sourceId;
  String? videoAutoplayNet;
  String? combinateContent;

  Article(
      {this.articleId,
        this.productType,
        this.sourceType,
        this.articleTitle,
        this.content,
        this.contentWithoutCtag,
        this.author,
        this.images,
        this.hasVideo,
        this.readCount,
        this.likeCount,
        this.commentCount,
        this.shareCount,
        this.urls,
        this.pois,
        this.publishTime,
        this.publishTimeDisplay,
        this.shootTime,
        this.shootTimeDisplay,
        this.level,
        this.distanceText,
        this.isLike,
        this.imageCounts,
        this.isCollected,
        this.collectCount,
        this.articleStatus,
        this.poiName,
        this.currentDate,
        this.sourceId,
        this.videoAutoplayNet,
        this.combinateContent});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    content = json['content'];
    contentWithoutCtag = json['contentWithoutCtag'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(Urls.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = <Pois>[];
      json['pois'].forEach((v) {
        pois!.add(Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
    currentDate = json['currentDate'];
    sourceId = json['sourceId'];
    videoAutoplayNet = json['videoAutoplayNet'];
    combinateContent = json['combinateContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleId'] = articleId;
    data['productType'] = productType;
    data['sourceType'] = sourceType;
    data['articleTitle'] = articleTitle;
    data['content'] = content;
    data['contentWithoutCtag'] = contentWithoutCtag;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = hasVideo;
    data['readCount'] = readCount;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    data['shareCount'] = shareCount;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (pois != null) {
      data['pois'] = pois!.map((v) => v.toJson()).toList();
    }
    data['publishTime'] = publishTime;
    data['publishTimeDisplay'] = publishTimeDisplay;
    data['shootTime'] = shootTime;
    data['shootTimeDisplay'] = shootTimeDisplay;
    data['level'] = level;
    data['distanceText'] = distanceText;
    data['isLike'] = isLike;
    data['imageCounts'] = imageCounts;
    data['isCollected'] = isCollected;
    data['collectCount'] = collectCount;
    data['articleStatus'] = articleStatus;
    data['poiName'] = poiName;
    data['currentDate'] = currentDate;
    data['sourceId'] = sourceId;
    data['videoAutoplayNet'] = videoAutoplayNet;
    data['combinateContent'] = combinateContent;
    return data;
  }
}

class Author {
  int? authorId;
  String? nickName;
  String? clientAuth;
  String? userUrl;
  String? jumpUrl;
  CoverImage? coverImage;
  String? qualification;
  int? followCount;
  bool? isHost;
  bool? isFollow;
  String? vIcon;
  int? levelValue;
  String? levelValueText;
  String? identityDesc;
  bool? isStarAccount;
  String? describe;
  int? identityType;
  String? identityTypeName;

  Author(
      {this.authorId,
        this.nickName,
        this.clientAuth,
        this.userUrl,
        this.jumpUrl,
        this.coverImage,
        this.qualification,
        this.followCount,
        this.isHost,
        this.isFollow,
        this.vIcon,
        this.levelValue,
        this.levelValueText,
        this.identityDesc,
        this.isStarAccount,
        this.describe,
        this.identityType,
        this.identityTypeName});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    userUrl = json['userUrl'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    qualification = json['qualification'];
    followCount = json['followCount'];
    isHost = json['isHost'];
    isFollow = json['isFollow'];
    vIcon = json['vIcon'];
    levelValue = json['levelValue'];
    levelValueText = json['levelValueText'];
    identityDesc = json['identityDesc'];
    isStarAccount = json['isStarAccount'];
    describe = json['describe'];
    identityType = json['identityType'];
    identityTypeName = json['identityTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['nickName'] = nickName;
    data['clientAuth'] = clientAuth;
    data['userUrl'] = userUrl;
    data['jumpUrl'] = jumpUrl;
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['qualification'] = qualification;
    data['followCount'] = followCount;
    data['isHost'] = isHost;
    data['isFollow'] = isFollow;
    data['vIcon'] = vIcon;
    data['levelValue'] = levelValue;
    data['levelValueText'] = levelValueText;
    data['identityDesc'] = identityDesc;
    data['isStarAccount'] = isStarAccount;
    data['describe'] = describe;
    data['identityType'] = identityType;
    data['identityTypeName'] = identityTypeName;
    return data;
  }
}

class CoverImage {
  String? dynamicUrl;
  String? originalUrl;

  CoverImage({this.dynamicUrl, this.originalUrl});

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    return data;
  }
}

class Images {
  int? imageId;
  String? dynamicUrl;
  String? originalUrl;
  double? width;
  double? height;
  int? mediaType;
  double? lat;
  double? lon;
  bool? isWaterMarked;

  Images(
      {this.imageId,
        this.dynamicUrl,
        this.originalUrl,
        this.width,
        this.height,
        this.mediaType,
        this.lat,
        this.lon,
        this.isWaterMarked});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    lat = json['lat'];
    lon = json['lon'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    data['width'] = width;
    data['height'] = height;
    data['mediaType'] = mediaType;
    data['lat'] = lat;
    data['lon'] = lon;
    data['isWaterMarked'] = isWaterMarked;
    return data;
  }
}

class Urls {
  String? version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    return data;
  }
}

class Pois {
  int? poiType;
  int? poiId;
  String? poiName;
  int? businessId;
  int? districtId;
  PoiExt? poiExt;
  int? source;
  int? isMain;
  bool? isInChina;
  String? countryName;
  String? districtName;
  String? districtENName;

  Pois(
      {this.poiType,
        this.poiId,
        this.poiName,
        this.businessId,
        this.districtId,
        this.poiExt,
        this.source,
        this.isMain,
        this.isInChina,
        this.countryName,
        this.districtName,
        this.districtENName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt =
    json['poiExt'] != null ? PoiExt.fromJson(json['poiExt']) : null;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    countryName = json['countryName'];
    districtName = json['districtName'];
    districtENName = json['districtENName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['businessId'] = businessId;
    data['districtId'] = districtId;
    if (poiExt != null) {
      data['poiExt'] = poiExt!.toJson();
    }
    data['source'] = source;
    data['isMain'] = isMain;
    data['isInChina'] = isInChina;
    data['countryName'] = countryName;
    data['districtName'] = districtName;
    data['districtENName'] = districtENName;
    return data;
  }
}

class PoiExt {
  String? h5Url;
  String? appUrl;

  PoiExt({this.h5Url, this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}