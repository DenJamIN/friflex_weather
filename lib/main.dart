import 'package:flutter/material.dart';
import 'package:friflex/pages/city_select_page.dart';

void main() {
  runApp(const MyApp());
}

//Программа, которая даст мне шанс научиться и стать хорошим разрабом!
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Friflex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CitySelectPage()
    );
  }
}
