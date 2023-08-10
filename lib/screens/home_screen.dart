import 'package:flutter/material.dart';
import 'package:photo_gallery/screens/photo_gallery_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: myController,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    searchText = myController.text
                        .replaceAll(" ", "_")
                        .trim()
                        .toLowerCase();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PhotoGallery(searchText);
                    }));
                  },
                  child: const Text("Найти")),
            ),
          ],
        ),
      ),
    );
  }
}
