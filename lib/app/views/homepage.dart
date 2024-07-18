// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/informationPage.dart';
import 'package:url_launcher/link.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomeState createState() => _HomeState();
}

// Camara
class _HomeState extends State<Homepage> {
  Uint8List? _webImage;
  final List<Uint8List> _webImages = [];
  bool _showGallery = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (kIsWeb) {
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _webImages.add(_webImage!);
        });
      } else {
        print('Imágen no seleccionada');
      }
    }
  }

  Future<void> _pickWebCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _webImage = bytes;
        _webImages.add(_webImage!);
      });
    } else {
      print('Imágen no seleccionada');
    }
  }

// Pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 205, 185, 238),
        title: const Text("Galeria",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://th.bing.com/th/id/R.a029bcc15d26dde4942b3a187412aa27?rik=VjbmPir%2bHOO2lA&pid=ImgRaw&r=0"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: const [
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      "Bienvenidos",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    listItems(context, _toggleGallery),
                    githubLink(),
                    const Text(
                      "V 1.0.0",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: _showGallery
            ? _buildGallery()
            : _webImage == null
                ? const Text("Firecamera - Tú cámara ideal")
                : Image.memory(_webImage!),
      ),
      floatingActionButton: _showGallery
          ? null
          : FloatingActionButton(
              onPressed: _optionsDialogBox,
              child: Icon(Icons.camera_alt_rounded),
            ),
    );
  }

// Galeria
  Widget _buildGallery() {
    if (kIsWeb) {
      if (_webImages.isEmpty) {
        return const Text("No hay imágenes en la galería");
      } else {
        return GridView.builder(
          itemCount: _webImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Image.memory(_webImages[index]);
          },
        );
      }
    } else {
      return const Text("No hay imágenes en la galería");
    }
  }

// Texto de seleccion
  Future<void> _optionsDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (kIsWeb) {
                      _pickWebCameraImage();
                    }
                  },
                  child: Text("Tomar foto"),
                ),
                Padding(padding: EdgeInsets.all(8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                  child: Text("Seleccionar galería"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Mostrar galeriia
  void _toggleGallery() {
    setState(() {
      _showGallery = !_showGallery;
    });
  }
}

// Lista hamburguesa
Widget listItems(BuildContext context, VoidCallback toggleGallery) {
  return Column(
    children: [
      ListTile(
        leading: Icon(Icons.photo_album_rounded),
        title: Text("Galería"),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        onTap: () {
          toggleGallery();
          Navigator.pop(context);
        },
      ),
      const SizedBox(
        height: 8,
      ),
      ListTile(
        leading: Icon(Icons.info_outline_rounded),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        title: Text("Información de la aplicación"),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Informationpage()));
        },
      ),
    ],
  );
}

// Enlace Github
Widget githubLink() {
  const uri = "https://github.com/bryandelgado99/Firecamera";

  return Link(
    uri: Uri.parse(uri),
    target: LinkTarget.blank,
    builder: (BuildContext context, FollowLink? openLink) {
      return IconButton(
        onPressed: openLink,
        icon: const Icon(EvaIcons.github),
      );
    },
  );
}
