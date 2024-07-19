import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/informationPage.dart';
import 'package:url_launcher/link.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:firebase_storage/firebase_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        await _uploadImageToFirebase(bytes);
        setState(() {
          _webImage = bytes;
          _webImages.add(_webImage!);
        });
      } else {
        if (kDebugMode) {
          print('Imagen no seleccionada');
        }
      }
    }
  }

  // Imagen seleccionada
  Future<void> _pickWebCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      await _uploadImageToFirebase(bytes);
      setState(() {
        _webImage = bytes;
        _webImages.add(_webImage!);
      });
    } else {
      if (kDebugMode) {
        print('Imagen no seleccionada');
      }
    }
  }

  // Carga a Firebase
  Future<void> _uploadImageToFirebase(Uint8List imageBytes) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
      await storageRef.putData(imageBytes);
      final downloadURL = await storageRef.getDownloadURL();
      if (kDebugMode) {
        print('Descargar URL: $downloadURL');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar la imagen: $e');
      }
    }
  }

  // Pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 185, 238),
        title: const Text("Galeria",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://th.bing.com/th/id/R.a029bcc15d26dde4942b3a187412aa27?rik=VjbmPir%2bHOO2lA&pid=ImgRaw&r=0"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
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
                ? const Text("Firecamera - Tu cámara ideal")
                : Image.memory(_webImage!),
      ),
      floatingActionButton: _showGallery
          ? null
          : FloatingActionButton(
              onPressed: _optionsDialogBox,
              child: const Icon(Icons.camera_alt_rounded),
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  child: const Text("Tomar foto"),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                  child: const Text("Seleccionar galería"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Mostrar galería
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
        leading: const Icon(Icons.photo_album_rounded),
        title: const Text("Galería"),
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
        leading: const Icon(Icons.info_outline_rounded),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        title: const Text("Información de la aplicación"),
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
