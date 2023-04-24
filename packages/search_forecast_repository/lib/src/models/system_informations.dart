class SystemInfo {
  bool day;

  SystemInfo({required this.day});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      SystemInfo(day: json['pod'] == 'd' ? true : false);

  Map<String, dynamic> toJson() => {'pod': day ? 'd' : 'n'};
}
