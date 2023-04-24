class Snow {
  num periodH;

  Snow({required this.periodH});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory Snow.fromJson(Map<String, dynamic> json) => Snow(periodH: json['3h']);

  Map<String, dynamic> toJson() => {'3h': periodH};
}
