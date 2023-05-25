import 'dart:io';
import 'dart:typed_data';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImagePage extends StatelessWidget {
  final String tag;
  final String assetPath;

  ImagePage({required this.tag, required this.assetPath});

  Future<void> _downloadImage(BuildContext context) async {
    String _status;
    try{
      final ByteData imageBytes = await rootBundle.load(assetPath);
      final List<int> bytes = imageBytes.buffer.asUint8List();
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/${assetPath.split('/').last}';

      await File(filePath).writeAsBytes(bytes);
      bool fileExists = await File(filePath).exists();
      if(fileExists){
        _status = "Download Complete";
      }
      else{
        _status = "Download Failed";
      }
    }
    catch(e){
      _status = "Error: $e";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_status),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imagePath;
    if (assetPath.contains('firstTab')) {
      imagePath = 'images/firstTab/$tag.jpg';
    } else if (assetPath.contains('secondTab')) {
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
                      )
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
