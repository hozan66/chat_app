import 'package:chat_app/shared/styles/my_colors.dart';
import 'package:flutter/material.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 45% of total width
      width: MediaQuery.of(context).size.width * 0.45,
      child: AspectRatio(
        // The ratio between width and height of the box
        aspectRatio: 3 / 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/Video Place Here.png'),
            ),
            Container(
              width: 25.0,
              height: 25.0,
              decoration: const BoxDecoration(
                color: MyColors.myPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
