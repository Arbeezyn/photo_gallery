import 'package:flutter/material.dart';
import 'package:photo_gallery/services/nerwork_helper.dart';

class PhotoGallery extends StatefulWidget {
  final String searchText;

  PhotoGallery(this.searchText, {Key? key}) : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  Future<List<String>>? images;

  Future<List<String>> getImages() async {
    List<String> images = [];

    for (int k = 1; k <= 5; k++) {
      String url =
          "https://api.unsplash.com/search/photos?query=${widget.searchText}&client_id=xJKUgoDgKOVnZ-flvRpBS3owfUwVjI6ojjcKw_1nsJQ&page=$k";
      NetworkHelper networkHelper = NetworkHelper(url: url);
      dynamic data = await networkHelper.getData();
      List<dynamic> resultList = data["results"];

      for (int i = 0; i < resultList.length; i++) {
        images.add(data["results"][i]["urls"]["small"]);
      }
    }

    return images;
  }

  @override
  void initState() {
    super.initState();
    images = getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Галерея"),
      ),
      body: FutureBuilder(
        future: images,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GridView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(
                          snapshot.data![index],
                          fit: BoxFit.cover,
                        );
                      }),
                ),
              );
          }
        },
      ),
    );
  }
}
