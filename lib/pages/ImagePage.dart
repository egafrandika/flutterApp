import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ImagePage extends StatelessWidget {
  final String tag;
  final String imageUrl;

  ImagePage({required this.tag, required this.imageUrl});

  Future<void> _downloadImage(BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    String imagePath;

    if (imageUrl.contains('firstTab')) {
      imagePath = '${directory!.path}/$tag.jpg';
    } else if (imageUrl.contains('secondTab')) {
      imagePath = '${directory!.path}/$tag.jpeg';
    } else {
      imagePath = '';
    }

    final downloadUrl ='https://example.com/images/$tag.jpeg'; // Replace with the actual URL of the image

    final status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      try {
        final response = await http.get(Uri.parse(downloadUrl));
        print('testing response:${response.statusCode}');
        print('Downloaded image length: ${response.bodyBytes.length}');
        final bytes = response.bodyBytes;

        await File(imagePath).writeAsBytes(bytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image Downloaded'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download image.'),
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission not granted'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePath;
    if (imageUrl.contains('firstTab')) {
      imagePath = 'images/firstTab/$tag.jpg';
    } else if (imageUrl.contains('secondTab')) {
      imagePath = 'images/secondTab/$tag.jpeg';
    } else {
      imagePath = '';
    }
    return Scaffold(
      extendBody: true,
      body: DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.multi,
        child: Hero(
          tag: tag,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () => _downloadImage(context),
                      child: Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
