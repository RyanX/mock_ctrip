class CommonModel {
  final String? icon;
  final String? title;
  final String? url;
  final String? statesBarColor;
  final bool? hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statesBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statesBarColor: json['statesBarColor'],
        hideAppBar: json['hideAppBar']);
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'url': url,
      'statesBarColor': statesBarColor,
      'hideAppBar': hideAppBar
    };
  }
}
