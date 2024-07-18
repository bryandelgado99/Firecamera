// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Informationpage extends StatelessWidget {
  const Informationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 205, 185, 238),
        title: const Text("Galeria",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Firecamera",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              paragraphText(),
              SizedBox(
                height: 15,
              ),
              Text("Desarrollada por: ", style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 8,
              ),
              Text("- Delgado Yela Bryan P.", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 8,
              ),
              Text("- Miño Ochoa Mateo R.", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget paragraphText() {
  return Text(
    "Una aplicación divertida, para tomar fotos y guardarlas en la nube. Gracias a Firebase Cloudstore almacena tus recuerdos de forma segura.",
    style: TextStyle(fontSize: 16),
    textAlign: TextAlign.justify,
  );
}
