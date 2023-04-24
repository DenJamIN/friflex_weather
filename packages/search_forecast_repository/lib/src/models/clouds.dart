class Clouds {
  num all;

  Clouds({required this.all});

  //Достаём значения из джейсонки
  //Делаем фабричный констурктор, для того чтобы создать только один экземпляр
  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(all: json['all']);

  Map<String, dynamic> toJson() => {'all': all};
}
