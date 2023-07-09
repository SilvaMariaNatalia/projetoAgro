import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento/login.dart';
import 'package:gerenciamento/home.dart';

import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 35, 109, 25),
      
    ),
    debugShowCheckedModeBanner: false,
  ));
}

