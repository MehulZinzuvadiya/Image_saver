import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () async {
                      final boundary = key.currentContext?.findRenderObject()
                          as RenderRepaintBoundary?;
                      final image = await boundary?.toImage();
                      final byteData =
                          await image?.toByteData(format: ImageByteFormat.png);
                      final imageBytes = byteData?.buffer.asUint8List();

                      if (imageBytes != null) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/container_image.png')
                                .create();
                        await imagePath.writeAsBytes(imageBytes);
                      }
                    },
                    icon: const Icon(Icons.save)),
              ],
              title: const Text(
                "Image Saver",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                  key: key,
                  child: Center(
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        height: 200,
                        width: 400,
                        child: const Center(
                            child: Text(
                          "Hello world!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ))),
                  ),
                ),
              ],
            )));
  }
}
