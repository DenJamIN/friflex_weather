class Snow {
  num periodH;

  Snow({required this.periodH});

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(periodH: json['3h']);

  Map<String, dynamic> toJson() => {'3h': periodH};
}
