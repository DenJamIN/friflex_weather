class Rain {
  num periodH;

  Rain({required this.periodH});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory Rain.fromJson(Map<String, dynamic> json) => Rain(periodH: json['3h']);

  Map<String, dynamic> toJson() => {'3h': periodH};
}
