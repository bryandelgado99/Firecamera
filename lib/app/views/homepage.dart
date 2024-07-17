// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/informationPage.dart';
import 'package:url_launcher/link.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                  fit: BoxFit
                      .cover, // Hace que la imagen cubra todo el contenedor
                ),
              ),
              child: Stack(
                children: const [
                  Positioned(
                    bottom:
                        16, // Puedes ajustar esto para cambiar la posición del texto
                    left:
                        16, // Puedes ajustar esto para cambiar la posición del texto
                    child: Text(
                      "Bienvenido/a",
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
                    listItems(context),
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
      body: const Center(child: Text("Firecamera")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}

Widget listItems(BuildContext context) {
  return Column(
    children: [
      ListTile(
        leading: Icon(Icons.photo_album_rounded),
        title: Text("Galería"),
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Homepage()));
        },
      ),
      const SizedBox(
        height: 8,
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
