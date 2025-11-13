import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memory_matching_game/homeController.dart';

class customDialogbox extends StatelessWidget {
  const customDialogbox({super.key});

  @override
  Widget build(BuildContext context) {
    final Homecontroller controller = Get.find<Homecontroller>();
    return GlowContainer(
      borderRadius: BorderRadius.circular(12),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).height * 0.1,
        vertical: MediaQuery.sizeOf(context).height * 0.38,
      ),
      color: Colors.indigo[500],
      glowColor: Colors.indigoAccent,
      border: Border.all(color: Colors.indigo.shade200, width: 2.0),
      child: Column(
        children: [
          SizedBox(height: 18),
          DefaultTextStyle(
            child: Text("You Win!"),
            style: TextStyle(
              color: Colors.limeAccent,
              fontFamily: "Pixel Game",
              fontSize: 45,
            ),
          ),
          DefaultTextStyle(
            child: Text("Do you wanna Play Again ?"),
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Good timing",
              fontSize: 12,
            ),
          ),
          SizedBox(height: 12),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.limeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            onPressed: () {
              controller.startNewGame();
              Get.back();
            },
            child: Text(
              "Play Again!",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Good timing',
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
