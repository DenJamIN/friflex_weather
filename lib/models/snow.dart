import 'dart:convert';

Snow snowModelJson(String str) => Snow.fromJson(jsonDecode(str));

String snowModelToJson(Snow data) => jsonEncode(data.toJson());

class Snow {
  num periodH;

  Snow({required this.periodH});

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(periodH: json['3h']);

  Map<String, dynamic> toJson() => {'3h': periodH};
}
