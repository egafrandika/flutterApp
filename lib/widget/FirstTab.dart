import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/ImagePage.dart';

class FirstTab extends StatelessWidget {
  final List<dynamic> images;

  const FirstTab({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        children: [
          for (int i = 1; i < 30; i++)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagePage(
                      tag: "wallpaper$i",
                      imageUrl: 'images/firstTab/wallpaper$i.jpg',
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: "$i",
                    child: Image.asset(
                      "images/firstTab/wallpaper$i.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
