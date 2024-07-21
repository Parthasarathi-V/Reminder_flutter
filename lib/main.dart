import 'package:flutter/material.dart';
import 'package:reminder/home_page.dart';
import 'package:reminder/search_page.dart';

void main(){
  runApp( MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: "Lato Regular",
  )
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView();

  }
}



