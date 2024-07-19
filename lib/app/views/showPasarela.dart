import 'package:flutter/material.dart';

class Showpasarela extends StatefulWidget {
  const Showpasarela({super.key});

  @override
  State<Showpasarela> createState() => _ShowpasarelaState();
}

class _ShowpasarelaState extends State<Showpasarela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 185, 238),
        title: const Text("Centro de previsualización",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text("hello"),
      ),
    );
  }
}
