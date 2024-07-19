// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Showpasarela extends StatefulWidget {
  const Showpasarela({super.key});

  @override
  State<Showpasarela> createState() => _ShowpasarelaState();
}

class _ShowpasarelaState extends State<Showpasarela> {
  final List<String> _imageUrls = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadImages();

  }

  Future<void> _loadImages() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final ListResult result = await FirebaseStorage.instance.ref('/images').listAll();
      final List<String> urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

      setState(() {
        _imageUrls.addAll(urls);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando la imagen: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain, // Ajusta la imagen dentro del diálogo
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 185, 238),
        title: const Text(
          "Pasarela de Visualización",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _imageUrls.isEmpty && !_isLoading
          ? const Center(child: Text("No hay imágenes disponibles"))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _imageUrls.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == _imageUrls.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GestureDetector(
                  onTap: () => _showImageDialog(_imageUrls[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                      _imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}