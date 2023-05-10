import 'dart:convert';

class Entry {
  String? article;
  double? date;
  double? start;
  double? end;
  String? label;
  Asset? asset;

  Entry({
    this.article,
    this.date,
    this.start,
    this.end,
    this.label,
    this.asset,
  });

  factory Entry.fromRawJson(String str) => Entry.fromJson(json.decode(str));

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        article: json['article'],
        label: json['label'],
        date: json['date'],
        start: json['start'],
        end: json['end'],
        asset: json['asset'] == null ? null : Asset.fromJson(json['asset']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article': article,
        'label': label,
        'date': date,
        'start': start,
        'end': end,
        'asset': asset?.toJson(),
      };
}

class Asset {
  int? height;
  int? width;
  String? source;

  Asset({
    this.height,
    this.width,
    this.source,
  });

  factory Asset.fromRawJson(String str) => Asset.fromJson(json.decode(str));

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        source: json['source'],
        height: json['height'],
        width: json['width'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'source': source,
        'height': height,
        'width': width,
      };
}
