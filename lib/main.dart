import 'dart:io';

import 'package:ecommerce/data/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  var path = Directory.current.path;
  Hive
  ..init(path)
  ..registerAdapter(UserModelAdapter());

  Hive.openBox('userbox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
