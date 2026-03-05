


import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';

class MyApp extends StatelessWidget{
 const MyApp({super.key});  

  @override
  Widget build(BuildContext context) {

   return MaterialApp(
      title: 'Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}