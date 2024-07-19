// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Showpasarela extends StatefulWidget {
  const Showpasarela({super.key});

  @override
  State<Showpasarela> createState() => _ShowpasarelaState();
}

class _ShowpasarelaState extends State<Showpasarela> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('images').listAll();
      final List<String> urls =
          await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
      setState(() {
        _imageUrls = urls;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando la imágen: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 185, 238),
        title: const Text("Centro de previsualización",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _imageUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: _imageUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Image.network(_imageUrls[index]);
              },
            ),
    );
  }
}
