import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/informationPage.dart';
import 'package:flutter_application_1/app/views/showPasarela.dart';
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
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true; // Mostrar el ProgressIndicator
    });

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
          final bytes = await pickedFile.readAsBytes();
          // Aquí podrías subir la imagen a Firebase o realizar otra acción
          setState(() {
            _webImage = bytes;
            _webImages.add(_webImage!);
          });
      } else {
        if (kDebugMode) {
          print('Imagen no seleccionada');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al seleccionar la imagen: $e');
      }
    } finally {
      setState(() {
        _isLoading = false; // Ocultar el ProgressIndicator
      });
    }
  }

  Future<void> _pickWebCameraImage() async {
    try {
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
    } catch (e) {
      if (kDebugMode) {
        print('Error al seleccionar la imagen: $e');
      }
    }
  }

  Future<void> _uploadImageToFirebase(Uint8List imageData) async {
    // Código para subir la imagen a Firebase Storage
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child('images/${DateTime.now().toString()}.png');
      await ref.putData(imageData);
    } catch (e) {
      if (kDebugMode) {
        print('Error al subir la imagen: $e');
      }
    }
  }

  // Pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 185, 238),
        title: const Text("Centro de previsualización",
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
        child: _isLoading
            ? const CircularProgressIndicator() // Mostrar el ProgressIndicator mientras se carga
            : _webImage == null
                ? _buildGallery() // Mostrar la galería si no hay imagen cargada
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
                    _pickWebCameraImage();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        SizedBox(width: 8,),
                        Text("Tomar foto"),
                      ],
                      ),
                  )
                ),
                const SizedBox(height: 12,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.photo_album_rounded),
                        SizedBox(width: 8,),
                        Text("Escoger desde galería"),
                      ],
                      ),
                  )
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
        leading: const Icon(Icons.preview_outlined),
        title: const Text("Previsualización de imagen"),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const SizedBox(
        height: 8,
      ),
      ListTile(
        leading: const Icon(Icons.photo_album_rounded),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        title: const Text("Pasarela de fotos"),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Showpasarela()));
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
