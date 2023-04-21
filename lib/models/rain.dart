import 'dart:convert';

Rain windModelJson(String str) => Rain.fromJson(jsonDecode(str));

String windModelToJson(Rain data) => jsonEncode(data.toJson());

class Rain {
  num periodH;

  Rain({required this.periodH});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(periodH: json['3h']);

  Map<String, dynamic> toJson() => {'3h': periodH};
}
