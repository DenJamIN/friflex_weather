import 'dart:convert';

Clouds cloudsModelJson(String str) => Clouds.fromJson(jsonDecode(str));

String cloudsModelToJson(Clouds data) => jsonEncode(data.toJson());

class Clouds {
  num all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(all: json['all']);

  Map<String, dynamic> toJson() => {'all': all};
}
