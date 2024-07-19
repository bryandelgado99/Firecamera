import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD8eakSRXfQutDmLqwycFL4JXNScVJ11vA',
      appId: '1:656411162577:android:d2d46b40df3aa80c1252f0',
      messagingSenderId: '656411162577',
      projectId: 'firecamera-fa8e5',
      storageBucket: 'firecamera-fa8e5.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireCamera',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}
