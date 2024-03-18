


import 'package:flutter/material.dart';


class AskProfilePictures extends StatefulWidget {
  @override
  _AskProfilePicturesState createState() => _AskProfilePicturesState();
}

class _AskProfilePicturesState extends State<AskProfilePictures> {
  List<String> images = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Draggable<String>(
              data: images[0],
              child: DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  final s = candidateData.firstOrNull;
                  if (s != null) {
                    if (s == images[0]) {
                      return square1();
                    } else if (s == images[1]) {
                      return square2();
                    } else {
                      return square();
                    }
                  }
                    return Container(width: 100, height: 100, color: Colors.black,);
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  print('Accepted');
                },
              ),
              feedback: square1(),
              childWhenDragging: square2(),
            ),
          ],
        ),
        Row(
          children: images.map((image) {
            return Draggable<String>(
              data: image,
              child: square(),
              feedback: square2(),
              childWhenDragging: square1(),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget square() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }

  Widget square1() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
  Widget square2() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }
}
