import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/mobile-track-systems.appspot.com/o/barney%2Fdispatch_attachments%2Fwork-orders%2F1000%2F1663247953203.jpg?alt=media&token=fb623e82-e6f3-467d-9bd6-52448c3c73b6',
    'https://firebasestorage.googleapis.com/v0/b/mobile-track-systems.appspot.com/o/barney%2Fdispatch_attachments%2Fwork-orders%2F1000%2Fimage_picker_92F6B8AA-F58D-4581-86F3-1C83173AA95D-20361-0000005B3B48D6AE.jpg?alt=media&token=c5aafc85-3043-4734-8804-45aada45cbaa',
    'https://firebasestorage.googleapis.com/v0/b/mobile-track-systems.appspot.com/o/barney%2Fdispatch_attachments%2Fwork-orders%2F1000%2Fimage_picker_61C65719-6C63-407E-8AE3-3C70FC78FB25-36310-00000062F0B0B10C.jpg?alt=media&token=e922e8ee-9a50-433f-b2e0-432ee69e7a99'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showImageDialog(context: context, imageUrls: imageUrls);
              },
              child: const Text('Open Slide'),
            ),
          ],
        ),
      ),
    );
  }
}

FutureOr<void> showImageDialog({
  required BuildContext context,
  required List<String> imageUrls,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      final size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.6,
              ),
              child: Swiper(
                itemCount: imageUrls.length,
                pagination: SwiperCustomPagination(
                  builder: (context, config) {
                    devtools.log(config.activeIndex.toString());
                    return Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: size.width / 2 - 50,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              transform: Matrix4.translationValues(0, 30, 0),
                              width: 100,
                              child: Text(
                                '${config.activeIndex} / ${imageUrls.length}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.6,
                        child: Image.network(
                          imageUrls.elementAt(index),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 20,
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
