import 'dart:convert';

SystemInfo systemInfoModelJson(String str) =>
    SystemInfo.fromJson(jsonDecode(str));

String systemInfoModelToJson(SystemInfo data) => jsonEncode(data.toJson());

class SystemInfo {
  bool day;

  SystemInfo({required this.day});

  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      SystemInfo(day: json['pod'] == 'd' ? true : false);

  Map<String, dynamic> toJson() => {'pod': day ? 'd' : 'n'};
}
